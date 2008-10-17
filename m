From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/6] Hook twl4030 power code into twl4030 core.
Date: Thu, 16 Oct 2008 17:18:31 -0700
Message-ID: <200810161718.31361.david-b@pacbell.net>
References: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com> <1224077854-23481-3-git-send-email-peter.de-schrijver@nokia.com> <1224077854-23481-4-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:23464 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752813AbYJQASd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 20:18:33 -0400
In-Reply-To: <1224077854-23481-4-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 15 October 2008, Peter 'p2' De Schrijver wrote:
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_TC6387XB)=A0=A0=A0=A0+=3D tc6387xb=
=2Eo
> =A0obj-$(CONFIG_MFD_TC6393XB)=A0=A0=A0=A0=A0+=3D tc6393xb.o
> =A0
> =A0obj-$(CONFIG_TWL4030_CORE)=A0=A0=A0=A0=A0+=3D twl4030-core.o
> +obj-$(CONFIG_TWL4030_POWER)=A0=A0=A0=A0+=3D twl4030-power.o
> =A0
> =A0obj-$(CONFIG_MFD_CORE)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D mfd-core.o
> =A0

This won't apply against current GIT, because of the twl4030-irq.o=20
updates.


Other than those minor tweaks, I'd say this should merge soon,
so we are more on track for mainlining *all* the components of
the twl4030 "core".

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
