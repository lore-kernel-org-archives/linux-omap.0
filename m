From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2] OMAP2+: PM: omap_device: API for set/get MSTANDBY
 mode
Date: Fri, 12 Nov 2010 07:17:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011120717050.28692@utopia.booyaka.com>
References: <1288095101-1294-1-git-send-email-manjugk@ti.com> <alpine.DEB.2.00.1011101548400.28301@utopia.booyaka.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A8115@dbde02.ent.ti.com> <alpine.DEB.2.00.1011110722530.28301@utopia.booyaka.com>
 <alpine.DEB.2.00.1011120715550.28692@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47882 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab0KLOR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 09:17:26 -0500
In-Reply-To: <alpine.DEB.2.00.1011120715550.28692@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, 12 Nov 2010, Paul Walmsley wrote:

> On Fri, 12 Nov 2010, Paul Walmsley wrote:
> 
> > On Thu, 11 Nov 2010, G, Manjunath Kondaiah wrote:
> > 
> > > How do we get previous stand by state in this API since standby mode is 
> > > changed with "omap_device_require_no_standby"
> > 
> > I don't think it is needed.  The API is only valid while the hwmod is 
> > enabled, I think.  So *require_no_mstandby() would force the hwmod into 
> > no-MSTANDBY mode, and *release_no_mstandby() would place it into smart 
> > standby if HWMOD_SWSUP_MSTDBY is not set, and no standby if it is set.
> 
> Oops, this last "no standby" should have been "force standby."

Urk, never mind.  Since the hwmod is enabled, it should be "no standby."  
-ENOCOFFEE

- Paul
