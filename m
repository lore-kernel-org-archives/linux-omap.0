From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 0/1] OMAP3 PM Add C0 state
Date: Tue, 24 Feb 2009 12:27:09 +0200
Message-ID: <20090224102709.GA4569@codecarver.research.nokia.com>
References: <1234974118-27446-1-git-send-email-peter.de-schrijver@nokia.com> <87ljrx9fl3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40857 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZBXK2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 05:28:54 -0500
Content-Disposition: inline
In-Reply-To: <87ljrx9fl3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 23, 2009 at 07:24:24PM +0100, ext Kevin Hilman wrote:
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> 
> > This patch introduces a new C state C0 which keeps both core and mpu
> > powerdomains in ON state. This gives us low latency at a cost of higher
> > power consumption.
> >
> 
> I don't like the name 'C0' for an idle-state.  In ACPI terms, C0 is an
> active state, not an idle state.  I know this is not an ACPI system,
> but since we're using ACPI names, we should be consistent.
> 
> Is there a real benefit to having an additional state here?  Shouldn't
> we just make these changes or C1?
> 

C1 has a too high wakeup latency (10s of us) for some cases, but C0 (which has
a 3us wakeup latency) keeps core on which implies little powersavings. So
I think we need both.

Cheers,

Peter.

-- 
goa is a state of mind
