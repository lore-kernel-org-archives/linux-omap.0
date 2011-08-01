From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: timing in driver function
Date: Mon, 1 Aug 2011 21:04:52 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09A78D@dbde03.ent.ti.com>
References: <4E36C30E.9060809@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38621 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1HAPjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 11:39:06 -0400
In-Reply-To: <4E36C30E.9060809@matrix-vision.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Michael Jones wrote:
> I have a function in a driver which takes ~50ms to execute, which I've
> measured by reading jiffies at the beginning and end. But jiffies only
> counts at 128Hz on my system, so this was a very coarse measurement. Now
> I would like to find out more exactly where the time is going inside
> this function. So my basic question is, what is the best way to measure
> lapsed time with reasonable resolution on an OMAP?
> 
> As I had done with the jiffies measurement, what I imagined was
> inserting lines into my function, sampling the value of some counter at
> various points within it. This approach is crude but simple and would
> suffice for my case.
> 
> Since it must be a very common task, I thought I'd ask here what the
> recommended approach is. I see a few directions...
> 
> 1. Using the OMAP's 32kHz timer, which is provided as a "struct
> clocksource". It seems like what I would want is to call
> clocksource_32k.read(), but I don't know how to retrieve clocksource_32k.
> 

If you're looking for a one-off profiling, then as a hack, you could
export a function that unconditionally returns the value of the 32kHz
timer's count register (32KSYNCNT_CR) and use that for profiling.

- Anand
