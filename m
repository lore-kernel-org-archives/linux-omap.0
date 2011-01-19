From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if doing so
 would reset an active clockdomain
Date: Wed, 19 Jan 2011 03:07:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101190302260.30900@utopia.booyaka.com>
References: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com> <e84561af552e084d0a6c904aabfe46c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33497 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab1ASKHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 05:07:39 -0500
In-Reply-To: <e84561af552e084d0a6c904aabfe46c8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, 19 Jan 2011, Vishwanath Sripathy wrote:

> If some parts of the chip are busy, then how can Core domain enter off
> state? The necessary condition for Core to enter low power state is that
> all the clock domains (including DSS, CAM, IVA, USB, PER etc) should have
> idled. Doesn't it mean that all the modules have idled and asserted
> idleack when Core is entering off state?

Some modules can operate autonomously from the rest of the system.  For 
example, McBSP or DSS.  They can indicate that they are idle or in standby 
while their FIFO(s) are draining or filling.  At this point, the CORE 
clockdomains can potentially go inactive, even though the module is still 
operating autonomously.

Once the module's FIFO watermark has been reached, the modules can 
deassert their SIdleAck or deassert MStandby and wake the system back up.


- Paul
