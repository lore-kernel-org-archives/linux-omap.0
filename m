From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: clock3xxx_data: change EMAC clocks aliases
Date: Thu, 9 Feb 2012 13:20:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202091314320.6698@utopia.booyaka.com>
References: <1324423634-32581-1-git-send-email-yanok@emcraft.com> <4F2F8EE3.1050305@visionsystems.de> <20120209190957.GA30410@h56-17.vpn.ti.com> <alpine.DEB.2.00.1202091245210.4469@utopia.booyaka.com> <20120209201100.GB30410@h56-17.vpn.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37567 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab2BIUUv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 15:20:51 -0500
In-Reply-To: <20120209201100.GB30410@h56-17.vpn.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Tony Lindgren <tony@atomide.com>, Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, sasha_d@emcraft.com

Hi Matt

On Thu, 9 Feb 2012, Matt Porter wrote:

> Thanks Paul.
> 
> Any chance we can see it in 3.3 fixes? It's the only thing preventing 
> the emac and thus nfsroot from working in 3.3 for these systems.

Did EMAC work on previous versions of Linux for those systems? i.e., does 
this patch fix a regression?


- Paul
