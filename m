From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] Regulator: Add pmic.c file to regulator framework
Date: Mon, 18 May 2009 14:04:37 +0100
Message-ID: <20090518130437.GC1629@sirena.org.uk>
References: <1241795526-15667-1-git-send-email-anuj.aggarwal@ti.com> <20090508190655.GC11502@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB03056A13EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:47520 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbZERNEg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:04:36 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056A13EE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Pillai, Manikandan" <mani.pillai@ti.com>

On Mon, May 18, 2009 at 05:50:31PM +0530, Aggarwal, Anuj wrote:

> > The kernel already provides facilities for detecting the presence of
> > devices.  In cases where it is possible to do a generic check for a

> [Aggarwal, Anuj] In my opinion, it would not be a good idea to probe 
> for several PMICs, on all the buses present in the system. It can be 
> simplified by probing only the ones which are relevant for this device.

The point here is that the kernel already provides for doing device
enumeration of all kinds, both static and dynamic, and that adding this
file doesn't add anything except copying of the code from arch/arm into
drivers/regulator.

> > Another thing here is that the code appears to assume that there will be
> > only one regulator device in the system which isn't always true.  Some
> > designs will use a series of discrete regulators rather than integrated
> > chips while others will use several integrated PMICs for reasons such as
> > ease of layout or power distribution.

> [Aggarwal, Anuj] Can you explain this, I didn't get that much?

Instead of having a single PMIC with multiple regulator outputs a system
may choose to have several regulators.  One way this can happen is that
some manufacturers produce simple discrete regulator chips which produce
only a single output - typically several of these would be needed in a
system.

Another approach which cause this to come up some systems use is to have
more than one PMIC, for example having one PMIC for the main application
processor and a second PMIC providing supplies used by a coprocessor.
This can avoid electrical issues by allowing shorter tracks for the
regulated supplies and simplifying routing.

> [Aggarwal, Anuj] You are right, the primary purpose of this patch is to 
> avoid duplication of PMIC code, common to many OMAP platforms and I believe this is a simpler and cleaner approach.
> Instead of keeping this file in the drivers/regulator folder, we can move it to arch/arm/mach-omap2 folder.

This sounds like a good approach.
