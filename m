From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/4] ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk()
 API
Date: Mon, 18 Jun 2012 10:23:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206181022370.11642@utopia.booyaka.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com> <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1667863020-1340036583=:11642"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39205 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab2FRQXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 12:23:04 -0400
In-Reply-To: <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1667863020-1340036583=:11642
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 20 Apr 2012, Tarun Kanti DebBarma wrote:

> Add an API to get main clock name associated with a given @oh.
> This will avoid the need to construct fclk names during early
> initialization in order to get fclk handle using clk_get().
>=20
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>=20
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Thanks, queued for 3.6 with Beno=EEt's ack.


- Paul
--155748971-1667863020-1340036583=:11642--
