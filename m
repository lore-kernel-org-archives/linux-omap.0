From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH 0/2] twl4030 power support for 3430SDP
Date: Fri, 2 Oct 2009 08:17:42 +0300
Message-ID: <20091002051742.GZ32041@smtp.gmail.com>
References: <1254423262-25380-1-git-send-email-khilman@deeprootsystems.com>
 <20091001192431.GW32041@smtp.gmail.com>
 <878wfubt2a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:46026 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbZJBFY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 01:24:28 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1997345fge.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 22:24:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878wfubt2a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On 09 Oct 01, Kevin Hilman wrote:
> Amit Kucheria <amit.kucheria@canonical.com> writes:
> 
> > On 09 Oct 01, Kevin Hilman wrote:
> >> I've been carrying these in the PM branch, but now that twl4030 power
> >> support is in mainline, these can be queued for 2.6.33.
> >> 
> >> Kevin Hilman (1):
> >>   OMAP3: PM: 3430SDP: add initial twl4030 power scripts
> >> 
> >> Rajendra Nayak (1):
> >>   OMAP3: PM: 3430SDP: Update twl4030 power scripts and device groups
> >> 
> >>  arch/arm/mach-omap2/board-3430sdp.c |   93 ++++++++++++++++++++++++++++++++++-
> >>  1 files changed, 91 insertions(+), 2 deletions(-)
> >> 
> >
> > Hi Kevin,
> >
> > Do you want to wait until I push patches that modify the way the scripts are
> > loaded in memory? (they now allow overlapping scripts to work around space
> > constraints)
> >
> > Also we now have very simplified scripts that use broadcast messages. These
> > might still need to be tweaked for the various boards though. It works on the
> > RX51.
> 
> Well, I don't *want* to wait because that means I would have to rework
> these patches.  :)  
> 
> But it sounds waiting is the right thing.  How close are you to having
> the new scripting stuff ready?  Should we put it into the PM branch in
> the meantime so it can get some testing on other boards than RX51?

I haven't started looking at it yet. It will have to wait until w42 though.

I guess you can push your patches to the PM branch and revert them at a later
time when I have the changes ready?

/Amit
-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
