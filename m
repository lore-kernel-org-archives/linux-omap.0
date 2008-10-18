From: David Brownell <david-b@pacbell.net>
Subject: Fwd: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
Date: Sat, 18 Oct 2008 12:13:18 -0700
Message-ID: <200810181213.18616.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:31986 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753762AbYJRTNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Oct 2008 15:13:21 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, Samuel Ortiz <sameo@openedhand.com>

Note the MODULE_AUTHOR comment from Alessandro ... anyone
want to fess up?  :)

GIT history suggests  Dmitry Krivoschekov did the original
patch, Alexandre Rusev morphed some TI code into the RTC
framework, and some anonymous TI person started the work.
But I'm not sure I'd trust those inferences.


----------  Forwarded Message  ----------

Subject: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
Date: Saturday 18 October 2008
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com

On Fri, 17 Oct 2008 19:15:08 -0700
David Brownell <david-b@pacbell.net> wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> This adds a driver for the RTC inside the TWL4030 multi-function device.
> It's a fairly basic RTC, with a wake-capable alarm.
> 
> Note that many of the pre-release Overo boards now in circulation can't
> effectively use this RTC, because of a wiring error that puts its TWL
> chip into "secure" mode.  (As in "secure yourself against tampering".)
> This isn't an issue on other OMAP3 boards now supported in mainline,
> such as Beagle and Labrador.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

  Acked-by: Alessandro Zummo <a.zummo@towertech.it>

 I'd love to see an email in MODULE_AUTHOR
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it


-------------------------------------------------------
