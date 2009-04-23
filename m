From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: OMAP2/3: Reorganize Makefile to add omap4 support
	(Re: [PATCH 7/7][RFC] OMAP4: Enable basic build support.)
Date: Thu, 23 Apr 2009 12:00:01 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8FB05@dbde02.ent.ti.com>
References: <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-7-git-send-email-santosh.shilimkar@ti.com>
 <20090421183940.GN25864@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F40C@dbde02.ent.ti.com>
 <20090422190456.GW25864@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8FADB@dbde02.ent.ti.com>
 <20090423062129.GE25864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32796 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbZDWGaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 02:30:10 -0400
In-Reply-To: <20090423062129.GE25864@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > > should do their builds with the multi-omap selected.
> > > 
> > > Also the distros want multi-omap. Only the product 
> specific kernels
> > > should be built with only one option selected to optimize for 
> > > speed and size.
> > I think most of the things are in place for multi-omap for 
> OMAP4 as well if all the comments are taken care. 
> 
> Yeah cool. Looks like the gic interrupt code can also be initialized
> from the init_common_hw or so. Of course the entry-macro.S still
> needs a separate non-optimized handler for things to boot, I'll
> update an earlier patch for that at some point.
> 
Yes it is initialised from common hw init.

Regards
Santosh