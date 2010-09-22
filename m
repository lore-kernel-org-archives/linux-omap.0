From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/5] OMAP4: powerdomain: Update DSS logic state for ES2
Date: Wed, 22 Sep 2010 00:22:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220021360.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <1284641906-24231-3-git-send-email-rnayak@ti.com> <1284641906-24231-4-git-send-email-rnayak@ti.com>
 <1284641906-24231-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-273882203-1285136525=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47558 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab0IVGWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 02:22:07 -0400
In-Reply-To: <1284641906-24231-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-273882203-1285136525=:21002
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra,

On Thu, 16 Sep 2010, Rajendra Nayak wrote:

> DSS on ES2 supports only OSWR, hence remove the support
> for CSWR from the powerdomain framework.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Beno=C3=83=C2=AEt Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, queued for 2.6.37 (with Beno=C3=AEt's name fixed)

- Paul
--155748971-273882203-1285136525=:21002--
