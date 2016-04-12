From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Tue, 12 Apr 2016 12:52:14 +0300
Message-ID: <570CC54E.6020703@ti.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com> <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com> <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com> <20160411212845.GJ5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160411212845.GJ5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 04/12/16 00:28, Tony Lindgren wrote:
>>> Then for the long term solution using
>>> PM runtime to block gating of the clock while sidetone is active is
>>> the way to go it seems.
>>
>> Hrm, I think one of the main issue is that with pm_runtime we can no=
t block
>> the clock gating, this is why legacy code uses enable_st_clock(), wh=
ich will
>> call omap2_clk_deny_idle() or omap2_clk_allow_idle().
>=20
> I see. I think Tero wanted to export omap2_clk_allow_idle() and
> omap2_clk_deny_idle() for drivers to use. That should get discussed i=
n
> the linux-clk list, probably best to use the pdata callbacks until
> the clock idling issue has been discussed.

It is already exported, used by the arch/arm/mach-omap2/mcbsp.c file.

>=20
>>>> The ST does not have clocks coming from PRCM level, it only uses t=
he McBSP
>>>> iclk when it is enabled (the McBSP block of the McBSP). As far as =
pm_runtime
>>>> goes I think the ST module should not use it. We can not tell hwmo=
d to
>>>> enable/disable the McBSP2/3 iclk when we pm_runtime for the ST. It=
 does not
>>>> help at all. We can have nop action for the ST when pm_runtime is =
used, but
>>>> then why would we have it?
>>>
>>> Using PM runtime in the sidetone driver should just work as long as=
 the
>>> sidetone device driver depends on the McBSP driver before it gets p=
robed.
>>> The clock framework handles things for the mcbsp ick with the useco=
unt.
>>
>> Yes, that is not the problem. The problem is that when McBSP is used=
 w/o
>> sidetone the iclk can and should be autogated, but if the sidetone i=
s enabled
>> then the iclk must not autogate and this needs to be prevented in PR=
CM level.
>> Note also that while the McBSP is running we must be able to enable/=
disable
>> the sidetone any time w/o affecting the McBSP operation.
>=20
> OK I see.
>=20
>>> And doing pm_runtime_get() in the sidetone driver will do what the =
legacy
>>> enable_st_clock() does currently.
>>
>> it can't do that as we do not have way to deny/enable just the autoi=
dle for a
>> given clock.
>=20
> Yup. So I suggest the pdata callbacs for the omap2_clk_allow_idle() a=
nd
> omap2_clk_deny_idle() for now.

Why not to remove the callback for legacy also and handle it in the dri=
ver? It
is less ugly in my opinion.
Going via the pdata callback is just going to cement the current setup.

>>>>> So having two separate drivers might make things a lot simpler.
>>>>
>>>> Not really. It will make things way more complicated imho. How to =
handle
>>>> legacy boot as we still have that supported?
>>>
>>> Hey both the legacy driver and DT driver are really just platform d=
evices
>>> and drivers. And passing both dts and platform data can be done jus=
t
>>> fine, no?
>>
>> Sure, but McBSP2-ST needs to bind with McBSP2 driver instance and th=
e
>> McBSP3-ST should bind with McBSP3 instance. In legacy mode we can st=
ore the
>> McBSP pdev pointers in a array and use the devid or get the McBSP id=
 from the
>> device name. While with DT boot we must have phandle pointing to/fro=
m ST
>> from/to McBSP node to be able to figure out who is who.
>>
>>>> When the McBSP driver is loaded we must know if it has sidetone or=
 not so
>>>> we can create the needed audio controls, sysfs entries. The sysfs =
and
>>>> kcontrol registration could be moved out to the new ST driver, tru=
e.
>>>
>>> Yeah during the probe, the sidetone driver must register with the M=
cBSP
>>> driver to tell it's there.
>>
>> When McBSP driver probes, it registers itself to ASoC core and it ne=
eds to
>> know at that point if we need to prepare for ST or not. So probably =
the McBSP
>> driver needs to register to ST driver?
>=20
> OK yes if that makes more sense.

I have drafted out something which would be needed if we separate the M=
cBSP-ST
from the McBSP driver. It is not pretty...

In the new omap3-mcbsp-st.h:

struct omap3_mcbspst;

struct omap_st_to_mcbsp_data {
	bool (*is_enabled)(struct omap_st_to_mcbsp_data *st_data);
	bool (*enable)(struct omap_st_to_mcbsp_data *st_data);
	bool (*disable)(struct omap_st_to_mcbsp_data *st_data);
	struct omap3_mcbspst *st_priv;
};

In the current omap-mcbsp.h:

#include <omap3-mcbsp-st.h>
=2E..
struct omap_mcbsp_to_st_data {
	bool (*is_enabled)(struct omap_mcbsp_to_st_data *mcbsp_data);
	bool (*iclk_idle)(struct omap_mcbsp_to_st_data *mcbsp_data, bool allow=
);
	bool (*enable)(struct omap_mcbsp_to_st_data *mcbsp_data);
	bool (*disable)(struct omap_mcbsp_to_st_data *mcbsp_data);
	struct omap_mcbsp *mcbsp_priv;
};

#ifdef CONFIG_SND_SOC_OMAP3_MCBSPST
struct omap_mcbsp_to_st_data *omap_mcbsp_st_register(
						struct platform_device *pdev, /* McBSP pdev! probably? */
						struct omap_st_to_mcbsp_data *st_data);
int omap_mcbsp_st_unregister(struct omap_st_to_mcbsp_data *st_data);
#else
static inline int omap_mcbsp_st_register(struct platform_device *pdev,
					 struct omap_st_to_mcbsp_data *st_data)
{
	return -ENODEV;
}
static inline int omap_mcbsp_st_unregister(struct omap_st_to_mcbsp_data=
 *st_data)
{
	return 0;
}
#endif

Since the ST would be separate driver, it should create the needed ALSA
controls as well, probably I need to pass something else here and there=
=2E
But, in this setup it would be possible to remove the ST driver while t=
he
McBSP and the sound card is up, which means we must be able to remove
kcontrols runtime, probably there is a way, but not sure about this.

There will be issues like this we have not prepared for I'm sure if we =
do
dramatic change to the simple implementation we have right now.

>>> I guess no need to pass anything in the
>>> dts or platform_data for that.
>>>
>>>> I actually started with two separate drivers approach first, but d=
ecided that
>>>> it does not worth the effort (legacy boot support, pm_runtime/hwmo=
d hassle,
>>>> platform data, callback API design, etc).
>>>> I know, it is not rocket science but it is king of shoot out of ca=
nnon into
>>>> sparrows.
>>>> I'll think about it for a little while ;)
>>>
>>> Well what we've seen so far is that any kind of non-standard soluti=
on
>>> will always be a pain to maintain in the long run :)
>>
>> The current implementation (one driver to handle McBSP and the ST) i=
s there
>> ever since OMAP3 was introduced afaik. Changing a working (was worki=
ng) design
>> to something which has not been tested will for sure going to open i=
ssues we
>> have not prepared for.
>> I would avoid the rewrite of a proven driver architecture if it is n=
ot broken.
>=20
> Well probably the best thing to do is the use of platform callback
> for now until we know how it can be done incrementally :)

I have reasonably clean patches (6 of them) on top of this three which =
would
remove the arch code for the iclk handling and implements it in the mcb=
sp
driver w/o changing the architecture of the McBSP driver itself. Both D=
T and
legacy boot works. The only part I was not happy about the one where I =
looked
up the mcbsp2/3_ick, but I think I have found much cleaner way to do it
(meaning that the code will not look hackish at all).
If you want to see, I can make this change and I can send the whole thi=
ng as
RFC and continue the discussion around that?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
