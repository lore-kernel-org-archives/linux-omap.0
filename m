From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH 2/2] ARM: OMAP2+: gpmc: removed 'gpmc,device-nand'. type
 determined from node-name
Date: Tue, 18 Jun 2013 10:42:08 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9DE4E4@DBDE04.ent.ti.com>
References: <1370001691-29320-1-git-send-email-pekon@ti.com>
 <1370001691-29320-2-git-send-email-pekon@ti.com>
 <20130612165906.GH8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45902 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab3FRKmQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 06:42:16 -0400
In-Reply-To: <20130612165906.GH8164@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Jon Hunter <jgchunter@gmail.com>

> > From: "Gupta, Pekon" <pekon@ti.com>
> >
> > GPMC supports multiple types of child devices like NAND, NOR, OneNand,
> Ethernet
> > This patch removes 'gpmc,device-nand', used explicitely to specify NAND
> type
> > gpmc-child. Instead gpmc-child type can be inferred from gpmc->child-
> >name.
> 
> This does not seem to apply. Also please break into a gpmc.c patch and
> then the .dts patch for Benoit. And make sure you consider if removing
> this binding might break something. If it does, we need to maintain the
> support for the old binding.
> 
[Pekon]: you map please ignore this one, as there is already a commit in 
your tree (omap-for-v3.11/gpmc) which does similar, therefore conflicting.
	Commit  f40739faba8e804cf46505869ab98ad7c4a88833 
	ARM: dts: OMAP2+: Simplify NAND support

I'll post separate patch for AM33xx DTB update for Benoit's tree.

Thanks..
with regards, pekon
