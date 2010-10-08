From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Fri, 08 Oct 2010 14:04:05 -0700
Message-ID: <87sk0gtn0a.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1010081220150.27105-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55046 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759660Ab0JHVEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 17:04:10 -0400
Received: by pzk34 with SMTP id 34so419168pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 14:04:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1010081220150.27105-100000@netrider.rowland.org>
	(Alan Stern's message of "Fri, 8 Oct 2010 12:22:38 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 7 Oct 2010, Kevin Hilman wrote:
>
>> > Do you need "normal" resume to work after "atomic" suspend, or is it
>> > sufficient that "atomic" suspend will require "atomic" resume?
>> 
>> hmm... while I'm definitely needing an "atomic" resume after a "normal"
>> suspend, for now I can't think of a case where a "normal" resume would
>> be needed after an "atomic" suspend.  All the cases where I'm currently
>> using an atomic suspend also have a corresponding atomic resume.
>> 
>> As I write this, it wouldn't surprise me down the road to find some HW
>> errata that requires the device in a specific state only before idle,
>> but not caring about the state after idle.  That would be a case where
>> an atomic suspend would be needed, but the resume would be "normal"
>> sometime later when the device is next needed.
>
> Put it this way: Are you okay with just the following two 
> possibilities?
>
> 	(1) Both suspends and resumes always have interrupts enabled.
>
> 	(2) Both suspends and resumes always have interrupts disabled.
>
> In other words, is it okay to rule out the ability of mixing "atomic" 
> and "normal" runtime PM operations?

Yes, I think that's a reasonable limitation.

If a driver/subsystem needs to handle an occasional "atomic" runtime PM
operation, it's callbacks will have to be atomic as well, so I don't see
any reason it can't be made to use only atomic operations.

Kevin
