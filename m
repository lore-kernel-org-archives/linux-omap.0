From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5] OMAP4: PM: Update PRCM register bitshits and masks
 for ES2
Date: Wed, 22 Sep 2010 00:17:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220014340.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1145119441-1285136232=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60216 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0IVGRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 02:17:12 -0400
In-Reply-To: <1284641906-24231-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1145119441-1285136232=:21002
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra

On Thu, 16 Sep 2010, Rajendra Nayak wrote:

> This patch updates the PRM and CM register bitshifts and masks
> for OMAP4430 ES2.0.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Beno=C3=83=C2=AEt Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, queued for 2.6.37 (with the UTF-8 fix in the patch description).

One other note:

>  #define OMAP4430_IDLEST_MASK=09=09=09=09=09BITFIELD(16, 17)

We should really get rid of all these 'BITFIELD' defines, and just replace=
=20
them with simple bitshifts.  Care to spin a patch to do that during the=20
2.6.38 timeframe?


- Paul
--155748971-1145119441-1285136232=:21002--
