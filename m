From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] arm: omap4: allow disabling MPU local timer if 32K timer
 is enabled
Date: Sat, 11 Feb 2012 18:19:41 +0800
Message-ID: <CACVXFVNJ=L_H_whTm6AyEc++B=Tw_Jfnzmn-QRYwbbBqiH7H1g@mail.gmail.com>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
	<20120211100351.GB13587@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40460 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab2BKKTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Feb 2012 05:19:42 -0500
Received: by daed14 with SMTP id d14so3039803dae.19
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 02:19:41 -0800 (PST)
In-Reply-To: <20120211100351.GB13587@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 11, 2012 at 6:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Feb 11, 2012 at 04:31:25PM +0800, Ming Lei wrote:
>> With 32K gp timer, tick can be driven and system can run well, so
>> allow MPU local timer to be disabled if someone requires it, otherwise
>> MPU local timer is always chosen as the default clock_event_device.
>
> The point being?

IMO, 32K gp timer may be more energy-saving than MPU local timer
because gp timer has much less clock frequency and only half interrupts
generated in tick mode compared with mpu local timer.

>
> What if you want to use NO_HZ?

32K gp timer supports oneshot mode, so it should support NO_HZ.  In my test
.config, NO_HZ is enabled and system can run well.

thanks,
-- 
Ming Lei
