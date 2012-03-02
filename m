From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get
 rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK
Date: Thu, 1 Mar 2012 18:08:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203011808070.22980@utopia.booyaka.com>
References: <1330609674-20826-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-401838149-1330650517=:22980"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab2CBBIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 20:08:38 -0500
In-Reply-To: <1330609674-20826-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Balaji TK <balajitk@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-401838149-1330650517=:22980
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Mar 2012, Rajendra Nayak wrote:

> This is useful when we have broken type2 compliant IPs' where
> the softreset shift is not the same as SYSC_TYPE2_SOFTRESET_SHIFT
> and hence is overridden using sysc_fields->srst_shift.
>=20
> We have atleast one such instance now with onchip keypad on OMAP5
> which has a different softreset shift as compared to other type2
> IPs'.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Balaji TK  <balajitk@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> Paul,
>=20
> I based the patch on top of your reset/data cleanup series
> for hwmod. So its based on 'hwmod_data_cleanup_3.4' branch.

Thanks, Beno=EEt's ack added and queued.


- Paul
--155748971-401838149-1330650517=:22980--
