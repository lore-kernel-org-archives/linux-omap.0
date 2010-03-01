From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv6 0/9] Refreshed idlestatus patches with minor fixes
Date: Mon, 01 Mar 2010 15:17:19 -0800
Message-ID: <87635faayo.fsf@deeprootsystems.com>
References: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:49273 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0CAXRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 18:17:25 -0500
Received: by gxk27 with SMTP id 27so1887415gxk.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 15:17:24 -0800 (PST)
In-Reply-To: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 12 Feb 2010 20\:27\:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Following changes compared to previous set:
>
> - Fixed a problem with PER domain handling when PER was active
> - Removed rwlock usage from pwrdm_can_idle as the lock was removed from
>   powerdomain code
>
> Still applies on top of PM branch.

This is looking good now, and I'm mostly ready to merge this.
However, a couple more small things need attention.  I'll have some
small comments on a couple of the individual patches.

The CPUidle patches (3, 7, and 8) need a refresh against current PM
branch.  In fact, I think 8 can be dropped as a similar fix from
Sanjeev is merged in the PM branch now.  Also, patch 7 doesn't compile
against PM branch as it's missing the definition of 'iva2_pd'.

Kevin





