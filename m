From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 4/4]usb : musb:USB driver using omap_device_build for
 device registration.
Date: Tue, 29 Jun 2010 17:54:44 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027019259C@dbde02.ent.ti.com>
References: <1277727427-6144-1-git-send-email-hemahk@ti.com>
 <4C29D378.90408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37682 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0F2MZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 08:25:00 -0400
In-Reply-To: <4C29D378.90408@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>

 Hello,

>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov@mvista.com] 
>Sent: Tuesday, June 29, 2010 4:35 PM
>To: Kalliguddi, Hema
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; 
>Felipe Balbi; tony@atomide.com
>Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
>omap_device_build for device registration.
>
>Hello.
>
>Hema HK wrote:
>
>> From: Hema HK  <hemahk@ti.com>
>
>    I think the patch description has clarity issues...
>
>> Changed the musb driver to use omap_build_device api instead of 
>
>    I don't see where are you changing the MUSB driver.

There is function name mismatch in the description.it should be "omap_device_build" instead of omap_build_device.
The change is in usb-musb.c file. I agree that it is not a driver file.I will change the description appropriately.

>
>> platform_device_registration.
>
>    Why underscores here?
>
I intended to provide the API name here platform_device_register. I will correct it.

>> The device specific resources defined in 
>> centralized database will be used. So removed the resource 
>definitions from
>> the driver file.
>
>    Do you mean usb-musb.c here? This is certainly not a driver.
>
Agreed not a driver.

Regards,
Hema
>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Cc: Felipe Balbi <felipe.balbi@nokia.com>,tony@atomide.com
>
>WBR, Sergei
>
>