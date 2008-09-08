From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Sun, 7 Sep 2008 21:04:56 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365533091@dlee02.ent.ti.com>
References: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <20080905172133.GM24202@atomide.com>
 <20080905224530.GE17156@flint.arm.linux.org.uk>
 <20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
 <20080907193619.GC10359@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbYIHCFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 22:05:15 -0400
In-Reply-To: <20080907193619.GC10359@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux

> Well, the first question is... where has this come from, and why.

In OMAPs, a few devices have a local IO MMU.  Their basic structure is similar to an ARM MMU, but less featured. IVA & Camera have one each on 3430/2430, a 2420 has those before mentioned and + 3rd in its video accelerator.

The usage in TI kernels has varied a bit.  Some times they are just load and lock TLB's, for others table walking can be enabled.  In all cases if a table walk miss happens it is fatal and the IP block device will have to be reset.

Paul Mundt had done the linux-omap tree version used with dspgateway.

Regards,
Richard W.

