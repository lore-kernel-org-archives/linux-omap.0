From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/PATCH] OMAP PM interface
Date: Wed, 30 Apr 2008 23:45:34 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804302330570.4777@utopia.booyaka.com>
References: <alpine.DEB.1.00.0804290119480.5853@utopia.booyaka.com> <874p9kgtcw.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48605 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYEAFpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 May 2008 01:45:35 -0400
In-Reply-To: <874p9kgtcw.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap@vger.kernel.org, sakari.poussa@nokia.com, sawant@ti.com, karthik-dp@ti.com, igor.stoppa@nokia.com, tony@atomide.com, r-woodruff2@ti.com, veera@ti.com, rnayak@ti.com

Hello Kevin,

Thanks, as always, for your comments.

On Tue, 29 Apr 2008, Kevin Hilman wrote:

> I've only given a quick glance so far at the actual patch, but my
> first comments are regarding the dismissal of the PM QoS framework.
> 
> I totally agree that the QoS framework in its current form has several
> drawbacks and limitations.  However, instead of re-designing something
> new, I think maybe we should first try to extend the QoS framework.

I agree that the PM QOS code should be extended, but I suspect that this 
will probably take several months and quite a bit of coordination.

The OMAP PM interface isn't intended to replace the PM QOS code.  Its 
purpose is to provide a common interface behind which either the TI Shared 
Resource Framework or the Linux PM QOS code can be used.

The proposed interface is intended to be temporary.  In the medium- to 
long-term, the OMAP PM interface functionality needs to be integrated into 
the Linux PM QOS code.  As the PM QOS layer matures, I expect that the 
OMAP PM interface will disappear.

Perhaps where we differ is in the expectation of how long the process of 
updating the PM QOS code will take.

It seems like non-trivial work to get the PM QOS code to match the power 
savings possible with TI SRF in a way that isn't architecture- or 
chip-revision-specific.  It will probably require some general notion of a 
powerdomain, and will probably involve bus and device code.  Our PM QOS 
changes will affect other architectures and drivers not used by OMAP, 
which will create patches and testing liability for code outside the OMAP 
tree.  Our design changes also should be sufficiently 
architecture-agnostic, so they won't need to be scrapped when the next 
chip architecture comes along.  These goals all seem possible, but will 
take time to discuss across architectures, implement, and get into 
mainline.

Meanwhile, during that process, we should take advantage of the power 
savings possible with the SRF code.  The SRF itself could theoretically be 
merged, but it also has some shortcomings.  The driver PM interface should 
not be specific to particular OMAP silicon.  Driver PM calls should not 
require other architectures to share notions of OMAP-specific layers like 
powerdomains.  And we'd like to compare a future PM QOS implementation 
with the SRF without changing each individual driver, via some mechanism 
like Kconfig.

Hence the proposed interface.  As an additional benefit, we'll end up
documenting the changes that we need to make to the Linux PM QOS code
via working driver code, rather than just assertions.

I don't mean to portray the OMAP PM interface as a panacea. Its purpose is 
pretty limited.  It's intended to bridge the gap between where PM QOS is 
now, and hopefully where it'll be in several months' time.


regards,

- Paul
