From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Wed, 13 Apr 2016 14:57:28 +0300
Message-ID: <570E3428.5020804@ti.com>
References: <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com> <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com> <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com> <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com> <20160412163750.GR5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160412163750.GR5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/12/16 19:37, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160412 02:53]:
>> Tony,
>>
>> On 04/12/16 00:28, Tony Lindgren wrote:
>>>>> Then for the long term solution using
>>>>> PM runtime to block gating of the clock while sidetone is active =
is
>>>>> the way to go it seems.
>>>>
>>>> Hrm, I think one of the main issue is that with pm_runtime we can =
not block
>>>> the clock gating, this is why legacy code uses enable_st_clock(), =
which will
>>>> call omap2_clk_deny_idle() or omap2_clk_allow_idle().
>>>
>>> I see. I think Tero wanted to export omap2_clk_allow_idle() and
>>> omap2_clk_deny_idle() for drivers to use. That should get discussed=
 in
>>> the linux-clk list, probably best to use the pdata callbacks until
>>> the clock idling issue has been discussed.
>>
>> It is already exported, used by the arch/arm/mach-omap2/mcbsp.c file=
=2E
>=20
> Oh but not with EXPORT_SYMBOL so not usable except for built-in code.
> Probably best to keep it that way IMO..

It is up to Tero if he want to keep omap2_clk_allow/deny_idle() only be=
 usable
for built in code. It is there just because of OMAP3 McBSP2/3 sidetone =
support
on the other hand. It is a fair assumption that it could be used by the=
 driver.

>> Why not to remove the callback for legacy also and handle it in the =
driver? It
>> is less ugly in my opinion.
>> Going via the pdata callback is just going to cement the current set=
up.
>=20
> Sure, maybe you can have a piece of built-in driver code to do that?

You mean something like:
int omap3_mcbsp23_ick_for_sidetone_force(struct clk *clk, bool force_on=
)
{
	if (!clk)
		return 0;

	if (force_on)
		return omap2_clk_deny_idle(clk);
	else
		return omap2_clk_allow_idle(clk);
}
EXPORT_SYMBOL(omap3_mcbsp23_ick_for_sidetone_force);

Looks similarly hackish as with the pdata callback, but if I were to ch=
oose,
the pdata callback might be a bit more polite hack if we do not look at=
 how we
will have the pdata crafted for DT boot.

>> I have drafted out something which would be needed if we separate th=
e McBSP-ST
>> from the McBSP driver. It is not pretty...
>>
>> In the new omap3-mcbsp-st.h:
>>
>> struct omap3_mcbspst;
>>
>> struct omap_st_to_mcbsp_data {
>> 	bool (*is_enabled)(struct omap_st_to_mcbsp_data *st_data);
>> 	bool (*enable)(struct omap_st_to_mcbsp_data *st_data);
>> 	bool (*disable)(struct omap_st_to_mcbsp_data *st_data);
>> 	struct omap3_mcbspst *st_priv;
>> };
>>
>> In the current omap-mcbsp.h:
>>
>> #include <omap3-mcbsp-st.h>
>> ...
>> struct omap_mcbsp_to_st_data {
>> 	bool (*is_enabled)(struct omap_mcbsp_to_st_data *mcbsp_data);
>> 	bool (*iclk_idle)(struct omap_mcbsp_to_st_data *mcbsp_data, bool al=
low);
>> 	bool (*enable)(struct omap_mcbsp_to_st_data *mcbsp_data);
>> 	bool (*disable)(struct omap_mcbsp_to_st_data *mcbsp_data);
>> 	struct omap_mcbsp *mcbsp_priv;
>> };
>>
>> #ifdef CONFIG_SND_SOC_OMAP3_MCBSPST
>> struct omap_mcbsp_to_st_data *omap_mcbsp_st_register(
>> 						struct platform_device *pdev, /* McBSP pdev! probably? */
>> 						struct omap_st_to_mcbsp_data *st_data);
>> int omap_mcbsp_st_unregister(struct omap_st_to_mcbsp_data *st_data);
>> #else
>> static inline int omap_mcbsp_st_register(struct platform_device *pde=
v,
>> 					 struct omap_st_to_mcbsp_data *st_data)
>> {
>> 	return -ENODEV;
>> }
>> static inline int omap_mcbsp_st_unregister(struct omap_st_to_mcbsp_d=
ata *st_data)
>> {
>> 	return 0;
>> }
>> #endif
>>
>> Since the ST would be separate driver, it should create the needed A=
LSA
>> controls as well, probably I need to pass something else here and th=
ere.
>> But, in this setup it would be possible to remove the ST driver whil=
e the
>> McBSP and the sound card is up, which means we must be able to remov=
e
>> kcontrols runtime, probably there is a way, but not sure about this.
>>
>> There will be issues like this we have not prepared for I'm sure if =
we do
>> dramatic change to the simple implementation we have right now.
>=20
> Best to stick to incremental improvments I think..

If we were to split the McBSP driver into half - not literally as the S=
T
support has small amount of code right now, we would consider all possi=
bility
to not introduce regression and keep things working along the way. Ther=
e will
be a point were the code need to be shuffled..

>> I have reasonably clean patches (6 of them) on top of this three whi=
ch would
>> remove the arch code for the iclk handling and implements it in the =
mcbsp
>> driver w/o changing the architecture of the McBSP driver itself. Bot=
h DT and
>> legacy boot works. The only part I was not happy about the one where=
 I looked
>> up the mcbsp2/3_ick, but I think I have found much cleaner way to do=
 it
>> (meaning that the code will not look hackish at all).
>> If you want to see, I can make this change and I can send the whole =
thing as
>> RFC and continue the discussion around that?
>=20
> Sure, especially if that helps with splitting up the modules too.

To start with the hwmod data is wrong for mcbsp2/3 mcbsp2/3_sidetone:
static struct omap_hwmod omap3xxx_mcbsp2_hwmod =3D {
	.name		=3D "mcbsp2",
	.class		=3D &omap3xxx_mcbsp_hwmod_class,
	.mpu_irqs	=3D omap3xxx_mcbsp2_irqs,
	.sdma_reqs	=3D omap2_mcbsp2_sdma_reqs,
	.main_clk	=3D "mcbsp2_fck",
	.prcm		=3D {
		.omap2 =3D {
			.prcm_reg_id =3D 1,
			.module_bit =3D OMAP3430_EN_MCBSP2_SHIFT,
			.module_offs =3D OMAP3430_PER_MOD,
			.idlest_reg_id =3D 1,
			.idlest_idle_bit =3D OMAP3430_ST_MCBSP2_SHIFT,
		},
	},
	.opt_clks	=3D mcbsp234_opt_clks,
	.opt_clks_cnt	=3D ARRAY_SIZE(mcbsp234_opt_clks),
	.dev_attr	=3D &omap34xx_mcbsp2_dev_attr,
};

static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod =3D {
	.name		=3D "mcbsp2_sidetone",
	.class		=3D &omap3xxx_mcbsp_sidetone_hwmod_class,
	.mpu_irqs	=3D omap3xxx_mcbsp2_sidetone_irqs,
	.main_clk	=3D "mcbsp2_fck",
	.prcm		=3D {
		.omap2 =3D {
			.prcm_reg_id =3D 1,
			 .module_bit =3D OMAP3430_EN_MCBSP2_SHIFT,
			.module_offs =3D OMAP3430_PER_MOD,
			.idlest_reg_id =3D 1,
			.idlest_idle_bit =3D OMAP3430_ST_MCBSP2_SHIFT,
		},
	},
};

The McBSP2_ST main_clk is mcbsp2_ick, not mcbsp2_fck (ch 21.3.2.2.6 in
OMAP36xx TRM).
The sidetone should not have prcm section at all as it does not have co=
ntrol
over it's clocks in that level. Giving the same PRCM registers and bits=
 for
both McBSP and it's sidetone is wrong. What should be expected if McBSP=
 is
enabled and we disable the ST via pm_runtime? Will the hwmod toggle bit=
s in
PRCM? If it does, the McBSP will looses it's clocks...

While the McBSP and ST regions are different, the ST is part of the McB=
SP from
PRCM point of view so not sure how this could be worked around with sep=
arated
drivers.

--=20
P=E9ter
