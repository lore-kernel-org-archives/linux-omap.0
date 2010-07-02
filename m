From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/13] OMAP2&3: hwmod: Remove _hwmod prefix in name
 string
Date: Fri, 2 Jul 2010 05:47:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007020546360.13691@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-6-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-407591231-1278071240=:13691"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40309 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191Ab0GBLrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 07:47:21 -0400
In-Reply-To: <1277336563-24988-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-407591231-1278071240=:13691
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> From: Benoit Cousson <b-cousson@ti.com>
>=20
> In the lastest OMAP4 hwmod data file, the _hwmod was removed
> in order to save some memory space and because it does not
> bring a lot.
> Align OMAP2420, 2430 and 3430 data files with the same convention.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

I've taken Beno=EEt's original patch for this, so have converted your=20
Signed-off-by: into an Acked-by: for this patch.


- Paul
--155748971-407591231-1278071240=:13691--
