From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: linux-omap vs N810
Date: Mon, 28 Apr 2008 02:00:32 +0300
Message-ID: <1209337232.8988.8.camel@mort>
References: <55288.89.77.111.170.1209333669.squirrel@mail.gen2.org>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63567 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbYD0XK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Apr 2008 19:10:26 -0400
In-Reply-To: <55288.89.77.111.170.1209333669.squirrel@mail.gen2.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext astralstorm@gen2.org" <astralstorm@gen2.org>
Cc: linux-omap@vger.kernel.org

On Mon, 2008-04-28 at 00:01 +0200, ext astralstorm@gen2.org wrote:
> Hello,
> I'm having a major problem running linux-omap kernel on Nokia N810.
> After correct build and flashing (tested by the use of self-built patched
> Nokia kernel) the device seems to hang before framebuffer initialization,
> then is rebooted by the watchdog. Manual FB update is disabled, I've
> checked the configuration in many possible ways.
> 
> I'd like to hear about possible causes of that.
> 
> I do not have the serial console wired in (yet_, but would still like to
> get debugging output. What would you recommend?

Do you have it in RD mode with no-lifeguard-reboots (check flasher
options)? If it's a reboot performed by the sw watchdog because some
component is crashing too many times, you could get a bit further in the
boot sequence, maybe to the point of ssh into the tablet.

-- 
Cheers, Igor

---

Igor Stoppa
Next Generation Software
Nokia Devices R&D - Helsinki
