From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP3: DVFS core patch set
Date: Mon, 15 Dec 2008 13:48:01 -0800
Message-ID: <87wse19kku.fsf@deeprootsystems.com>
References: <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:37793 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855AbYLOVsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 16:48:09 -0500
Received: by ewy10 with SMTP id 10so3319984ewy.13
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 13:48:07 -0800 (PST)
In-Reply-To: <1229010762-3150-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 11 Dec 2008 17\:52\:19 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> This patch set provides DVFS support for OMAP3. First 16 patches contain
> clock framework modifications from Paul Walmsley, which are needed for VDD2
> OPP clock control to work properly. Rest of the patches are misc fixes for
> DVFS control, providing locking interface for OPPs and providing support
> for DPLL3 M2 rates higher than 2.

Tero, Paul,

It seems most of these can be applied dirctly to l-o, correct?  

Can you separate this out into two series?  One which goes straight to
l-o for all the SRAM, SDRC and clock stuff.  And a separate one which
applies to the PM branch for the DVFS fixes, updates etc.

Thanks,

Kevin
