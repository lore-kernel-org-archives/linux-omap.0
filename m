From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/8] OMAP2+: hwmod: upgrade per-hwmod mutex to a
 spinlock
Date: Tue, 14 Dec 2010 21:03:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142059230.15971@utopia.booyaka.com>
References: <20101116101615.22777.49212.stgit@twilight.localdomain> <20101116101809.22777.92945.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-602981943-1292385804=:15971"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53925 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab0LOEDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 23:03:24 -0500
In-Reply-To: <20101116101809.22777.92945.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-602981943-1292385804=:15971
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kevin, Beno=C3=AEt,

On Tue, 16 Nov 2010, Paul Walmsley wrote:

> Change the per-hwmod mutex to a spinlock.  (The per-hwmod lock
> serializes most post-initialization hwmod operations such as enable,
> idle, and shutdown.)  Spinlocks are needed, because in some cases,
> hwmods must be enabled from timer interrupt disabled-context, such as
> an ISR.  The current use-case that is driving this is the OMAP GPIO
> block ISR: it can trigger interrupts even with its clocks disabled,
> but these clocks are needed for register accesses in the ISR to succeed.

The more I think about this patch, the less I like it.  At some point it=20
would be good to try to convert the OMAP clock code to using mutexes in as=
=20
many places as possible, rather than spinlocks.  When that happens, this=20
is going to be a liability.  Nevertheless I will leave it this patch in=20
for now by request, but this is just a simultaneous request: as we review=
=20
these hwmod conversions, we need to be very careful with any code that=20
will attempt to call the hwmod functions from timer-interrupt-disabled=20
context ... we should try to discourage it if at all possible and if that=
=20
is not possible, to put a big fat XXX comment there to review the=20
situation...


- Paul
--155748971-602981943-1292385804=:15971--
