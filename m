From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 19:26:03 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103161920510.2634@esdhcp041196.research.nokia.com>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com> <4D7FC70D.7050508@ti.com> <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com> <4D80CA2F.8060300@ti.com>
 <20110316153223.GQ7258@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:47797 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab1CPR2S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 13:28:18 -0400
In-Reply-To: <20110316153223.GQ7258@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Hi,

On Wed, 16 Mar 2011, Tony Lindgren wrote:
> FYI, my rx51 boots fine with omap2plus defconfig, also with
> earlyprintk.

For the RX-51 earlyprintk problem I need to enable pr_debug()s in
omap_hwmod.c. Otherwise it won't trigger. Of course that's a pretty
artificial test case, so I guess we can forget that for a time being.

A.
