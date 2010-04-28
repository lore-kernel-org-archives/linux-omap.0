From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 4/5] omap3: pm: Use generic TRITON power scripts for 3430SDP board
Date: Wed, 28 Apr 2010 16:03:18 -0700
Message-ID: <87k4rr9o3t.fsf@deeprootsystems.com>
References: <1271677417-2167-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:39087 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab0D1XDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 19:03:22 -0400
Received: by iwn12 with SMTP id 12so4654213iwn.15
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 16:03:21 -0700 (PDT)
In-Reply-To: <1271677417-2167-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Mon\, 19 Apr 2010 17\:13\:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> This patch will removed the sleep/wakeup/warm_rest sequence from the
> 3430SDP board file and use the generic script.
>
> Modified the resource config structure in the board file for using
> generic script. Updating the sleep/wakeup/warm_rest sequence & voltsetup_time
> in the board file from generic script file.

Unless I missed something, a quick look at the resource configs for
SDP and Zoom[23] and they look identical to me.

That suggest to me something that should probably also live in
twl4030.c as a default resource config.  Otherwise, we'll be copying
that between all the board files too.

Kevin
