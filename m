From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 6/6] OMAP4: Clock: Correct the name of SLIMBUS interface
 clocks
Date: Tue, 11 Oct 2011 13:30:02 +0200
Message-ID: <4E9428BA.1090004@ti.com>
References: <1316195330-15099-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1110061941100.4611@utopia.booyaka.com> <4E8EB6ED.9020605@ti.com> <4E8F8149.6090100@ti.com> <4E92C0D9.3090402@ti.com> <4E9364E7.80708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab1JKLaM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 07:30:12 -0400
In-Reply-To: <4E9364E7.80708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 10/10/2011 11:34 PM, Hunter, Jon wrote:
> Hi Benoit,
>=20
> On 10/10/2011 4:54, Cousson, Benoit wrote:
>> Hi Jon,
>>
>> On 10/8/2011 12:46 AM, Hunter, Jon wrote:
>>> Hi Benoit,
>>>
>>> On 10/7/2011 3:23, Cousson, Benoit wrote:
>>>> Hi Paul&  Jon,
>>>>
>>>> On 10/7/2011 3:42 AM, Paul Walmsley wrote:
>>>>> + Beno=EEt
>>>>>
>>>>> On Fri, 16 Sep 2011, Jon Hunter wrote:
>>>>>
>>>>>> From: Jon Hunter<jon-hunter@ti.com>
>>>>>>
>>>>>> Currently the interface clocks for the two SLIMBUS peripherals a=
re
>>>>>> named slimbus1_fck and slimbus2_fck. Rename these clocks to be
>>>>>> slimbus1_ick and slimbus2_ick so it is clear that these are
>>>>>> interface clocks and not functional clocks.
>>>>>>
>>>>>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>>>>>
>>>>> This one, I don't quite understand. We should probably be removin=
g
>>>>> these
>>>>> MODULEMODE-only clocks from the OMAP4 tree, and using their paren=
t
>>>>> clock
>>>>> as the main_clk. That would be a good cleanup for 3.3...
>>>>
>>>> Yes, but in order to remove that from the clock data we must ensur=
e that
>>>> the hwmod entry is there.
>>>> I kept a lot of legacy MODULEMODE clocks just because of missing h=
wmod /
>>>> runtime_pm adaptation on some drivers.
>>>>
>>>> In the case of slimbus, there is no main_clk but a bunch of option=
al
>>>> clocks. It looks similar to the DSS case. So we should not use the
>>>> parent clock as a main_clk.
>>>>
>>>> We should probably promote one of the opt_clk as the main_clk. The
>>>> slimbus_clk seems to be the good candidate for both instances.
>>>>
>>>> static struct omap_hwmod_opt_clk slimbus1_opt_clks[] =3D {
>>>> { .role =3D "fclk_1", .clk =3D "slimbus1_fclk_1" },
>>>> { .role =3D "fclk_0", .clk =3D "slimbus1_fclk_0" },
>>>> { .role =3D "fclk_2", .clk =3D "slimbus1_fclk_2" },
>>>> { .role =3D "slimbus_clk", .clk =3D "slimbus1_slimbus_clk" },
>>>> };
>>>>
>>>> static struct omap_hwmod_opt_clk slimbus2_opt_clks[] =3D {
>>>> { .role =3D "fclk_1", .clk =3D "slimbus2_fclk_1" },
>>>> { .role =3D "fclk_0", .clk =3D "slimbus2_fclk_0" },
>>>> { .role =3D "slimbus_clk", .clk =3D "slimbus2_slimbus_clk" },
>>>> };
>>>>
>>>> Jon,
>>>> Do you know if that one is indeed mandatory to use the slimbus IP?
>>>
>>> Sorry, are you asking about the clocks I was re-naming or the
>>> slimbus_clk you are referring to above?
>>
>> The clocks you are renaming should not exist at all, so I was referr=
ing
>> to the real clocks that are all listed as optional clocks.
>=20
> These clocks are the interface clocks enabled via the module-mode. So
> you are saying you want to remove the interface clocks from the list =
of
> clocks?

Yes or No, dependeing of which clock you are talking about.
The real interface clock is already handled thanks to the ocp_if struct=
ure.

/* l4_abe -> slimbus1 */
static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 =3D {
       .master         =3D &omap44xx_l4_abe_hwmod,
       .slave          =3D &omap44xx_slimbus1_hwmod,
       .clk            =3D "ocp_abe_iclk",
       .addr           =3D omap44xx_slimbus1_addrs,
       .user           =3D OCP_USER_MPU,
};

And since the modulemodule is now handled by the hwmod core thanks to t=
hat:

       .prcm =3D {
               .omap4 =3D {
                       .clkctrl_offs =3D OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_=
OFFSET,
                       .context_offs =3D OMAP4_RM_ABE_SLIMBUS_CONTEXT_O=
=46FSET,
                       .modulemode   =3D MODULEMODE_SWCTRL,
               },
       },

There is no need to create a fake leaf clock to handle the module using=
 the clock fmwk.


So we can now remove these two clock nodes from the clock44xx_data.c fi=
le:

static struct clk slimbus1_fck =3D {
	.name		=3D "slimbus1_fck",
	.ops		=3D &clkops_omap2_dflt,
	.enable_reg	=3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
	.enable_bit	=3D OMAP4430_MODULEMODE_SWCTRL,
	.clkdm_name	=3D "abe_clkdm",
	.parent		=3D &ocp_abe_iclk,
	.recalc		=3D &followparent_recalc,
};

static struct clk slimbus2_fck =3D {
	.name		=3D "slimbus2_fck",
	.ops		=3D &clkops_omap2_dflt,
	.enable_reg	=3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
	.enable_bit	=3D OMAP4430_MODULEMODE_SWCTRL,
	.clkdm_name	=3D "l4_per_clkdm",
	.parent		=3D &l4_div_ck,
	.recalc		=3D &followparent_recalc,
};

>> Usually we do need to have a main_clk in order to access the IP
>> registers (at least the sysconfig). But for some IPs, the iclk can b=
e
>> enough.
>> If the interface clock is enough, then potentially that main clock i=
s
>> not mandatory. But if one functional clock is mandatory, then we hav=
e to
>> figured out which one from the various optional functional clocks ca=
n be
>> used as the main_clk.
>>
>>> Looking at the clock tree tool, the slimbus_clk is the actual exter=
nal
>>> slimbus clock that can be generated by OMAP or by an external devic=
e.
>>>
>>> The TRM states ...
>>>
>>> "Most of the SLIMbus module runs off two main clocks: the L4 interf=
ace
>>> clock for the data input and output registers, and the control and
>>> status control registers; and the SLIMbus clock, taken from the ser=
ial
>>> interface (CLK line) for the SLIMbus-side logic.
>>>
>>> The SLIMbus controller operates as clock source component (active
>>> framer), which drives the SLIMbus clock line CLK, or as clock recei=
ver
>>> component, which gets its clock from the same CLK line."
>>>
>>> So, if you are operating as the clock source component on the bus t=
hen
>>> one of the optional clocks to drive the peripheral logic and if you=
 are
>>> the clock receiver then you use slimbus_clk.
>>
>> OK, so clearly, the slimbus_clk cannot be a main_clk. We have to che=
ck
>> if the registers can be accessed only with the iclk.
>=20
> I ran a quick test. If I just set the module mode to 0x2 (enabled), t=
hen
> I can access the registers. So no need to turn on any of the
> optional/functional clocks just the iclk.

That's good, so it looks like you will not have to populate the main_cl=
k at all.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
