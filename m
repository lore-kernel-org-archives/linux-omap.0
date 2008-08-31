From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Sun, 31 Aug 2008 14:06:13 -0700
Message-ID: <200808311406.14234.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-21-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27523 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758081AbYHaVTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:11 -0400
In-Reply-To: <1220116593-862-22-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Saturday 30 August 2008, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0| =A0 13 +-
> =A0drivers/mmc/host/Makefile =A0 =A0 | =A0 =A01 +
> =A0drivers/mmc/host/omap_hsmmc.c | 1069 +++++++++++++++++++++++++++++=
++++++++++++
> =A03 files changed, 1082 insertions(+), 1 deletions(-)
> =A0create mode 100644 drivers/mmc/host/omap_hsmmc.c

OK, this one may need cleanup ... but I don't disagree that it
should go upstream.

Now the process for getting it there involves posting to LKML
and probably CCing the MMC maintainer...

One reason I'd like to see this particular driver upstream is
so that folk using www.beagleboard.org hardware can stand a
real chance of using mainline kernels for development.  That's
a small set of drivers, so that's a very achievable goal.



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
