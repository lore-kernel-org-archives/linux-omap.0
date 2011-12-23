From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 23 Dec 2011 17:05:09 +0800
Message-ID: <CACVXFVOmVZH+cZ6fZhwMkTfzV02FfJDJDTE+4XabGPeqbsfJtg@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
	<CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
	<CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
	<CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
	<CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
	<CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
	<CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44529 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab1LWJFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Dec 2011 04:05:09 -0500
Received: by pbdu13 with SMTP id u13so4025425pbd.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Dec 2011 01:05:09 -0800 (PST)
In-Reply-To: <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Miguel Vadillo <vadillo@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

On Fri, Dec 23, 2011 at 4:45 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Dec 23, 2011 at 2:00 PM, Ming Lei <tom.leiming@gmail.com> wro=
te:
>> Hi Shilimkar,
>>
>> Sorry for the delay.
>>
>> On Mon, Dec 19, 2011 at 2:17 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>
>>> The patches are fine but I am surprised that 'dyndep.patch' is help=
ing you.
>>> L3_2 dependency is always enabled with ISS or Camera and it
>>> should have worked.
>>> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm), shoudn't do anything since
>>> the bit is read-only.
>>
>> Yes, you are right. After some investigating, I found that
>> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm) returns failure, so clkdms_se=
tup
>> is bypassed and the issue is avoided.
>>
> Good.
>
>>>
>>> Can you check value of CM_CAM_STATICDEP [ 0x4A009004],
>>
>> The value is 0x40 after and before the patch.
>>
>>> after your patch. I am suspecting that for some reason l3_1 dep.
>>> is getting enabled which might be helping your case.
>>
>> Seems no changes after adding clkdm_add_wkdep(iss_clkdm, l3_1_clkdm)
>> on the problem.
>>
>> The only change on iss(CAM) clock domain setting in your commit[1] i=
s to
>> configure CLKTRCTRL as HW_AUTO, instead of previous =A0SW_WKUP.
>> Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
>> fixed, so I am wondering if something is wrong about HW_AUTO mode
>> of CAM clock domain.
>>
> Now I recollect the issue and also track a patch in the internal prod=
uct tree.
> Same is attached and also in the end of the email.
>
> I am lopping Miguel who wrote the patch and Benoit who acked it.
> This should sort out your issue as you have already verified it works=
=2E

Yes, I am sure.

> Regards
> Santosh
>
> From 972d7bb544d3197d7fc1a6c6eb0e2c9cc08d5e9d Mon Sep 17 00:00:00 200=
1
> From: Miguel Vadillo <vadillo@ti.com>
> Date: Tue, 21 Jun 2011 09:59:45 -0500
> Subject: [PATCH 1/2] OMAP: clockdomain: set iss clk domain to just SW=
SUP
>
> Since CAM domain(ISS) has no module wake-up dependency
> with any other clock domain of the device and the dynamic
> dependency from L3_main_2 is always disabled, the domain
> needs to be in force wakeup in order to be able to access
> it for configure(sysconfig) it or use it.
>
> Also since there is no clock in the domain managed automatically
> by the hardware, there is no use to configure automatic
> clock domain transition. SW should keep the SW_WKUP domain
> transition as long as a module in the domain is required to
> be functional.
>
> Signed-off-by: Miguel Vadillo <vadillo@ti.com>
> Acked-by: Benoit Cousson<b-cousson@ti.com>

Please feel free to add:

       Reported-and-tested-by: Ming Lei <ming.lei@canonical.com>

> ---
> =A0arch/arm/mach-omap2/clockdomains44xx_data.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
> b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index 6ac8fe2..8d1a061 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -605,7 +605,7 @@ static struct clockdomain iss_44xx_clkdm =3D {
> =A0 =A0 =A0 =A0.clkdm_offs =A0 =A0 =A0 =3D OMAP4430_CM2_CAM_CAM_CDOFF=
S,
> =A0 =A0 =A0 =A0.wkdep_srcs =A0 =A0 =A0 =3D iss_wkup_sleep_deps,
> =A0 =A0 =A0 =A0.sleepdep_srcs =A0 =A0=3D iss_wkup_sleep_deps,
> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_HWSUP_SWSUP=
,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_SWSUP,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_O=
MAP44XX),
> =A0};
>
> --
> 1.7.4.1


thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
