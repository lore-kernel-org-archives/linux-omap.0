From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10 v3] omap3: pm: introduce support for 3630 OPPs
Date: Wed, 25 Nov 2009 07:24:15 -0800
Message-ID: <877htemxuo.fsf@deeprootsystems.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:58959 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbZKYPYL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 10:24:11 -0500
Received: by pxi10 with SMTP id 10so5823326pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 07:24:17 -0800 (PST)
In-Reply-To: <1259122159-1583-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Tue\, 24 Nov 2009 22\:09\:09 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Hi,
> Here is V3 of the patch series.  What changed in V3:
> * Major rewrite of OPP APIs. This includes changes from offline
>   discussions with lots of folks and taking in l-o comments - all
>   patches have changed as a result.
> * rebased to latest lo-pm
>
> V2: http://marc.info/?l=linux-omap&m=125809232732700&w=2
> V1: http://marc.info/?l=linux-omap&m=125800488923479&w=2
>
> NOTE: After a bunch of frustrating efforts, current OPP accessor
> implementation is constrained by two files:
> smartreflex.c and resource34xx.c. I agree that the current opp
> accessor implementation leaves lot to be desired, but the nature of
> struct omap_opp cannot change unless we essentially rewrite the
> implementation of the mentioned files.
>
> Ref: http://elinux.org/OMAP_Power_Management#Future_directions
>
> I propose we could take this in in three stages:
> Stage 1: Introduce this series in as starters if there are no major
>  issues
> Stage 2: We cleanup/replace resource34xx and smartreflex.c
> Stage 3: Go through a second round of optimization/cleanup of opp
>  accessors implementation (this time for good hopefully)

I'm open to this 3-step approach assuming that stage 2 and 3 remain a
priority.  This "stage 1" series will not go upstream.  I will only
push upstream after getting to stage 3. 

After some review and discussion, I can pull Stage 1 into the PM
branch for broader testing and as a base for more people to help on
stage 2 and stage 3.

Review comments on individual patches to follow.

Kevin
