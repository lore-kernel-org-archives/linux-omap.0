From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
Date: Fri, 29 Jul 2011 16:25:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C374A45@dbde02.ent.ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
 <1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
 <20110716190734.GB990@google.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037C202D59@dbde02.ent.ti.com>
 <20110728074327.GA12916@google.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037C2030F7@dbde02.ent.ti.com>
 <20110728170029.GA9819@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40275 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab1G2K4J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 06:56:09 -0400
In-Reply-To: <20110728170029.GA9819@google.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
> To be clear, it seems like resetting irqenable settings should be a
> one-time action at probe time.  The power management actions such as
Looking at it again, well we could probably avoid *_mod_init() in request.
I will test and confirm. Thanks.
--
Tarun
[...]
> 
> Anyhow, mainly wanted to point that out as a possible optimization.
> It's pretty unlikely there's an actual problem here.
> 
> 
> Todd
