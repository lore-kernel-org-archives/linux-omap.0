From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 0/13] OMAP: dmtimer: hwmod
Date: Mon, 23 Aug 2010 17:22:09 -0700
Message-ID: <878w3wq2q6.fsf@deeprootsystems.com>
References: <1281800359-15285-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58714 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0HXAWL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 20:22:11 -0400
Received: by pzk26 with SMTP id 26so2485902pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 17:22:11 -0700 (PDT)
In-Reply-To: <1281800359-15285-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Sat, 14 Aug 2010 21:09:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This patch series contains:
> (*) most of the comments provided in v1 implemented and
> (*) OMAP4 timers support
>
> The comment details are availabe in respective patch series.
>
> The comment regarding usage of "dmtimer" name will be resolved
> after final round of consultation with members.
>
> Baseline: "origin/pm-wip/hwmods-omap4"

This branch has no hwmods for OMAP4 timers.  Please rebase to recent
version of same brach and include OMAP4 hwmod data.

> Test info: Tested on OMAP4430SDP, OMAP3630SDP

Any 3430 testing?

Please also test on OMAP2 and OMAP1.

Kevin
