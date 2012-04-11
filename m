From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 04/12] ARM: OMAP1: OHCI: use platform_data fn ptr to
 enable OCPI bus
Date: Wed, 11 Apr 2012 12:19:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111219240.29473@utopia.booyaka.com>
References: <20120411003454.27059.37500.stgit@dusk> <20120411003528.27059.8836.stgit@dusk> <4F853788.2030007@antcom.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44634 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911Ab2DKSTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 14:19:55 -0400
In-Reply-To: <4F853788.2030007@antcom.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>

On Wed, 11 Apr 2012, Roland Stigge wrote:

> On 04/11/2012 02:35 AM, Paul Walmsley wrote:
> > Also interesting is that drivers/usb/host/ohci-nxp.c contains a stub
> > for ocpi_enable() - perhaps the NXP chips use a similar OCPI IP block?
> 
> I'd rather suspect a copy-paste error here since ocpi_enable() is unused
> in ohci-nxp.c and the extern declaration looks like an incomplete but
> intended removal.
> 
> Will probably just remove this reference in my DT patchset.

Thanks, will drop the comment from the patch description.


- Paul
