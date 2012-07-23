From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 09/12] ARM: OMAP4: hwmod data: temporarily comment out
 data for the sl2if IP block
Date: Mon, 23 Jul 2012 12:38:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207231236210.10781@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-510488304-1343068713=:10781"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36149 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab2GWSie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 14:38:34 -0400
In-Reply-To: <1342704392-23657-10-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-510488304-1343068713=:10781
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tero

On Thu, 19 Jul 2012, Tero Kristo wrote:

> The OMAP4 sl2if IP block requires some special programming for it to
> enter idle. Without this programming, they will prevent the rest of
> the chip from entering full chip idle.
>=20
> This patch comments out the IP block data.
>=20
> Later, once the appropriate support is available, this patch can be
> reverted.
>=20
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Originally I was hoping that we could apply a real fix for this one.  But=
=20
looking at the proposed alternative in the old SL2IF E-mail threads, I'm=20
still not convinced by what's proposed there.  So we'd better take this=20
one for the time being.

Queued for 3.6-rc.

- Paul
--155748971-510488304-1343068713=:10781--
