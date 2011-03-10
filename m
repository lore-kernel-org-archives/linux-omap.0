From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] Watchdog: omap_wdt: add fine grain runtime-pm
Date: Thu, 10 Mar 2011 06:02:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100600390.15132@utopia.booyaka.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com> <1299754448-24888-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1438562905-1299762143=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58062 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab1CJNCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 08:02:24 -0500
In-Reply-To: <1299754448-24888-2-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: khilman@ti.com, "Cousson, Benoit" <b-cousson@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1438562905-1299762143=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Kalle,

On Thu, 10 Mar 2011, Kalle Jokiniemi wrote:

> From: Paul Walmsley <paul@pwsan.com>
>=20
> The omap_wdt should only be in full active state when the
> registers are being accessed. Otherwise the device can be
> on lower power mode.
>=20
> This patch is based on a patch created by Atal
> Shargorodsky: http://lkml.org/lkml/2009/3/10/266.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Tested-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

Regarding Beno=EEt's E-mail about this patch, I wonder if this patch is=20
still needed.  If you have the time, would you be willing to do yet=20
another test with the HWMOD_SWSUP_SIDLE patch, but without this one?


- Paul
--155748971-1438562905-1299762143=:15132--
