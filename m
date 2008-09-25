From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 23:28:15 +0300
Message-ID: <48DBF45F.7020601@deeprootsystems.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com> <20080925115256.GD4654@codecarver.research.nokia.com> <87vdwkmmof.fsf@deeprootsystems.com> <200809251004.12962.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:23475 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbYIYU2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 16:28:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so251429nfc.21
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 13:28:19 -0700 (PDT)
In-Reply-To: <200809251004.12962.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

David Brownell wrote:
> On Thursday 25 September 2008, Kevin Hilman wrote:
>>>> In that case, what is the proposed method for other kernel code to use
>>>> the debobs lines?
>>> Hmm, good point :) My idea was to use the gpiolib calls on GPIO12 -
>>> GPIO29, but then there is no way for a user to know if the GPIO was
>>> assigned to debobs or not... Maybe debobs should register as gpiolib
>>> 'chip' and reexport those lines ? Would that make sense ?
 >>
>> I think debobs should simply 'gpio_export' each pin.  It does not need
>> to hold them.
> 
> Peter said the right abstraction here was pads (pins/balls?) not
> GPIOs, so I'm not sure this is relevant any more, but ...
> 
> You can't gpio_export() to userspace, via sysfs, without having
> first done a gpio_request().  And then later a gpio_free() will
> release that export.  So that won't work.

Thanks Dave, I was kind of hoping you would chime in on this one :)

OK, then I guess Peter's idea of a gpio_chip type abstraction makes more 
sense.

But I'm still not sure how to best deal with the possibiltity that the 
pin might not always be a GPIO, but might be reconfigured/re-mux'd by 
this debobs interface as a debug observability pin.  My initial thought 
was to have the debobs interface gpio_request() the line if it was in 
observability mode so that nobody else could use it as a GPIO line, then 
gpio_free() it when it was put back into GPIO mode thus making it 
available to other users as a GPIO.  While that may work, it seems 
counter-intuitive and rather kludgy.  Not sure what the best way is...

Kevin
