From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Fri, 8 Oct 2010 12:22:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010081220150.27105-100000@netrider.rowland.org>
References: <87y6a9zhf7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:35983 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753378Ab0JHQWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 12:22:38 -0400
In-Reply-To: <87y6a9zhf7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thu, 7 Oct 2010, Kevin Hilman wrote:

> > Do you need "normal" resume to work after "atomic" suspend, or is it
> > sufficient that "atomic" suspend will require "atomic" resume?
> 
> hmm... while I'm definitely needing an "atomic" resume after a "normal"
> suspend, for now I can't think of a case where a "normal" resume would
> be needed after an "atomic" suspend.  All the cases where I'm currently
> using an atomic suspend also have a corresponding atomic resume.
> 
> As I write this, it wouldn't surprise me down the road to find some HW
> errata that requires the device in a specific state only before idle,
> but not caring about the state after idle.  That would be a case where
> an atomic suspend would be needed, but the resume would be "normal"
> sometime later when the device is next needed.

Put it this way: Are you okay with just the following two 
possibilities?

	(1) Both suspends and resumes always have interrupts enabled.

	(2) Both suspends and resumes always have interrupts disabled.

In other words, is it okay to rule out the ability of mixing "atomic" 
and "normal" runtime PM operations?

Alan Stern

