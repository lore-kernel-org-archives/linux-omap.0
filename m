From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: hwmod: support to specify the bit position of
 clockactivity bits
Date: Thu, 10 Dec 2009 01:43:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912100141480.2780@utopia.booyaka.com>
References: <1259335571-13183-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1770734915-1260434606=:2780"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758321AbZLJInV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 03:43:21 -0500
In-Reply-To: <1259335571-13183-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1770734915-1260434606=:2780
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Thara,

On Fri, 27 Nov 2009, Thara Gopinath wrote:

> Some modules like OMAP3 Smartreflex do not have the regular sysconfig
> register.Instead clockactivity bits are part of another register at a
> different bit position than the usual bit positions 8 and 9. This patch
> introduces a flag SYSC_CHANGE_CLKACT_OFFSET which if specified the hwmod =
driver
> takes the bit position of clockactivity bits from clockact_offs specified=
 as
> part of omap_hwmod_sysconfig. Else the default positions are used.

I think Beno=EEt has a patch that also makes the offsets configurable for=
=20
some of the other bitfields.  Apparently these also can change on a per-IP=
=20
basis... =20


- Paul
--155748971-1770734915-1260434606=:2780--
