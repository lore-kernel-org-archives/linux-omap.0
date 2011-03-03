From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Wed, 2 Mar 2011 23:08:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103022303560.10981@utopia.booyaka.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <4D5BCC10.2060301@ti.com> <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com> <4D5E85EA.70605@ti.com> <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com> <e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com>
 <alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com> <19850e063c924a8a30c69ac02621a659@mail.gmail.com> <4D6D2589.3090505@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1743776589-1299132480=:10981"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56166 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab1CCGIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 01:08:01 -0500
In-Reply-To: <4D6D2589.3090505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1743776589-1299132480=:10981
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Tue, 1 Mar 2011, Cousson, Benoit wrote:

> So to conclude, I will drop the #3 and just push #1 and #2.
>=20
> #1 is fine with addition of the WARN.

We should probably drop this one now that _setup() is allowed to be called=
=20
on hwmods that have already been setup (commit 48d54f3f).

> #2 does return an error but does not print anything, but since each call
> (_init_main_clk, _init_interface_clks, _init_opt_clks) does report
> some pr_warn in case of error, this is fine.

#2 looks fine to me.


- Paul
--155748971-1743776589-1299132480=:10981--
