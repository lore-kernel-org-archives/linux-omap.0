From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4460: Hwmod: Add hwmod for thermal sensor
Date: Thu, 7 Jul 2011 03:29:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070328150.30028@utopia.booyaka.com>
References: <1309877932-27202-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1957162917-1310030961=:30028"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53345 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab1GGJ3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 05:29:22 -0400
In-Reply-To: <1309877932-27202-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1957162917-1310030961=:30028
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Tue, 5 Jul 2011, Vishwanath BS wrote:

> From: Keerthy <j-keerthy@ti.com>
>=20
> Patch adds hwmod entry for 4460 thermal sensor module. Thermal sensor mod=
ule
> is part of Control module sharing its address space and clocked via Bandg=
ap
> Functional Clock. Adding a seperate hwmod entry for thermal sensor will
> enable thermal sensor driver to manage its clock cleanly using PM runtime
> interfaces.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Vishwnath BS <vishwanath.bs@ti.com>

This needs to be coordinated with Beno=EEt, since he's the maintainer of=20
this file.  Since he's away at the moment, this is probably 3.2 material.


- Paul
--155748971-1957162917-1310030961=:30028--
