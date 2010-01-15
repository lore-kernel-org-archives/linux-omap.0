From: Greg KH <greg@kroah.com>
Subject: Re: USB: Add empty functions in otg.h
Date: Fri, 15 Jan 2010 11:10:14 -0800
Message-ID: <20100115191014.GA24694@kroah.com>
References: <1262681218-6875-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51597 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758231Ab0AOUQx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 15:16:53 -0500
Content-Disposition: inline
In-Reply-To: <1262681218-6875-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik Mankad <x0082077@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

On Tue, Jan 05, 2010 at 02:16:58PM +0530, Maulik Mankad wrote:
>=20
> USB : Add empty functions in otg.h
>=20
> Add empty functions for usb_nop_xceiv_register() and
> usb_nop_xceiv_unregister() in otg.h so that these functions can be
> called even when CONFIG_NOP_USB_XCEIV is not enabled.=20
>=20
> It allows to remove ifdef's from board file.
>=20
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Gupta, Ajay Kumar <ajay.gupta@ti.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Oops, no, I'm rejecting this, as it breaks the build:
  CC [M]  drivers/usb/otg/nop-usb-xceiv.o
drivers/usb/otg/nop-usb-xceiv.c:41: error: redefinition of =E2=80=98usb=
_nop_xceiv_register=E2=80=99
include/linux/usb/otg.h:132: error: previous definition of =E2=80=98usb=
_nop_xceiv_register=E2=80=99 was here
drivers/usb/otg/nop-usb-xceiv.c:53: error: redefinition of =E2=80=98usb=
_nop_xceiv_unregister=E2=80=99
include/linux/usb/otg.h:136: error: previous definition of =E2=80=98usb=
_nop_xceiv_unregister=E2=80=99 was here
make[2]: *** [drivers/usb/otg/nop-usb-xceiv.o] Error 1
make[1]: *** [drivers/usb/otg] Error 2
make[1]: *** Waiting for unfinished jobs....

Doesn't anyone build their patches anymore?  Kids these days...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
