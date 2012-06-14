From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
Date: Thu, 14 Jun 2012 10:21:33 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99988D@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
 <4FD78D93.9080906@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99884F@DBDE01.ent.ti.com>
 <4FD8BFC5.2050007@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999720@DBDE01.ent.ti.com>
 <20120614093625.GF12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41752 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2FNKVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 06:21:41 -0400
In-Reply-To: <20120614093625.GF12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Jun 14, 2012 at 15:06:25, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120614 01:59]:
> > On Wed, Jun 13, 2012 at 21:58:53, Hunter, Jon wrote:

> > > devices should indicate if they use the write-protect pin and we should
> > > either have this "enable on boot" as a global setting not specific to a
> > > child device or ensure that multiple devices using the wp have the same
> > > configuration of the wp on boot. In other words, if one device says
> > > enable on boot and the other does not, then warn.
> > 
> > Which one of Jon's above suggestions would you prefer,
> > 
> > i.e.
> > writeprotect as a global setting for all devices
> > Or
> > Ensure that multiple devices using wp have same configuration
> > 
> > Or anything else you have in mind ?
> 
> If it's shared it can cause undesired effects on the mounted rootfs
> if one device changes it. So some kind of checking for a shared case
> should be available before a device is allowed to change it.

Ok, I will add a check for shared case.

Regards
Afzal
