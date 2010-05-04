From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH v3] arm: Fix .gitignore for boot/compressed folder
Date: Tue, 4 May 2010 08:10:13 -0500
Message-ID: <A24693684029E5489D1D202277BE8944551B97F3@dlee02.ent.ti.com>
References: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
 <20100503195855.GA18647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50966 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab0EDNK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 09:10:27 -0400
In-Reply-To: <20100503195855.GA18647@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Albin Tonnerre <albin.tonnerre@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell,

=46rom: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
Sent: Monday, May 03, 2010 2:59 PM
> On Mon, May 03, 2010 at 02:51:25PM -0500, Sergio Aguirre wrote:
> > This should complement changes done in:
> >
> >   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
> >   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
> >   Date:   Fri Jan 8 14:42:43 2010 -0800
> >
> >       arm: add support for LZO-compressed kernels
> >
> > It missed to do the respective changes in '.gitignore' file.
> >
> > Also, add vmlinux to the list, which is generated also during
> > the build.
> >
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Ok.

Thanks!

Regards,
Sergio
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
