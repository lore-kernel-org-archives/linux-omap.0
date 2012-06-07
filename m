From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 7 Jun 2012 01:08:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061309.25532.13430.stgit@dusk> <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58870 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2FGHIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:08:51 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi

On Thu, 7 Jun 2012, Hiremath, Vaibhav wrote:

> Isn't this impact AM33xx devices, where we do not support smart idle mode???
> Anyway, I will also test it on both OMAP3EVM and AM33xx platform now...

Thanks, please let me know how your tests go.  If it doesn't work, we'll 
go back to the flag-based approach in the patch I posted already.  


- Paul
