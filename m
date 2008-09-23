From: "arun c" <arun.edarath@gmail.com>
Subject: Re: PM related problem with dispc controller
Date: Tue, 23 Sep 2008 03:03:03 -0400
Message-ID: <c656a4d20809230003g49e646bck5967fbdfb403ea7e@mail.gmail.com>
References: <87skrr5pck.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:3124 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbYIWHDF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 03:03:05 -0400
Received: by ti-out-0910.google.com with SMTP id b6so934602tic.23
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 00:03:04 -0700 (PDT)
In-Reply-To: <87skrr5pck.fsf@trdhcp146196.ntc.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 23, 2008 at 2:49 AM, H=F6gander Jouni
<jouni.hogander@nokia.com> wrote:
> Hi,
>
> I'm debugging pm-0 branch with SDP board and seeing lots of dispc
> related error printouts:
>
> / # <4>__ratelimit: 453 callbacks suppressed
> __ratelimit: 453 callbacks suppressed
> <3>omapfb omapfb: irq error status 00e2
> omapfb omapfb: irq error status 00e2
> <3>omapfb omapfb: irq error status 00e2
> omapfb omapfb: irq error status 00e2
> <3>omapfb omapfb: irq error status 00c0
> omapfb omapfb: irq error status 00c0
> <3>omapfb omapfb: irq error status 0062
> omapfb omapfb: irq error status 0062
> <3>omapfb omapfb: irq error status 00c2
> omapfb omapfb: irq error status 00c2
>
> The error bit in all these statuses is "GFXFIFOUNDERFLOW". Is this
> something that could happen e.g. in a case that mpu wake-up from wfi
> takes too long? I mean is there some interrupt that should be served
> faster? Or is this taken care by sdma/hw triggering and now sdma is
> not capable to fill the fifo for reason or another?
>
> I have cpuidle enabled and it is "forced" to select only C1 or
> C0. This means tha MPU, NEON, CORE and PER are always
> ON/INACTIVE. Display is also on and there is penguin logo on it. When
> I see these error messages there is also flickering on the display.
>
> This far I had found that on mpu wfi something is switched off
> sometimes. I can see that from consumption of SDP board. Sometimes
> consumption is much lower on wfi even if the states of domains are
> same. When this happens, also these omapfb irq errors begin to happen=
=2E
>
> I can workaround this problem by disabling DSS_ICK AUTOIDLE. Another
> workaround is to disable hw supervised mode for core_l3_clkdm or
> core_l4_clkdm.

Try disabling the smart standby feature of DISPC

Below is the patch for the same

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index ce4c4de..7c868d5 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -1399,7 +1399,7 @@ static int omap_dispc_init(struct omapfb_device *=
fbdev, in
        /* Enable smart standby/idle, autoidle and wakeup */
        l =3D dispc_read_reg(DISPC_SYSCONFIG);
        l &=3D ~((3 << 12) | (3 << 3));
-       l |=3D (2 << 12) | (2 << 3) | (1 << 2) | (1 << 0);
+       l |=3D (2 << 3) | (1 << 2) | (1 << 0);
        dispc_write_reg(DISPC_SYSCONFIG, l);
        omap_writel(1 << 0, DSS_BASE + DSS_SYSCONFIG);

Regards,
Arun C


>
> All comments and ideas are welcome.
>
> --
> Jouni H=F6gander
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
