From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Should I worry about "omap-mcbsp.2: alias fck already exists"
 or is it expected?
Date: Fri, 16 Dec 2011 02:24:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160219030.12660@utopia.booyaka.com>
References: <20111212103553.044b17bb@notabene.brown> <4EE5D8A5.1010308@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46727 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1LPJY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 04:24:27 -0500
In-Reply-To: <4EE5D8A5.1010308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, jarkko.nikula@bitmer.com

(cc Jarkko)

On Mon, 12 Dec 2011, Cousson, Benoit wrote:

> On 12/12/2011 12:35 AM, NeilBrown wrote:
> > 
> > In 3.2-rc5 (and some earlier kernels) I'm getting the boot-time warning:
> > 
> > [    0.186828]  omap-mcbsp.2: alias fck already exists
> > 
> > and
> > 
> > [    0.188476]  omap-mcbsp.3: alias fck already exists
> > 
> > This happens because omap_alloc_device() contains:
> > 
> > 
> > 	for (i = 0; i<  oh_cnt; i++) {
> > 		hwmods[i]->od = od;
> > 		_add_hwmod_clocks_clkdev(od, hwmods[i]);
> > 	}
> > 
> > so if oh_cnt is ever>  1 (which is is for mcbsp.2 and .3 in
> > omap_hwmod_3xxx_data.c as they both declare a '.devattr'), then
> > _add_hwmod_clocks_clkdev will be called twice with the one 'od', and both
> > calls will try to add an alias 'fsck' to that same device, and the second
> > will always give a warning.
> > 
> > Is this actually a bug,
> 
> It is indeed a bug. The point is that in theory most hwmod should have an
> unique device to represent them. But in the case of the Mcbsp2 and 3, due to
> the tightly coupled sidetone, and because each one has a dedicated OCP port,
> it was decided to have 2 hwmods but only one omap_device.
> 
> I'm wondering now if another device should not be considered, but I'll let
> Peter decide for the McBSP driver organization.

The sidetone blocks should definitely have separate devices & drivers, but 
AFAIK from Jarkko, this turns out to be not so easy due to an OMAP3 
hardware bug:

   http://www.spinics.net/lists/linux-omap/msg58101.html

So basically the interface clock autoidle handling needs to be fixed in 
the omap_hwmod code, so IP blocks with buggy autoidle handling can be 
marked in the hwmod data, and the hwmod code can control the interface 
clock autoidle bits along with the module's PM runtime status.

Patches welcome :-)


- Paul
