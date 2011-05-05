From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Common clock and dvfs
Date: Thu, 5 May 2011 14:59:02 +0100
Message-ID: <20110505135901.GA26651@sirena.org.uk>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com> <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com> <alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com> <BANLkTimfN-1J8LifEzsnJ-GFfp0GXGDm+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:49433 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab1EEN7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 09:59:12 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimfN-1J8LifEzsnJ-GFfp0GXGDm+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Turquette, Mike" <mturquette@ti.com>

On Wed, May 04, 2011 at 11:50:52PM -0700, Colin Cross wrote:

> True, that was an oversimplificaiton. I meant the minimum voltage that
> scales with clock frequencies only depends on the clock frequency, not
> the device.  Devices do need to be able to specify a higher minimum
> voltage, and the regulator api needs to handle it.

The regulator API already supports this so we're fine there.
