From: David Brownell <david-b@pacbell.net>
Subject: (non-hs)mmc vs lockdep
Date: Thu, 20 Nov 2008 10:56:28 -0800
Message-ID: <200811201056.28399.david-b@pacbell.net>
References: <ef0d8a250811200202o5852dabct8c5b135b86141f67@mail.gmail.com> <20081120173206.GL4927@atomide.com> <20081120174236.GQ7476@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:35728 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756258AbYKTS4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 13:56:43 -0500
In-Reply-To: <20081120174236.GQ7476@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thursday 20 November 2008, Felipe Balbi wrote:
> > > =A0TI OMAP MMC INTERFACE DRIVER
> > > =A0P: =A0 =A0 Carlos Aguiar, Anderson Briglia and Syed Khasim
> > > =A0M: =A0 =A0 linux-omap@vger.kernel.org
> >=20
> >=20
> > Yeah sure. Let's also add maintainers for omap subsystems that have
> > maintainers while we're at it.
>=20
> sounds good. At least mmc is already there.

So, who's going to fix the bug with the non-highspeed MMC controller
driver whereby it breaks with LOCKDEP enabled?

The "BUG_ON(irqs_disabled());" in mmc_omap_start_request() triggers,
since something inside the latest ARM MM code assumes it's never called
with IRQs blocked ... a regression was introduced at some point.  The
same failure is seen in some other MMC controller drivers.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
