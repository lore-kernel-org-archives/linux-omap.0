From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Wed, 9 Mar 2011 19:37:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091933260.15132@utopia.booyaka.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2033102017-1299724659=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39625 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab1CJChk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 21:37:40 -0500
In-Reply-To: <4D67E0C0.4080805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2033102017-1299724659=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi,

I just queued a patch to fix the SmartReflex problem.  It's the part that=
=20
fixes the incorrect data:

    http://marc.info/?l=3Dlinux-omap&m=3D129972435510631&w=3D2

Beno=EEt, if you are happy with it, care to send an Acked-by:?  Also, I=20
guess we should revisit the other part of your patch at some point.

Sanjeev, now AM3517 shouldn't need that nasty hack any more.  I hope you=20
won't need a separate array for AM35xx hwmods, either.  I guess we need to=
=20
clean up the OMAP3 id.c revision bits.


- Paul
--155748971-2033102017-1299724659=:15132--
