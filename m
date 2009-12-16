From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10 V5] omap3: pm: introduce support for 3630 OPPs
Date: Wed, 16 Dec 2009 11:59:04 -0800
Message-ID: <87pr6eadx3.fsf@deeprootsystems.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
	<1260594031-17268-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49194 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbZLPT7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 14:59:07 -0500
Received: by yxe17 with SMTP id 17so1252350yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 11:59:07 -0800 (PST)
In-Reply-To: <1260594031-17268-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Fri\, 11 Dec 2009 23\:00\:28 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Hi,
> Thanks for all the comments. Here are the *changed* patches since V5
>
> What changed in V5:
> * review comment incorporated
> * vsel is deprecated now
> * I seem to have hit a checkpatch.pl bug as in 
>   http://lkml.org/lkml/2009/12/11/573, made me check the usage
>   of __deprecated for struct params, and used it in a
>   consistent manner to functions..
> * More warnings added to build :( (deprecated ones ofcourse)
> * removed OMAP_OPP_DEF_TERMINATOR
> * 3430 and 3630 patches changed as a result
>
> History:
> V4: http://marc.info/?t=126033962600001&r=1&w=2
> V3: http://marc.info/?t=125912234200001&r=1&w=2
> V2: http://marc.info/?l=linux-omap&m=125809232732700&w=2
> V1: http://marc.info/?l=linux-omap&m=125800488923479&w=2
>
> Ref: http://elinux.org/OMAP_Power_Management#Future_directions
>
> TODO: The list is still the same as in:
> http://marc.info/?l=linux-omap&m=126033945313269&w=2

FYI...

To facilitate the ongoing discussions on OPP rework, and to have a
common base, this series is available as a branch in my linux-omap-pm
repo[1].

The branch is called 'pm-wip-opp' and I have rebased onto the PM
branch I pushed today.

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
