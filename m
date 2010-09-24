From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 16:30:26 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E212@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
 <20100924084344.GJ8365@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E0DC@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E128@dbde02.ent.ti.com>
 <20100924105646.GT8365@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49025 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164Ab0IXLAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 07:00:34 -0400
In-Reply-To: <20100924105646.GT8365@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi, 

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Friday, September 24, 2010 4:27 PM
>To: Kalliguddi, Hema
>Cc: Balbi, Felipe; Kevin Hilman; linux-omap@vger.kernel.org; 
>linux-usb@vger.kernel.org; Basak, Partha; Tony Lindgren; 
>Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
>Hi,
>
>On Fri, Sep 24, 2010 at 04:28:35AM -0500, Kalliguddi, Hema wrote:
>>I just noticed one more think in the code.  there are suspend/resume
>>function pointers in platform_driver structure.  Why can't we 
>use these
>>for platform specific operations like enable/disable clocks, context
>>save/restore?
>
>For doing that properly, we first need to split the HW glue layer to
>another parent platform_device/driver. Otherwise, we will have 
>all sorts
>of crazy stuff to change the function pointer depending on the ARCH.
>
Agreed,

then for now I can think of using set_clok platform function to call
the runtime pm apis, Is there any alternative you are thinking of?
 
>-- 
>balbi
>