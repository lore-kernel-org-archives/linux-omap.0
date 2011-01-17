From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: State of LDP3430 platform
Date: Mon, 17 Jan 2011 11:44:18 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203EAE6F909@dlee02.ent.ti.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20101206181913.GH8345@atomide.com>
 <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <13B9B4C6EF24D648824FF11BE896716203EAE6F3AA@dlee02.ent.ti.com>
 <20110117173454.GX4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508Ab1AQRo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 12:44:28 -0500
In-Reply-To: <20110117173454.GX4957@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, January 17, 2011 11:35 AM

> This happened for a few days both with 2.6.37 and current mainline
> kernel. After I started debugging it went away with no changes to
> anything.. So can't debug any further at this point unfortunately.

Odd. You might experiment with cold reset vs. warm reset for booting.  Initial values of some blocks will be different.

Reset tree is something not usually considered. The behavior depends on what level and when it is asserted. Software tends to act like all resets have same effect and this is not the case. I've seen folks burned in PM context several times at both OMAP and PMIC level.

Also... something happen behind your back.  You can program up the PMIC to take a softreset and issue a hardreset.

Regards,
Richard W.

