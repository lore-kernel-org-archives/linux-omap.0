From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 2/5] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Thu, 18 Mar 2010 16:29:39 -0700
Message-ID: <87eijhgqe4.fsf@deeprootsystems.com>
References: <1268407891-22559-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:39627 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab0CRX3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 19:29:45 -0400
Received: by ywh2 with SMTP id 2so330101ywh.33
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 16:29:45 -0700 (PDT)
In-Reply-To: <1268407891-22559-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Fri\, 12 Mar 2010 21\:01\:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Copied the setuptime in each board file, since OMAP3430 & OMAP3630
> has different voltage levels for the same states.

So that suggests there should be 2 tables (one per SoC), rather than
one for each board file.  IOW, the setup times are SoC specific, not
board specific, so they don't belong in board files.

Kevin
