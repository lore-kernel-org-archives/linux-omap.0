From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch] omap: usb: ehci: fix use of hcd->regs
Date: Fri, 12 Sep 2008 09:32:56 -0700
Message-ID: <200809120932.57016.david-b@pacbell.net>
References: <20080912121024.GG759@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:40876 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752727AbYILQc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2008 12:32:59 -0400
In-Reply-To: <20080912121024.GG759@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Friday 12 September 2008, Felipe Balbi wrote:
> - =A0 =A0 =A0 hcd->regs =3D (void __iomem *) (int) IO_ADDRESS(hcd->rs=
rc_start);
> + =A0 =A0 =A0 hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_len);

This is missing its sibling iounmap() ...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
