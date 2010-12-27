From: Felipe Balbi <balbi@ti.com>
Subject: Re: [QUESTION] what's the problem with CBUS ?
Date: Mon, 27 Dec 2010 19:18:15 +0200
Message-ID: <20101227171815.GB2235@legolas.emea.dhcp.ti.com>
References: <20101227171309.GA2235@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38478 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753546Ab0L0RSV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Dec 2010 12:18:21 -0500
Received: by mail-ey0-f178.google.com with SMTP id 5so3806082eyh.9
        for <linux-omap@vger.kernel.org>; Mon, 27 Dec 2010 09:18:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101227171309.GA2235@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Adding Tony,

forgot initially

On Mon, Dec 27, 2010 at 07:13:09PM +0200, Felipe Balbi wrote:
>Hi Tony,
>
>What was the problem you saw with N810 which caused the need for
>commit fc8c2f1dba400e9a0d1d82756e0e2f52dfe2f4b6, quoted below ?
>
>I mean, looking into the code, all retu_rtc_do_reset() does is setup a
>few default values on a few registers and that'll only be used if the
>calibration register has a value of 'zero', so I'm suspecting something
>(NOLO ?) toggles the gpio reset line on retu before giving control back
>to kernel ?!?
>
>Also, the rtc->reset_occured flag seems to be quite useless as it's
>never read, only written.
>
>When you figured you needed to disable retu_rtc_do_reset() did you get
>any Kernel Oops or N810 simply got stuck ? If it got stuck, it could be
>that nothing is calling complete(&rtc->sync), which would mean no RTC
>IRQ is happening after a reset.
>
>>Author: Tony Lindgren <tony@atomide.com>
>>Date:   Wed Nov 24 17:21:37 2010 -0800
>>
>>    cbus: Disable retu_rtc_do_reset for now
>>    Otherwise interrupts get enabled too early.
>>    This is only a temporary fix to boot N810. For
>>    some reason N800 does not need this.
>>    Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>>diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
>>index c0fe481..34fb689 100644
>>--- a/drivers/cbus/retu-rtc.c
>>+++ b/drivers/cbus/retu-rtc.c
>>@@ -309,9 +309,10 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
>>         * power */
>>        if (retu_read_reg(RETU_REG_RTCCALR) & 0x00ff)
>>                rtc->reset_occurred = 0;
>>+#if 0
>>        else
>>                retu_rtc_do_reset(rtc);
>>-
>>+#endif
>>        rtc->rtc = rtc_device_register(pdev->name, &pdev->dev, &
>>                        retu_rtc_ops, THIS_MODULE);
>
>
>-- 
>balbi

-- 
balbi
