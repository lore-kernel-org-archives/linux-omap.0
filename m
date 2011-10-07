From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 6/6] OMAP4: Clock: Correct the name of SLIMBUS interface
 clocks
Date: Thu, 6 Oct 2011 19:42:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061941100.4611@utopia.booyaka.com>
References: <1316195330-15099-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2106079947-1317951766=:4611"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32949 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758321Ab1JGBmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 21:42:47 -0400
In-Reply-To: <1316195330-15099-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2106079947-1317951766=:4611
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

+ Beno=EEt

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
>=20
> Currently the interface clocks for the two SLIMBUS peripherals are
> named slimbus1_fck and slimbus2_fck. Rename these clocks to be
> slimbus1_ick and slimbus2_ick so it is clear that these are
> interface clocks and not functional clocks.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

This one, I don't quite understand.  We should probably be removing these=
=20
MODULEMODE-only clocks from the OMAP4 tree, and using their parent clock=20
as the main_clk.  That would be a good cleanup for 3.3...


- Paul
--155748971-2106079947-1317951766=:4611--
