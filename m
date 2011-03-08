From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v8 6/7] omap3430: Updating the board file to use TWL4030 scripts
Date: Tue, 8 Mar 2011 12:36:08 +0530
Message-ID: <AANLkTin=qcH6PXbfKj3kQmGFBnrdJsjTJO+t+SWeM5wv@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-7-git-send-email-leslyam@ti.com>
	<87sjuy67l3.fsf@ti.com>
	<87mxl64ows.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:43064 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753967Ab1CHHGK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 02:06:10 -0500
Received: by vws18 with SMTP id 18so5131944vws.24
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 23:06:08 -0800 (PST)
In-Reply-To: <87mxl64ows.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Tue, Mar 8, 2011 at 2:40 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> Lesly A M <leslyam@ti.com> writes:
>>
>>> Using TWL4030 power scripts to control the LDOs and DCDC regulators
>>> while going to low power mode.
>>>
>>> Signed-off-by: Lesly A M <leslyam@ti.com>
>>
>> Minor: Re: Subject: OMAP is an acronym, please capitalize.
>>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: David Derrick <dderrick@ti.com>
>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>> ---
>>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0| =A0 =A03 +-
>>> =A0arch/arm/mach-omap2/board-3430sdp.c | =A0 93 +------------------=
----------------
>>> =A02 files changed, 4 insertions(+), 92 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Mak=
efile
>>> index 742ca67..bb11329 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -175,7 +175,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA) +=3D board-oma=
p3pandora.o \
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
>>> =A0obj-$(CONFIG_MACH_OMAP_3430SDP) =A0 =A0 =A0 =A0 =A0 =A0 +=3D boa=
rd-3430sdp.o \
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o \
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 board-flash.o
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 board-flash.o \
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 twl4030.o
>>
>> This should not be board-specific in the Makefile, otherwise it will
>> have to be added for every single board that uses it.
>>
>> Rather, it should probably be built as long as CONFIG_TWL4030_POWER=3D=
y.
>> Also, please be sure to build test when that option is disabled as w=
ell.
>
> Just notcied that twl4030.c is already wrapped by CONFIG_TWL4030_POWE=
R,
> so just build it for CONFIG_PM:
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 65d8701..8bdc969 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -61,7 +61,7 @@ ifeq ($(CONFIG_PM),y)
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm24xx.o
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep24x=
x.o pm_bus.o
> =A0obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o=
 sleep34xx.o \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0cpuidle34xx.o pm_bus.o
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0cpuidle34xx.o pm_bus.o twl4030.o
> =A0obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm44xx.o=
 pm_bus.o
> =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-deb=
ug.o
> =A0obj-$(CONFIG_OMAP_SMARTREFLEX) =A0 =A0 =A0 =A0 =A0+=3D sr_device.o=
 smartreflex.o
>
>
> Then, you'll also have to modify twl4030.h so that
> twl4030_generic_script is NULL when CONFIG_TWL_4030=3Dn so board file=
s
> will still compile.

Ok, I will do it.

Thanks & Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
