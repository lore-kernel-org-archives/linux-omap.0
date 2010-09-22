From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/5] OMAP4: clocks: Update clock tree for ES2
Date: Tue, 21 Sep 2010 23:03:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009212300560.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <1284641906-24231-3-git-send-email-rnayak@ti.com> <1284641906-24231-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2028730998-1285131834=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37584 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab0IVFDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 01:03:55 -0400
In-Reply-To: <1284641906-24231-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2028730998-1285131834=:21002
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Rajendra, Beno=C3=AEt,

On Thu, 16 Sep 2010, Rajendra Nayak wrote:

> This patch updates the clock tree with all the
> changes in OMAP4430 ES2.
>=20
> clock nodes added
> -1- tie_low_clock_ck
> -2- abe_dpll_bypass_clk_mux_ck
>=20
> clock nodes deleted
> -1- dpll_sys_ref_clk
> -2- per_sgx_fclk
> -3- usbphyocp2scp_ick
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Beno=C3=83=C2=AEt Cousson <b-cousson@ti.com>

UTF-8 problem again here...

> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

The clock tree resulting from this patch doesn't match the output from=20
the current OMAP4 clock autogen script.  Seems like it should.  Could you=
=20
help me understand that?


thanks

- Paul
--155748971-2028730998-1285131834=:21002--
