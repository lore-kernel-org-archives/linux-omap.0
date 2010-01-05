From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 1/2] USB: Add empty functions in otg.h
Date: Tue, 5 Jan 2010 11:53:07 -0600
Message-ID: <20100105175307.GA27177@lixom.net>
References: <1262681218-6875-1-git-send-email-x0082077@ti.com> <20100105105450.GD11291@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:46134 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab0AERqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jan 2010 12:46:25 -0500
Content-Disposition: inline
In-Reply-To: <20100105105450.GD11291@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Maulik Mankad <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

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
