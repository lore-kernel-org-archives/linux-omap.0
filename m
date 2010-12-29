From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 11:56:28 +0000
Message-ID: <20101229115628.GB3017@opensource.wolfsonmicro.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
 <1293618931.3451.17.camel@odin>
 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
 <1293623571.3451.51.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50940 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751760Ab0L2L4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 06:56:17 -0500
Content-Disposition: inline
In-Reply-To: <1293623571.3451.51.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: balbi@ti.com, "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Dec 29, 2010 at 11:52:51AM +0000, Liam Girdwood wrote:

> In this case though the other McBSP user afaik is DaVinci, so in this
> case it does make sense to make this driver support both.

The other thing with McBSP is that it's a generic programmable serial
port and so need not be tied to audio use (though as I understand it
other uses are very rare).
