From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] Watchdog: omap_wdt: add fine grain runtime-pm
Date: Thu, 10 Mar 2011 06:04:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100603380.15132@utopia.booyaka.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com> <1299754448-24888-2-git-send-email-kalle.jokiniemi@nokia.com> <alpine.DEB.2.00.1103100600390.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-518403939-1299762267=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58092 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab1CJNE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 08:04:28 -0500
In-Reply-To: <alpine.DEB.2.00.1103100600390.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: khilman@ti.com, "Cousson, Benoit" <b-cousson@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-518403939-1299762267=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Mar 2011, Paul Walmsley wrote:

> Regarding Beno=EEt's E-mail about this patch, I wonder if this patch is=
=20
> still needed.  If you have the time, would you be willing to do yet=20
> another test with the HWMOD_SWSUP_SIDLE patch, but without this one?

Sigh, I take this back.  I don't think it will work without the=20
fine-grained runtime PM control patch, since the WDTIMER will be in=20
no-idle the entire time.

- Paul
--155748971-518403939-1299762267=:15132--
