From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Common clock and dvfs
Date: Fri, 6 May 2011 11:36:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105061100460.30136@utopia.booyaka.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com> <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com> <4DC311C6.7090707@ti.com> <BANLkTik+LRWvJzppof1zngdrZEPXzMc_UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39974 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab1EFRgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 13:36:32 -0400
In-Reply-To: <BANLkTik+LRWvJzppof1zngdrZEPXzMc_UQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>


Not that this is particularly related to DVFS, but:

On Thu, 5 May 2011, Colin Cross wrote:

> On Thu, May 5, 2011 at 2:08 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>
> > Colin Cross wrote:
> 
> >> omap_hwmod is entirely omap specific, and any generic solution cannot
> >> be based on it.
> >
> > For the moment, because it is a fairly new design, but nothing should
> > prevent us to make it generic if this abstraction is relevant for other SoC.
> 
> That's not how you design abstractions.

Oh really?

> You can't abstract one case, without considering other SoCs, and then 
> make it generic if it fits other SoCs - it will never fit other SoCs.  
> You have to consider all the cases you want it to cover, and design an 
> abstraction that makes sense for the superset.

In actual practice, one often does not know in advance the entire universe 
of cases that one needs to cover.  Even just for one SoC.

Consider that you mentioned earlier that you had to rewrite the Tegra 
clock code several times.  Now, add several other families of SoCs to the 
requirements.  If the documentation for these chips is even available at 
all, it is often misleading or wrong.

Attempting to create an abstraction before one knows the underlying 
requirements of what one is actually trying to abstract is a plan for 
intense suffering.  There's little glory in it.

...

In the specific case of omap_hwmod, the core of the omap_hwmod data 
structures were designed such that they could apply to any SoC with a 
complex interconnect.  The design was based on hardware principles common 
to any SoC: interconnects, IP blocks, reset lines, etc.  There are 
OMAP-specific parts, but if others found omap_hwmod useful, they're 
trivial to abstract.  We haven't sought to force it on others.


- Paul
