From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
Date: Thu, 14 Jun 2012 02:36:25 -0700
Message-ID: <20120614093625.GF12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
 <4FD78D93.9080906@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99884F@DBDE01.ent.ti.com>
 <4FD8BFC5.2050007@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999720@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32469 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2FNJg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 05:36:28 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999720@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 01:59]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 21:58:53, Hunter, Jon wrote:
> 
> > > Presently there are no peripherals in mainline turning on writeprotect,
> > > initially intention was to just disable writeprotect at the end of probe
> > > and not provide platforms opportunity to enable writeprotect as none
> > > need it, still a provision has been provided for platform to enable it.
> > > 
> > > Probably these to be taken care when there is a requirement.
> > 
> > Ok, but I am still not happy about this. So I did find that our
> > omap2420h4 board does route the write protect to both NOR and NAND.
> > Therefore, it does appear to be a valid use-case that multiple child
> > devices can share the write-protect. So maybe we do not need to reserve
> > the write-protect like we are doing for chip-selects, but I think that
> 
> :
> 
> > devices should indicate if they use the write-protect pin and we should
> > either have this "enable on boot" as a global setting not specific to a
> > child device or ensure that multiple devices using the wp have the same
> > configuration of the wp on boot. In other words, if one device says
> > enable on boot and the other does not, then warn.
> 
> Which one of Jon's above suggestions would you prefer,
> 
> i.e.
> writeprotect as a global setting for all devices
> Or
> Ensure that multiple devices using wp have same configuration
> 
> Or anything else you have in mind ?

If it's shared it can cause undesired effects on the mounted rootfs
if one device changes it. So some kind of checking for a shared case
should be available before a device is allowed to change it.

Tony
