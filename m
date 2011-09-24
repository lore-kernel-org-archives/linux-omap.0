From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] OMAP3/4: Misc fixes and clean-up
Date: Sat, 24 Sep 2011 01:36:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109240120240.22872@utopia.booyaka.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com> <4E7D72BF.8060009@ti.com> <alpine.DEB.2.00.1109240031280.22872@utopia.booyaka.com> <4E7D7A28.3070005@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1153633999-1316848941=:22872"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54635 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab1IXHgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 03:36:32 -0400
In-Reply-To: <4E7D7A28.3070005@ti.com>
Content-ID: <alpine.DEB.2.00.1109240124020.22872@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1153633999-1316848941=:22872
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1109240124021.22872@utopia.booyaka.com>

Hi

On Sat, 24 Sep 2011, Santosh Shilimkar wrote:

> On Saturday 24 September 2011 12:01 PM, Paul Walmsley wrote:
> > Hi Santosh
> >=20
> > On Sat, 24 Sep 2011, Santosh Shilimkar wrote:
> >=20
> >> On Thursday 08 September 2011 10:51 AM, Santosh Shilimkar wrote:
> >>>
> >> I need your ack on below two patches so that I can re-base them and
> >> send a pull request to Tony.
> >>
> >> OMAP4: clock: Add CPU local timer clock node.
> >> OMAP: Fix sparse warnings in l3 error handler.
> >=20
> > Are you targeting these for 3.1-rc ?
> >=20
> Nope. It's for 3.2 merge window.
> As such, the series doesn't have any major regression
> fixes which should make it before 3.2

In that case, patches 1 and 7 should go in through me.  The rest should go=
=20
via Tony.  So you can just drop 1 and 7 from your branch, I'll pull those=
=20
off the list.=20

Some comments though:  Looks like you need to repost patch 1 due to=20
comments from Beno=EEt?  Also, have the autogeneration scripts been updated=
=20
for patch 7?

=2E..

As far as patch 5 goes, you don't need my ack on that one, since I'm not=20
the maintainer or original author of that code.  But feel free to add a=20
Reviewed-by:.  I also tested the two L3 files with sparse and they are=20
clean now.  Thanks very much for taking the initiative on this; I=20
personally appreciate it quite a bit, and I think having clean code=20
increases our credibility with upstream maintainers.=20


- Paul
--155748971-1153633999-1316848941=:22872--
