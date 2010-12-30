From: Ben Gamari <bgamari@gmail.com>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 11:20:33 -0500
Message-ID: <87zkrnmdv2.fsf@gmail.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56659 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab0L3QUi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Dec 2010 11:20:38 -0500
In-Reply-To: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Fri,  3 Dec 2010 23:42:45 +0530, Ajay Kumar Gupta <ajay.gupta@ti.com=
> wrote:
> As the control.h have been moved to new location and it's
> uses are not allowed to drivers directly so moving the phy
> control, interrupt clear and reset functionality to board
> files.
>=20
I could have sworn I tried applying this before but I guess I must be
wrong. Perhaps I am missing something?=20

  CC      arch/arm/mach-omap2/usb-musb.o
arch/arm/mach-omap2/usb-musb.c: In function =E2=80=98am35x_musb_phy_pow=
er=E2=80=99:
arch/arm/mach-omap2/usb-musb.c:45: error: implicit declaration of funct=
ion =E2=80=98omap_ctrl_readl=E2=80=99
arch/arm/mach-omap2/usb-musb.c:45: error: =E2=80=98AM35XX_CONTROL_DEVCO=
NF2=E2=80=99 undeclared (first use in this function)
arch/arm/mach-omap2/usb-musb.c:45: error: (Each undeclared identifier i=
s reported only once
arch/arm/mach-omap2/usb-musb.c:45: error: for each function it appears =
in.)
arch/arm/mach-omap2/usb-musb.c:50: error: implicit declaration of funct=
ion =E2=80=98omap_ctrl_writel=E2=80=99
arch/arm/mach-omap2/usb-musb.c: In function =E2=80=98am35x_musb_clear_i=
rq=E2=80=99:
arch/arm/mach-omap2/usb-musb.c:78: error: =E2=80=98AM35XX_CONTROL_LVL_I=
NTR_CLEAR=E2=80=99 undeclared (first use in this function)
arch/arm/mach-omap2/usb-musb.c:79: error: =E2=80=98AM35XX_USBOTGSS_INT_=
CLR=E2=80=99 undeclared (first use in this function)
arch/arm/mach-omap2/usb-musb.c: In function =E2=80=98am35x_musb_set_mod=
e=E2=80=99:
arch/arm/mach-omap2/usb-musb.c:86: error: =E2=80=98AM35XX_CONTROL_DEVCO=
NF2=E2=80=99 undeclared (first use in this function)
arch/arm/mach-omap2/usb-musb.c: In function =E2=80=98usb_musb_init=E2=80=
=99:
arch/arm/mach-omap2/usb-musb.c:175: error: expected expression before =E2=
=80=98}=E2=80=99 token


- Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
