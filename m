From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/4] gpiolib: introduce set_debounce method
Date: Wed, 31 Mar 2010 18:06:44 +0300
Message-ID: <20100331150644.GA12603@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270038435-28106-2-git-send-email-felipe.balbi@nokia.com>
 <20100331134627.GA27613@sirena.org.uk>
 <20100331145059.GA3833@gandalf>
 <20100331145919.GB6503@nokia.com>
 <20100331150402.GB12394@rakim.wolfsonmicro.main>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46215 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0CaPHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 11:07:39 -0400
Content-Disposition: inline
In-Reply-To: <20100331150402.GB12394@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 05:04:03PM +0200, ext Mark Brown wrote:
>On Wed, Mar 31, 2010 at 05:59:19PM +0300, Felipe Balbi wrote:
>> On Wed, Mar 31, 2010 at 04:50:59PM +0200, ext Felipe Balbi wrote:
>
>> >debounce time. I just used value because other functions also call it
>
>> oh yeah, in miliseconds.
>
>> >value.
>
>> maybe we could call it debounce. And switch to unsigned. Calling
>> gpio_set_debounce() with a 0 debounce time should disable it, btw.
>
>Sounds reasonable, a comment would help also.

I'm adding that. And now that I think about it, it's better to pass 
debounce time i microseconds. What do you think ?

-- 
balbi
