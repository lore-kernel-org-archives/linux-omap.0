From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP: L3 interconnect: Error reporting cleanups
Date: Wed, 25 May 2011 12:39:56 +0530
Message-ID: <4DDCAB44.2060006@ti.com>
References: <20110525025021.GA8460@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34014 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751974Ab1EYHKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 03:10:03 -0400
Received: by ywg8 with SMTP id 8so3096887ywg.6
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 00:10:01 -0700 (PDT)
In-Reply-To: <20110525025021.GA8460@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Tod,
On 5/25/2011 8:20 AM, Todd Poynor wrote:
> * Move variable declarations from header file and make these static
>    (the entire header file should probably go away).
>
Infact the intial version posted on the list had all these structures
in C file. After some comments on the list we moved them to header file.
Let's not move it again.

> * Define L3 TARG instance offsets, and read/write STDERRLOG registers
>    relative to those offsets, rather than defining STDERRLOG_MAIN
>    instance offsets and accessing other registers via offsets from
>    that register.
>
> * Use ffs() to find error source from the L3_FLAGMUX_REGERRn
>    register.
>
> * Remove extra l3_base[] entry.
>
> * Modify L3 custom error message for consistency with standard
>    error message.
>
These changes are ok.

> * Fixup indentation in one spot.
>
This code indentations needs more fixing and I have patch to
clean that up. Your change is already part of that patch.


> ---
>   arch/arm/mach-omap2/omap_l3_noc.c |  122 +++++++++++++++++++++++++++++++------
>   arch/arm/mach-omap2/omap_l3_noc.h |   88 +-------------------------
>   2 files changed, 106 insertions(+), 104 deletions(-)
>
Can you update your patch with above. I will add that along with other
L3 clean-up patch.

Thanks

regards
Santosh
