From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] twl4030 driver changes
Date: Thu, 25 Sep 2008 11:38:55 -0500
Message-ID: <e438802b0ef1048ea1a492e3c8240ec8@felipebalbi.com>
References: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com> <200809250926.12900.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33788 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbYIYQjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 12:39:00 -0400
In-Reply-To: <200809250926.12900.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>



On Thu, 25 Sep 2008 09:26:12 -0700, David Brownell <david-b@pacbell.net>
wrote:
> On Thursday 25 September 2008, Felipe Balbi wrote:
>> Move twl4030 keypad and usb to new style of
>> registration for twl4030 driver
> 
> I can tell I'm going to need to accelerate my
> GPIO updates!  :)
> 
> Cool.  I'll look at this after breakfast...

ehehe, I'm planning on playing with madc tomorrow, so
maybe yeah, we're gonna need your gpio changes soonish :-)

on the other hand, remember I already had a patch converting
twl4030-usb to platform_device, I just had to update a few
stuff and that was it :-p

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

