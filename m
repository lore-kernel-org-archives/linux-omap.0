From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 4/4]usb : musb:USB driver using omap_device_build for
 device registration.
Date: Mon, 28 Jun 2010 19:28:29 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027019200F@dbde02.ent.ti.com>
References: <1277727427-6144-1-git-send-email-hemahk@ti.com>
 <20100628132912.GG2822@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940270191FE9@dbde02.ent.ti.com>
 <20100628134209.GH2822@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940270191FFE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab0F1N6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 09:58:41 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270191FFE@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

 

>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org 
>[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Kalliguddi, Hema
>Sent: Monday, June 28, 2010 7:17 PM
>To: Tony Lindgren
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Felipe Balbi
>Subject: RE: [PATCH 4/4]usb : musb:USB driver using 
>omap_device_build for device registration.
>
> 
>
>>-----Original Message-----
>>From: Tony Lindgren [mailto:tony@atomide.com] 
>>Sent: Monday, June 28, 2010 7:12 PM
>>To: Kalliguddi, Hema
>>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; 
>Felipe Balbi
>>Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
>>omap_device_build for device registration.
>>
>>* Kalliguddi, Hema <hemahk@ti.com> [100628 16:26]:
>>>  
>>> 
>>> >-----Original Message-----
>>> >From: Tony Lindgren [mailto:tony@atomide.com] 
>>> >Sent: Monday, June 28, 2010 6:59 PM
>>> >To: Kalliguddi, Hema
>>> >Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; 
>>Felipe Balbi
>>> >Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
>>> >omap_device_build for device registration.
>>> >
>>> >* Hema HK <hemahk@ti.com> [100628 15:12]:
>>> >> -
>>> >> -	/*
>>> >> -	 * REVISIT: This line can be removed once all the 
>>> >platforms using
>>> >> -	 * musb_core.c have been converted to use use clkdev.
>>> >> -	 */
>>> >> -	musb_plat.clock = "ick";
>>> >
>>> >This comment is still valid, please don't remove it.
>>> This is still there. It is moved below under else.
>>
Yes. The comment is being removed in the patch I posted. I will keep it.
Regards,
Hema
>>Tony
>>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>