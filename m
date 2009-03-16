From: Diego Dompe <diego.dompe@ridgerun.com>
Subject: Re: OpenGL ES 2.0 support under DSS2 kernel?
Date: Mon, 16 Mar 2009 09:09:47 -0600
Message-ID: <96E483A8-91F2-48DE-9748-3A4F928D488E@ridgerun.com>
References: <1fbf6fafac32c58f505001ce87cf0f35.squirrel@localhost>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:52135 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbZCPQAG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 12:00:06 -0400
In-Reply-To: <1fbf6fafac32c58f505001ce87cf0f35.squirrel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david.hagood@gmail.com
Cc: linux-omap@vger.kernel.org

Take a look at the OpenEmbedded kernel for Beagleboard. It has working  
PowerVR drivers for recent kernel.

On Mar 16, 2009, at 9:05 AM, david.hagood@gmail.com wrote:

> Does anybody have any pointers on getting the kernel driver for the
> PowerVR OpenGL ES2.0 hardware working under the current Linux kernel  
> with
> the DSS2 patches?
>
> I am trying to get accelerated X working in order to test if it will  
> be
> able to do what I need to do.
>
> Currently the Xsgx X server won't work, as the drivers for the PowerVR
> graphics acceleration are missing from the DSS2 kernel, so that  
> leaves me
> dead in the water.
>
> Just to be clear: I am *not* talking about power management, I am  
> talking
> about the PowerVR graphic accelerator core for OpenGL support (yes,  
> I am
> repeating my self redundantly, but I have had some people contact me  
> who I
> think are confusing the two).
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

