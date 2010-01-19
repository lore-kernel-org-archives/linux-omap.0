From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Tue, 19 Jan 2010 12:28:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191227280.3977@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com> <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB7F9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0AST2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 14:28:16 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB7F9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, 15 Jan 2010, Reddy, Teerth wrote:

> Will send the updated patch.

Thanks, all your above responses make sense.  What do you think about some 
of the other comments I had, re: disabling interrupts, etc?


- Paul
