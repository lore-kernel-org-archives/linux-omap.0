From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Mon, 27 Aug 2012 15:12:07 -0700
Message-ID: <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com> <20120827220254.GA783@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:35843 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754730Ab2H0WM2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 18:12:28 -0400
Received: by iakx26 with SMTP id x26so11808523iak.18
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 15:12:27 -0700 (PDT)
In-Reply-To: <20120827220254.GA783@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 27, 2012 at 3:02 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Mon, Aug 27, 2012 at 02:35:57PM -0700, Shilimkar, Santosh wrote:
>> > -       pr_err("%s seen by %s %s at address %x\n",
>> > +       pr_err_ratelimited("%s seen by %s %s at address %x\n",
>> >                         omap3_l3_code_string(code),
>> >                         omap3_l3_initiator_string(initid),
>> >                         multi ? "Multiple Errors" : "", address);
>> > -       WARN_ON(1);
>> > +       WARN_ON_ONCE(1);
>> >
>> The issue needs to be fixed instead of WARN_ON_ONCE() and then
>> just moving ahead. Interconnect in bad states is really bad state and you
>> won't have reliable operations post that on SOC.
>
> How printing megabytes of identical stack traces helps anything?
>
It just says repeatedly and  loudly... Fix the issue :-)

> This has been there always (since the L3 driver was added) on every boot
> with N950/N9 (which BTW are HS devices, not sure if that has anything
> to do with it). There is no apparent effect on device functionality,
> at least nothing unusual has been observed...
>
I assumed this is secure device when I saw the SRAM memset is causing the
issue.

> Is there any documentation how to interpret and debug this error report?
>
The issue could be, there is memset tried on Secure portion of SRAM or
CPU speculatively accessed adjacent SRAM region of public SRAM which
is secure and hence the error.

If you just bypass the SRAM init [1], does the issue go away ?

Regards
Santosh

[1]
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 766181c..305e6de 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -384,6 +384,7 @@ static inline int am33xx_sram_init(void)

 int __init omap_sram_init(void)
 {
+#if 0
        omap_detect_sram();
        omap_map_sram();

@@ -397,6 +398,6 @@ int __init omap_sram_init(void)
                am33xx_sram_init();
        else if (cpu_is_omap34xx())
                omap34xx_sram_init();
-
+#endif
        return 0;
 }
