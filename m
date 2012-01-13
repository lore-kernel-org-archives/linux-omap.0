From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 17:04:08 +0530
Message-ID: <CAAL8m4yW-FSYa0-A2FLzwd+0JmRZx25g7jknc7a2BdvZMZFPUA@mail.gmail.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown>
 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown>
 <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33440 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900Ab2AMLea convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:34:30 -0500
Received: by lago2 with SMTP id o2so215643lag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 03:34:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Fri, Jan 13, 2012 at 3:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> cc Tero, Govindraj
>
> On Thu, 12 Jan 2012, NeilBrown wrote:
>
>> On Wed, 11 Jan 2012 06:43:04 -0700 (MST) Paul Walmsley <paul@pwsan.c=
om> wrote:
>>
>> I spent some time exploring why cpuidle never drops below state 0 an=
d found
>> out that the code explicitly disables other states when uart is acti=
ve - for
>> a fairly broad definition of 'active'.
>>
>> I found the "sleep_timeout" setting and set them all to 1 second. =A0=
This meant
>> that cpuidle started working, but I got a lot of garbage characters.
>>
>
> ...
>
>> Does this really mean CPU_IDLE cannot be used when you might expect =
chars
>> from a serial port - e.g. GPS or Bluetooth?
>
> Hmmm. =A0Looking at mach-omap2/pm34xx.c and mach-omap2/cpuidle34xx.c,=
 it
> indeed prevents even the MPU from entering a low-power state when the=
 UART
> is active, as you write. =A0That doesn't seem correct.
>
> Please try the following patch. =A0It works fine for me on v3.2 with
> omap2plus_defconfig on a 35xx BeagleBoard. =A0No dropped or garbled
> characters with console use. =A0Not too surprising, since the UART ha=
s a
> receive FIFO to withstand interrupt servicing delays.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 13 Jan 2012 02:10:30 -0700
> Subject: [PATCH] ARM: OMAP3: PM: allow MPU to enter low-power states =
even
> =A0when the UART is active
>
> For some reason, both the existing OMAP3 PM code and the OMAP3 CPUIdl=
e
> driver prevent the MPU powerdomain from entering low-power modes when
> any UART isn't asleep. =A0Possibly it is intended to minimize the ARM
> wakeup latency when UART activity arrives, but the UART has a FIFO
> that should handle this for most cases, with no dropped characters. =A0=
I
> may be forgetting something important, though. =A0And CORE/PER low-po=
wer
> states are a different matter entirely.
>
> Thanks to NeilBrown <neilb@suse.de> for reporting the problem.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joe Woodward <jw@terrafix.co.uk>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 =A08 +++-----
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 10 ----------
> =A03 files changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 942bb4f..4ef32d4 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -183,6 +183,9 @@ static int next_valid_state(struct cpuidle_device=
 *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0core_deepest_state =3D=
 PWRDM_POWER_OFF;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (!omap_uart_can_sleep())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D PWRDM_POWER_ON;
> +

omap_uart_can_sleep is removed part of uart runtime conversion,
and is no more available on latest mainline, looks like uart runtime
patches got merged after 3.2 tagging.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
