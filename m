From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC/PATCH] OMAP PM interface
Date: Thu, 01 May 2008 09:57:29 -0700
Message-ID: <87iqxydksm.fsf@paris.hilman.org>
References: <alpine.DEB.1.00.0804290119480.5853@utopia.booyaka.com>
	<874p9kgtcw.fsf@paris.hilman.org>
	<alpine.DEB.1.00.0804302330570.4777@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:57261 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYEAQ5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 May 2008 12:57:34 -0400
In-Reply-To: <alpine.DEB.1.00.0804302330570.4777@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 30 Apr 2008 23\:45\:34 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, sakari.poussa@nokia.com, sawant@ti.com, karthik-dp@ti.com, igor.stoppa@nokia.com, tony@atomide.com, r-woodruff2@ti.com, veera@ti.com, rnayak@ti.com

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 29 Apr 2008, Kevin Hilman wrote:
>
>> I've only given a quick glance so far at the actual patch, but my
>> first comments are regarding the dismissal of the PM QoS framework.
>> 
>> I totally agree that the QoS framework in its current form has several
>> drawbacks and limitations.  However, instead of re-designing something
>> new, I think maybe we should first try to extend the QoS framework.
>
> I agree that the PM QOS code should be extended, but I suspect that this 
> will probably take several months and quite a bit of coordination.
>
> The OMAP PM interface isn't intended to replace the PM QOS code.  Its 
> purpose is to provide a common interface behind which either the TI Shared 
> Resource Framework or the Linux PM QOS code can be used.
>
> The proposed interface is intended to be temporary.  In the medium- to 
> long-term, the OMAP PM interface functionality needs to be integrated into 
> the Linux PM QOS code.  As the PM QOS layer matures, I expect that the 
> OMAP PM interface will disappear.

Great, this is exactly what I was thinking was the right direction.
Although, it will probably never completely disappear.  I have my
doubts that there will ever be a "one size fits all", but it's worth
shooting for, and keeping the OMAP PM layer small.

> Perhaps where we differ is in the expectation of how long the process of 
> updating the PM QOS code will take.

Actually, I think we're on the same page there too.  I also think it
may be pretty difficult and time consuming to come up with a generic
enough layer that can work both in the x86/ACPI world and in embedded.
However, I do think it's a worthy goal, and I should be able to help
contribute to that end as well.

> It seems like non-trivial work to get the PM QOS code to match the
> power savings possible with TI SRF in a way that isn't architecture-
> or chip-revision-specific.  It will probably require some general
> notion of a powerdomain, and will probably involve bus and device
> code.  Our PM QOS changes will affect other architectures and
> drivers not used by OMAP, which will create patches and testing
> liability for code outside the OMAP tree.  Our design changes also
> should be sufficiently architecture-agnostic, so they won't need to
> be scrapped when the next chip architecture comes along.  These
> goals all seem possible, but will take time to discuss across
> architectures, implement, and get into mainline.
>
> Meanwhile, during that process, we should take advantage of the power 
> savings possible with the SRF code.  The SRF itself could theoretically be 
> merged, but it also has some shortcomings.  The driver PM interface should 
> not be specific to particular OMAP silicon.  Driver PM calls should not 
> require other architectures to share notions of OMAP-specific layers like 
> powerdomains.  And we'd like to compare a future PM QOS implementation 
> with the SRF without changing each individual driver, via some mechanism 
> like Kconfig.
>
> Hence the proposed interface.  As an additional benefit, we'll end up
> documenting the changes that we need to make to the Linux PM QOS code
> via working driver code, rather than just assertions.
>
> I don't mean to portray the OMAP PM interface as a panacea. Its purpose is 
> pretty limited.  It's intended to bridge the gap between where PM QOS is 
> now, and hopefully where it'll be in several months' time.

And from what I see so far, it will bridge this gap very well.

Thanks again for this work,

Kevin
