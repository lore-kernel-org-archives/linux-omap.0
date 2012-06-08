From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 19:11:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com> <4FD09EFA.20304@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51353 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166Ab2FHBLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 21:11:12 -0400
In-Reply-To: <4FD09EFA.20304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Thu, 7 Jun 2012, Cousson, Benoit wrote:

> Indeed, what I did not mention is that potentially the whole device init
> should be done ondemand as well. Meaning the whole hwmod setup phase should be
> done only when the driver will probe the device.

That means if no driver exists for an IP block, or if the driver isn't 
using PM runtime, the IP block won't be reset.  And somehow we still are 
missing drivers in mainline.  We also still have drivers that aren't yet 
PM runtime converted.


- Paul
