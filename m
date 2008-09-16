From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: GPIO: Enable debounce clock only when debounce
 is enabled v2.
Date: Tue, 16 Sep 2008 06:36:14 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809160633320.21341@utopia.booyaka.com>
References: <873ak0mk5t.fsf@deeprootsystems.com> <1221567379-2177-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0809160618250.21341@utopia.booyaka.com> <87myi88e4w.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1525564327-1221568469=:21341"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48111 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYIPMgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:36:15 -0400
In-Reply-To: <87myi88e4w.fsf@trdhcp146196.ntc.nokia.com>
Content-ID: <alpine.DEB.1.00.0809160635140.21341@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1525564327-1221568469=:21341
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.1.00.0809160635141.21341@utopia.booyaka.com>

Hello Jouni,=20

On Tue, 16 Sep 2008, H=F6gander Jouni wrote:

> If I remove these ifdefs then I should remove also these:
>=20
> #if defined(CONFIG_ARCH_OMAP3)
> =09struct clk *dbck;
> #endif

Missed that one.  Yes, it looks fine to me to remove the ifdefs there.


- Paul
--155748971-1525564327-1221568469=:21341--
