From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 30/33] add omap backlight support
Date: Sun, 31 Aug 2008 14:12:47 -0700
Message-ID: <200808311412.47568.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-30-git-send-email-me@felipebalbi.com> <1220116593-862-31-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27546 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758126AbYHaVTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:16 -0400
In-Reply-To: <1220116593-862-31-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Saturday 30 August 2008, Felipe Balbi wrote:
> ---
> =A0drivers/video/backlight/Kconfig =A0 | =A0 =A09 ++
> =A0drivers/video/backlight/Makefile =A0| =A0 =A01 +
> =A0drivers/video/backlight/omap_bl.c | =A0218 +++++++++++++++++++++++=
++++++++++++++
> =A03 files changed, 228 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/video/backlight/omap_bl.c

How is this different from drivers/video/backlight/omap1_bl.c
which is already upstream?

Looks to me like this is an old version of the same code, and
this driver should have been removed ... double check to make
sure no bugfixes are missing upstream.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
