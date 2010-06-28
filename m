From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 4/4]usb : musb:USB driver using omap_device_build for
 device registration.
Date: Mon, 28 Jun 2010 19:02:33 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270191FE9@dbde02.ent.ti.com>
References: <1277727427-6144-1-git-send-email-hemahk@ti.com>
 <20100628132912.GG2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51806 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813Ab0F1Nco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 09:32:44 -0400
In-Reply-To: <20100628132912.GG2822@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

 

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com] 
>Sent: Monday, June 28, 2010 6:59 PM
>To: Kalliguddi, Hema
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Felipe Balbi
>Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
>omap_device_build for device registration.
>
>* Hema HK <hemahk@ti.com> [100628 15:12]:
>> -
>> -	/*
>> -	 * REVISIT: This line can be removed once all the 
>platforms using
>> -	 * musb_core.c have been converted to use use clkdev.
>> -	 */
>> -	musb_plat.clock = "ick";
>
>This comment is still valid, please don't remove it.
This is still there. It is moved below under else.

Regards,
Hema
>
>Regards,
>
>Tony
>