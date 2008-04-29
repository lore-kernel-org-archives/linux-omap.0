From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] PRCM: Combine 34xx l3_icks and l4_icks
Date: Tue, 29 Apr 2008 00:58:28 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804290057130.5853@utopia.booyaka.com>
References: <873ap69ybi.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-730117927-1209452308=:5853"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59136 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYD2G63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 02:58:29 -0400
In-Reply-To: <873ap69ybi.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, ext Tony Lindgren <tony@atomide.com>, igor.stoppa@nokia.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-730117927-1209452308=:5853
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Apr 2008, H=F6gander Jouni wrote:

> E.g dss_l3_ick and dss_l4_ick have same gating control. Having own
> clock for both of them causes race condition between enable / disable.
>=20
> This patch combines this kind of clocks and names new clock as <module>_i=
ck.
>=20
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

although it's less of a race issue, than it is a convenience issue for=20
OMAP2/3 device driver folks...



- Paul
--155748971-730117927-1209452308=:5853--
