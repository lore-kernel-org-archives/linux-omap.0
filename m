From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH v3 1/2] USB: Add empty functions in otg.h
Date: Fri, 8 Jan 2010 11:26:16 +0530
Message-ID: <001701ca9027$4b6401d0$808918ac@apr.dhcp.ti.com>
References: <1262681218-6875-1-git-send-email-x0082077@ti.com> <20100105105450.GD11291@nokia.com> <20100105175307.GA27177@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49148 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab0AHF43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 00:56:29 -0500
In-Reply-To: <20100105175307.GA27177@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 'Olof Johansson' <olof@lixom.net>, 'Felipe Balbi' <felipe.balbi@nokia.com>, 'Tony Lindgren' <tony@atomide.com>

Greg,

Are you going to include this patch in your queue?

Thanks,
Maulik

-----Original Message-----
From: Olof Johansson [mailto:olof@lixom.net] 
Sent: Tuesday, January 05, 2010 11:23 PM
To: Felipe Balbi
Cc: ext Maulik Mankad; linux-usb@vger.kernel.org;
linux-omap@vger.kernel.org; Tony Lindgren; Greg Kroah-Hartman; Sergei
Shtylyov; Gupta, Ajay Kumar
Subject: Re: [PATCH v3 1/2] USB: Add empty functions in otg.h

On Tue, Jan 05, 2010 at 12:54:50PM +0200, Felipe Balbi wrote:
> On Tue, Jan 05, 2010 at 09:46:58AM +0100, ext Maulik Mankad wrote:
>> USB : Add empty functions in otg.h
>>
>> Add empty functions for usb_nop_xceiv_register()
>> and usb_nop_xceiv_unregister() in otg.h so that
>> these functions can be called even when
>> CONFIG_NOP_USB_XCEIV is not enabled.
>>
>> It allows to remove ifdef's from board file.
>>
>> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>
> Now this patch looks ok.

Don't you mean Acked-by?

Anyway, also:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof

