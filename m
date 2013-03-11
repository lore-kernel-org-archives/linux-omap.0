From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: hwmod data: disable MIDLEMODE control for
 musb
Date: Mon, 11 Mar 2013 16:53:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303111648370.9211@utopia.booyaka.com>
References: <1362876391-6801-1-git-send-email-notasas@gmail.com> <alpine.DEB.2.00.1303102304490.774@utopia.booyaka.com> <CANOLnOMUHzbGW-Yz_cXhW1+KNvP-4k6vMDodE94K5G2pwrSf7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1414836376-1363020801=:9211"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54321 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3CKQxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 12:53:21 -0400
In-Reply-To: <CANOLnOMUHzbGW-Yz_cXhW1+KNvP-4k6vMDodE94K5G2pwrSf7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1414836376-1363020801=:9211
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Gra=C5=BEvydas,

On Mon, 11 Mar 2013, Grazvydas Ignotas wrote:

> Soft reset seems to recover from this so there is no problem, but you
> can't reset before every suspend so a workaround is still needed..

OK, that's good.

> Well as long as it works it's good for me, although it'll bloat the
> code a bit compared to just changing the data. Should I attempt an
> implementation?

Please do.  I'd be shocked if it comes out to more than four or five extra=
=20
ARM instructions...


- Paul
--843723315-1414836376-1363020801=:9211--
