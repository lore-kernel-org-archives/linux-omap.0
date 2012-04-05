From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Thu, 5 Apr 2012 04:17:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204050414570.10302@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A9317C47AD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50252 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab2DEKRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 06:17:32 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C47AD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tony@atomide.com

cc Tony

Hi,

On Thu, 5 Apr 2012, Mohammed, Afzal wrote:

> On Thu, Apr 05, 2012 at 15:03:36, Paul Walmsley wrote:
> > Could you try booting with initcall_debug and posting the boot log?
> 
> Logs as follows,

thanks.

...

> [    6.065307] calling  omap_mux_late_init+0x0/0x1a0 @ 1

Looks like a mux-related problem.  Tony recently found some mux-related 
bugs that got merged with the v3.3 mach-omap2/serial.c - I wonder if they 
might be affecting your board too?


- Paul
