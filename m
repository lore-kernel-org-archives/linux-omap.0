From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 00/26] PM: Create the AVS class of drivers
Date: Tue, 22 Nov 2011 17:47:40 +0000
Message-ID: <20111122174739.GF30583@opensource.wolfsonmicro.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
 <20111122164302.GI6624@sirena.org.uk>
 <4ECBDE77.6000703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42299 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766Ab1KVRrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 12:47:42 -0500
Content-Disposition: inline
In-Reply-To: <4ECBDE77.6000703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: jean.pihet@newoldbits.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

On Tue, Nov 22, 2011 at 06:40:07PM +0100, Cousson, Benoit wrote:
> On 11/22/2011 5:43 PM, Mark Brown wrote:

> >This sounds a lot like what devfreq (which was recently merged) is
> >supposed to do.  Have you looked at the overlap there?

> devfreq is a fmwk for DVFS governors at device level, whereas AVS
> stands for Adaptive Voltage Scaling. This technique does not involve
> any frequency change, and does a fine voltage adjustment to adapt to
> silicon process / aging / thermal variation based on a HW closed
> loop.

Ah, I see.  It wasn't clear from the changelog that this was about fine
adjustmnets rather than operating point selection.

> Both DVFS and AVS can be used independently.

> I think that AVS does belong to the voltage control infrastructure
> more than the DVFS/freq one.

This does sound like the two may need to understand each other at some
point - if you want to do AVS on things that can vary their operating
point to fine tune the voltages that get set then you'll need to be able
to interface the two.
