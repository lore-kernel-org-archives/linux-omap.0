From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: Re: [PATCH 0/3] omap3: devkit8000: misc fixes
Date: Fri, 14 Jan 2011 10:44:46 +0100
Message-ID: <1294998286.3458.13.camel@morsing>
References: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
	 <4D300DC8.7000803@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1ANJoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 04:44:32 -0500
Received: by bwz15 with SMTP id 15so2360442bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 01:44:31 -0800 (PST)
In-Reply-To: <4D300DC8.7000803@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, 2011-01-14 at 09:48 +0100, Thomas Weber wrote:
> Hello Daniel,
> 
> the LCD_PWREN is connected to TWL4030 LEDA only.
> The TWL4030 GPIO.1 has a not connected resistor (R61).
> 
> My test case is:
> 
> # echo 0 > /sys/devices/omapdss/display0/enabled
> # echo 1 > /sys/devices/omapdss/display0/enabled
> 
> 
> I changed your patch the following way.

I just checked and you are correct. This would also mean that the
pullup/pulldown patch is incorrect since gpio.1 is now not connected and
should be pulled down.

> I think I cannot write a sign-off-by for you.

Fine by me.

> Author: Daniel Morsing <daniel.morsing@gmail.com>

I don't think i can rightfully call myself the author of this patch
anymore :)

Regards,
Daniel


