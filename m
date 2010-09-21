From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP: hwmod: Add hardreset and softreset
 management
Date: Tue, 21 Sep 2010 10:09:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211006360.21792@utopia.booyaka.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1009202257140.17727@utopia.booyaka.com> <4C98D7A1.9080400@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1925040719-1285085360=:21792"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40606 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab0IUQJV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:09:21 -0400
In-Reply-To: <4C98D7A1.9080400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1925040719-1285085360=:21792
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Tue, 21 Sep 2010, Cousson, Benoit wrote:

> That's really good. The low level reset does indeed belong to PRM more th=
an
> the hwmod core code.
> Thanks for the OMAP2/3 stuff as well, IVA people were starting to ping me=
 for
> that support.
>=20
> I've just rebased my OMAP4 hwmods series on top on this one, and it work =
fine.

Cool.

> Are you targeting that series for 2.6.37?

Yep, I'll send those patches to the linux-arm-kernel mailing list today,=20
along with the other hwmod base patches; I'd like to get those in for=20
2.6.37.

> I have a couple of patches on top of that code that will fix the softrese=
t
> with optional clocks. This code is fixing the GPIO reset issue that I obs=
erved
> in the past.
>=20
> I'll send you that soon.

OK, sounds good.  If you cc the linux-arm-kernel mailing list when you=20
send them out, that will make it easier to add those to the 2.6.37 queue=20
if they arrive on time.

Thanks for the review and for the comments,


- Paul
--155748971-1925040719-1285085360=:21792--
