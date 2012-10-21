From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: OMAP baseline test results for v3.7-rc1
Date: Sun, 21 Oct 2012 12:29:26 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA012D8@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>,<20121021073551.GA4735@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39024 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab2JUM3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 08:29:37 -0400
In-Reply-To: <20121021073551.GA4735@netboy.at.omicron.at>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Richard,

* Richard Cochran, October 21, 2012 1:05 PM:

> People keep saying, the beaglebone works fine with v3.7-rc1, but it
> isn't true. Now v3.7-rc2 is out, and the gpmc issue still has not been
> fixed, and no one is doing anything about it either.

A fix to resolve the gpmc issue has been merged recently, so I am
expecting beagle bone to boot on -rc2 (I don't have hardware to test,
on vacation now), can you please try with -rc2.

Note: Sending via exchange, hope this is readable.

Regards
Afzal