From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for
 GPT1
Date: Thu, 10 Mar 2011 01:45:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-731033937-1299746728=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1CJIp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:45:29 -0500
In-Reply-To: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-731033937-1299746728=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Mar 2011, Paul Walmsley wrote:

> From: Rajendra Nayak <rnayak@ti.com>
>=20
> Some issues seen (which cause lockups in suspend) with GPT1
> after the MPU<->L4_WKUP static dependency was cleared can be
> Worked-around for now by forcing GPT1 in software
> controlled idle.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Beno=EEt Cousson <b-cousson@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Just a quick note, I missed Beno=EEt's update of the commit message:

    http://www.spinics.net/linux/lists/linux-omap/msg48008.html

and he's the maintainer of this so we should use his instead.  The revised=
=20
message is below.


- Paul

OMAP4: hwmod data: Temporarily disable hardware-controlled idle for timer1
   =20
Some issues seen (which cause lockups in suspend) with timer1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing timer1 in software
controlled idle.
   =20
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson: Update the changelog and the subject]
Signed-off-by: Beno=EEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>

--155748971-731033937-1299746728=:15132--
