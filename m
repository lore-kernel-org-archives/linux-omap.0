From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Common clock and dvfs
Date: Thu, 5 May 2011 00:35:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com> <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50072 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1EEGfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 02:35:08 -0400
In-Reply-To: <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>

On Wed, 4 May 2011, Colin Cross wrote:

> Imagine a chip where a clock can feed devices A, B, and C.  If the
> devices are always clocked at the same rate, and can't gate their
> clocks, the minimum voltage that can be applied to a rail is
> determined ONLY by the rate of the clock.

That's not so -- although admittedly it's a side issue, and not 
particularly related to DVFS.

For example, the device may have some external I/O lines which need to be 
at least some minimum voltage level for the externally-connected device to 
function.  This minimum voltage level can be unrelated to the device's 
clock frequency.


- Paul
