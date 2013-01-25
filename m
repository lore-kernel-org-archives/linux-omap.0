From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Fri, 25 Jan 2013 08:23:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301250822270.471@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>  <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>  <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>  <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com> <1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-516921023-1359102182=:471"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41467 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3AYIXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 03:23:03 -0500
In-Reply-To: <1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?Jan_L=FCbbe?= <jlu@pengutronix.de>
Cc: Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon\\\\, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath\\\\, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-omap\\\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-516921023-1359102182=:471
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Jan,

On Tue, 22 Jan 2013, Jan L=C3=BCbbe wrote:

> Just a guess, but there can be problems when the appended DTB crosses an
> 1MB boundary. See this mail for details and a patch:
> http://www.spinics.net/lists/arm-kernel/msg216898.html

Thanks for the suggestion.  That patch didn't fix it for me.


- Paul
--843723315-516921023-1359102182=:471--
