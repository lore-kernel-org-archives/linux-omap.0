From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
Date: Tue, 13 Dec 2011 15:16:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com> <1323713733-13115-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2042008456-1323814586=:12046"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56717 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1LMWQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:16:27 -0500
In-Reply-To: <1323713733-13115-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2042008456-1323814586=:12046
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

a question

On Mon, 12 Dec 2011, Tero Kristo wrote:

So the patch description says:

> From: R, Govindraj <govindraj.raja@ti.com>
>=20
> Add API to determine IO-PAD wakeup event status for a given
> hwmod dynamic_mux pad.

But the code does:

> +=09for (i =3D 0; i < hmux->nr_pads; i++) {
> +=09=09struct omap_device_pad *pad =3D &hmux->pads[i];

which is going to check all of the pads, not just the dynamic ones.

So it seems to me that we need to decide whether this code should be=20
testing all the pads, or just the dynamically remuxed ones.  The same=20
thing should be decided for the code in patch 1.

Na=EFvely it seems to me that we want to test all of the pads in both=20
patches 1 and 2, not just the dynamically remuxable ones.  Comments?


- Paul
--155748971-2042008456-1323814586=:12046--
