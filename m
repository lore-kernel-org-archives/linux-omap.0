From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Tue, 06 Oct 2009 16:16:02 -0700
Message-ID: <87eipgnmfh.fsf@deeprootsystems.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:50237 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747AbZJFXRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 19:17:18 -0400
Received: by pxi9 with SMTP id 9so4297772pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 16:16:05 -0700 (PDT)
In-Reply-To: <87iqezdmas.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 01 Oct 2009 11\:03\:07 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Hello,
>
> I've rebased/updated the PM branch based on current linux-omap master
> branch (2.6.32-rc1 based.)
>
> I've also updated the OMAP Power Management wiki, and the 'Current
> version' section highlights the changes, supported platforms as well
> as the features that have made it into mainline.
>
>      http://elinux.org/OMAP_Power_Management#Current_version
>

FYI... I just rebased the PM branch onto current omap/master.

Some important user-visible changes: The /sys/power/* options are
moving into debugfs.  For mainline, these primarily debug options need
to move to debugfs so I've moved them there.  So, if you're missing
some flag under /sys/power, it's now under /debug/pm_debug.

I've updated the 'Using the PM branch' seciont of PM wiki[1] with
the new filenames.

Kevin

[1] http://elinux.org/OMAP_Power_Management
