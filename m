From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 1/2] Watchdog: omap_wdt: add fine grain runtime-pm
Date: Fri, 11 Mar 2011 07:32:22 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06655F@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1299754448-24888-2-git-send-email-kalle.jokiniemi@nokia.com>
 <alpine.DEB.2.00.1103100600390.15132@utopia.booyaka.com>
 <alpine.DEB.2.00.1103100603380.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:42937 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333Ab1CKHck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 02:32:40 -0500
In-Reply-To: <alpine.DEB.2.00.1103100603380.15132@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, b-cousson@ti.com, tony@atomide.com, linux-omap@vger.kernel.org



> -----Original Message-----
> From: ext Paul Walmsley [mailto:paul@pwsan.com]
> Sent: 10. maaliskuuta 2011 15:04
> To: Jokiniemi Kalle (Nokia-MS/Tampere)
> Cc: khilman@ti.com; Cousson, Benoit; tony@atomide.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] Watchdog: omap_wdt: add fine grain runtime-p=
m
>=20
> On Thu, 10 Mar 2011, Paul Walmsley wrote:
>=20
> > Regarding Beno=EEt's E-mail about this patch, I wonder if this patc=
h is
> > still needed.  If you have the time, would you be willing to do yet
> > another test with the HWMOD_SWSUP_SIDLE patch, but without this one=
?
>=20
> Sigh, I take this back.  I don't think it will work without the fine-=
grained
> runtime PM control patch, since the WDTIMER will be in no-idle the en=
tire
> time.

Yes, correct...

- Kalle

>=20
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
