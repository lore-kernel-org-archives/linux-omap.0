From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PRCM/OMAP2xxx fixes for 3.3
Date: Wed, 25 Jan 2012 14:26:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251425080.5324@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201251420490.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1266041482-1327526765=:5324"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47327 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2AYV0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 16:26:06 -0500
In-Reply-To: <alpine.DEB.2.00.1201251420490.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1266041482-1327526765=:5324
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 25 Jan 2012, Paul Walmsley wrote:

> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d=
1f:
>=20
>   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
>=20
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 omap_fixes_a_3.3rc

By the way, since Beno=EEt had already sent a fix for the OMAP1/2xxx I2C=20
build bug, I dropped my fix from this series.  So this patch is still=20
required before OMAP1/2xxx will build:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg61520.html


- Paul
--155748971-1266041482-1327526765=:5324--
