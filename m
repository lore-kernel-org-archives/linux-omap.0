From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 14:58:35 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E128@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
 <20100924084344.GJ8365@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E0DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46806 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab0IXJ2n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 05:28:43 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E0DC@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

 

>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org 
>[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Kalliguddi, Hema
>Sent: Friday, September 24, 2010 2:23 PM
>To: Balbi, Felipe
>Cc: Kevin Hilman; linux-omap@vger.kernel.org; 
>linux-usb@vger.kernel.org; Basak, Partha; Tony Lindgren; 
>Cousson, Benoit; Paul Walmsley
>Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
>Felipe,
> 
>
>>-----Original Message-----
>>From: Balbi, Felipe 
>>Sent: Friday, September 24, 2010 2:14 PM
>>To: Kalliguddi, Hema
>>Cc: Kevin Hilman; Balbi, Felipe; linux-omap@vger.kernel.org; 
>>linux-usb@vger.kernel.org; Basak, Partha; Tony Lindgren; 
>>Cousson, Benoit; Paul Walmsley
>>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis 
>for musb.
>>
>>Hi,
>>
>>On Fri, Sep 24, 2010 at 03:16:29AM -0500, Kalliguddi, Hema wrote:
>>>>I guess that's Felipe's call, but I don't like that option.
>>>>
>>>>I think it's cleaner to have the ->set_clock hook be a noop on OMAP
>>>>and the runtime hooks be noops on the other platforms.
>>>>
>>>I think the set_clock function was used for setting the platform
>>>specific clocks for different architecture. Anyway we need 
>>this hook or
>>>some other hook once we start handling the optional clocks 
>>and internal
>>>phy clocks for musb.  Since this is already exists I thought 
>of making
>>>use of it instand of adding another hook.
>>>
>>>Felipe, What do you say?
>>
>>Ideally we will get rid of those. It's only a matter of 
>getting DaVinci
>>to fully support clkdev. We should not have wrappers on top of clk
>>framework neither pass down clock names as platform_data to driver,
>>that's insane.
>>
>I think we will need to have some hooks for handling the clocks for
>different platform as each platforms will have different clocks.
>The way we are using set_clock is not the wrapper on top clock 
>frameowrk,
>it is a platform hook to enabling the clocks which still uses 
>the clock framework.
>
>~Hema
>
I just noticed one more think in the code.
there are suspend/resume function pointers in platform_driver structure.
Why can't we use these for platform specific operations like enable/disable clocks, context save/restore?

>>-- 
>>balbi
>>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>