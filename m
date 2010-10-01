From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Fri, 01 Oct 2010 13:47:10 -0700
Message-ID: <87zkux7i9d.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
	<87tyl8rxwp.fsf@deeprootsystems.com>
	<20100930021819.GD3117@atomide.com>
	<877hi3i9cp.fsf@deeprootsystems.com>
	<87pqvvgt8g.fsf@deeprootsystems.com>
	<877hi3gqq7.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
	<87k4m2c5pj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:37185 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0JAUrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:47:14 -0400
Received: by pxi10 with SMTP id 10so863756pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 13:47:14 -0700 (PDT)
In-Reply-To: <87k4m2c5pj.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Fri, 01 Oct 2010 08:07:04 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> "Nayak, Rajendra" <rnayak@ti.com> writes:
>
> [...]
>
>>> >>
>>> >> Hmm, this fault is very early and long before any PM code has
>>> >> initialzed.  I suspect this happens with the master branch too ??
>>> >
>>> > I've reproduced this now, and it doesn't happen on the master branch and
>>> > only happens after merge pm-hwmods.
>>> >
>>> > Debugging now...
>>> 
>>> OK, so this failure is (somehow) related to the i2c hwmods, but I did
>>> not figure out how.  Rajendra, can you dig into this?  It only seems to
>>> happen on 2420/n800, and all other platforms seem OK.

[...]

> For omap-testing, I will just drop the i2c series for now until this is
> better understood.

Tony,

I pushed a new version of the pm-hwmods branch, this time with only UART
and watchdog

Please pull the latest from here:

   ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-hwmods

Kevin
