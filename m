From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP: hwmod: Add hardreset and softreset
 management
Date: Mon, 20 Sep 2010 23:03:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009202257140.17727@utopia.booyaka.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1108921327-1285045383=:17727"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab0IUFDE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 01:03:04 -0400
In-Reply-To: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, rnayak@ti.com, santosh.shilimkar@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1108921327-1285045383=:17727
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

I regret the delay -

On Thu, 5 Aug 2010, Benoit Cousson wrote:

> Here are a reset management series.
>=20
> - The first patch will be removed as soon as we will have the proper
>   OMAP4 support for the prm_xxx accessors.
> - The second one is adding hardreset support in order to allow
>   syslink driver to manage properly the DSP and IPU processor
>   reset.
> - The last one is forcing a sofreset after the first init.=20
>   Some IP might require sofreset after each wakeup
>   from power domain OFF mode. That still needs to be confirm.

I've reviewed these patches and made a few changes.  The PRM register=20
twiddling has been moved out into a prm44xx.c file.  I also added OMAP2/3=
=20
hardreset support, based on your code.  Could you take a quick look at the=
=20
updated series (in subsequent E-mails, or the git branch below) and let me=
=20
know if you are okay with it?  I took some liberties in preserving your=20
changelogs and Signed-off-by's across the changes, so please let me know=20
if you'd like any changes in that regard.

The git branch is hosted at:

git://git.pwsan.com/linux-2.6 hwmod_hardreset_dev


- Paul
--155748971-1108921327-1285045383=:17727--
