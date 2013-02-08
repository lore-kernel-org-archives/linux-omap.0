From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 13:34:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com> <20130207083217.GA15462@arwen.pp.htv.fi> <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48954 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab3BHNeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 08:34:05 -0500
In-Reply-To: <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 8 Feb 2013, Paul Walmsley wrote:

> The point is to try to minimize bootloader dependencies.

Also if there are weird bootloader dependendencies that no one can track 
down, we should document them somewhere, maybe underneath 
Documentation/arm/OMAP.


- Paul
