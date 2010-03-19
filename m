From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 1/5] omap3: pm: fix for twl4030 script load
Date: Fri, 19 Mar 2010 10:32:06 -0700
Message-ID: <87wrx8xlnt.fsf@deeprootsystems.com>
References: <1268407878-22535-1-git-send-email-leslyam@ti.com>
	<87y6hpgqt7.fsf@deeprootsystems.com>
	<009b01cac725$3a475070$518918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f198.google.com ([209.85.216.198]:54658 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0CSRcK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 13:32:10 -0400
Received: by pxi36 with SMTP id 36so2365315pxi.21
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 10:32:09 -0700 (PDT)
In-Reply-To: <009b01cac725$3a475070$518918ac@apr.dhcp.ti.com> (Lesly Arackal Manuel's message of "Fri\, 19 Mar 2010 11\:00\:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly Arackal Manuel <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

"Lesly Arackal Manuel" <leslyam@ti.com> writes:

[...]

> Please fix the changelog to not only summarize *what* is being changed,
> but *why*.
>
> [Lesly] Why the order is not important.
> Since each seq is independent and not falling trough any other seq.
> Only thing we have to do is program the start address of each seq correctly.

The point is that this needs to be summarized better in the changelog.

You need to explain it in general way so even folks who are not
intimately involved with the code as you are can understand the
motiviation behind the change.

Kevin
