From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PRCM: 34XX: Add PARENT_CONTROLS_CLOCK flag to dpll5_m2_ck
Date: Fri, 25 Apr 2008 11:53:29 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804251152550.28937@utopia.booyaka.com>
References: <874p9s3ebw.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-802455447-1209146009=:28937"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33262 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbYDYRxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 13:53:30 -0400
In-Reply-To: <874p9s3ebw.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-802455447-1209146009=:28937
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Apr 2008, H=F6gander Jouni wrote:

> This patch removes following message on dpll5_m2_ck enable and
> disable:
>=20
> clock.c: Enable for dpll5_m2_ck without enable code
> clock: clk_disable called on independent clock dpll5_m2_ck which has no e=
nable_reg
>=20
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
--155748971-802455447-1209146009=:28937--
