From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Mon, 17 Sep 2012 22:12:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209172208540.16117@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com> <alpine.DEB.2.00.1209162033400.698@utopia.booyaka.com> <20120917212605.GC11762@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52574 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784Ab2IQWMC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 18:12:02 -0400
In-Reply-To: <20120917212605.GC11762@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 17 Sep 2012, Tony Lindgren wrote:

> That's good news. Does that mean we should try to merge these patches
> for v3.7 then? Or do we still have issues remaining?

There are still problems with the OMAP4 CCF implementation.  Power 
management is broken on some bootloaders that the original data works fine 
with.   It's still under debug.


- Paul
