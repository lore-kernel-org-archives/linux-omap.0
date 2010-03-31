From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/4] gpiolib: introduce set_debounce method
Date: Wed, 31 Mar 2010 17:59:19 +0300
Message-ID: <20100331145919.GB6503@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270038435-28106-2-git-send-email-felipe.balbi@nokia.com>
 <20100331134627.GA27613@sirena.org.uk>
 <20100331145059.GA3833@gandalf>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45609 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab0CaPBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 11:01:04 -0400
Content-Disposition: inline
In-Reply-To: <20100331145059.GA3833@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 04:50:59PM +0200, ext Felipe Balbi wrote:
>On Wed, Mar 31, 2010 at 02:46:28PM +0100, Mark Brown wrote:
>> > +int gpio_set_debounce(unsigned gpio, int value)
>> > +{
>>
>> What are the intended semantics of value here?
>
>debounce time. I just used value because other functions also call it

oh yeah, in miliseconds.

>value.

maybe we could call it debounce. And switch to unsigned. Calling 
gpio_set_debounce() with a 0 debounce time should disable it, btw.

-- 
balbi
