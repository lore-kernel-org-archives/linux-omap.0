From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: USB: Add empty functions in otg.h
Date: Mon, 18 Jan 2010 14:32:47 +0200
Message-ID: <20100118123247.GB4082@nokia.com>
References: <1262681218-6875-1-git-send-email-x0082077@ti.com>
 <20100115191014.GA24694@kroah.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30688 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab0ARMdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 07:33:23 -0500
Content-Disposition: inline
In-Reply-To: <20100115191014.GA24694@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Greg KH <greg@kroah.com>
Cc: Maulik Mankad <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

On Fri, Jan 15, 2010 at 08:10:14PM +0100, ext Greg KH wrote:
>On Tue, Jan 05, 2010 at 02:16:58PM +0530, Maulik Mankad wrote:
>>
>> USB : Add empty functions in otg.h
>>
>> Add empty functions for usb_nop_xceiv_register() and
>> usb_nop_xceiv_unregister() in otg.h so that these functions can be
>> called even when CONFIG_NOP_USB_XCEIV is not enabled.
>>
>> It allows to remove ifdef's from board file.
>>
>> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>> Acked-by: Olof Johansson <olof@lixom.net>
>> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> Cc: Gupta, Ajay Kumar <ajay.gupta@ti.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
>Oops, no, I'm rejecting this, as it breaks the build:
>  CC [M]  drivers/usb/otg/nop-usb-xceiv.o
>drivers/usb/otg/nop-usb-xceiv.c:41: error: redefinition of =E2=80=98us=
b_nop_xceiv_register=E2=80=99
>include/linux/usb/otg.h:132: error: previous definition of =E2=80=98us=
b_nop_xceiv_register=E2=80=99 was here
>drivers/usb/otg/nop-usb-xceiv.c:53: error: redefinition of =E2=80=98us=
b_nop_xceiv_unregister=E2=80=99
>include/linux/usb/otg.h:136: error: previous definition of =E2=80=98us=
b_nop_xceiv_unregister=E2=80=99 was here
>make[2]: *** [drivers/usb/otg/nop-usb-xceiv.o] Error 1
>make[1]: *** [drivers/usb/otg] Error 2
>make[1]: *** Waiting for unfinished jobs....
>
>Doesn't anyone build their patches anymore?  Kids these days...

Maulik, you have to handle the case where the driver is build as a=20
dynamically linked module, so:

#if defined(CONFIG_USB_NOP_XCEIV) || defined(CONFIG_USB_NOP_XCEIV_MODUL=
E)

something like that.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
