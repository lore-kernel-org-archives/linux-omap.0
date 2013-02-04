From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Mon, 4 Feb 2013 10:18:45 -0800
Message-ID: <20130204181844.GP22517@atomide.com>
References: <51090829.1010109@asianux.com>
 <20130201224546.GG22517@atomide.com>
 <510F78AB.4000602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751908Ab3BDSSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 13:18:52 -0500
Content-Disposition: inline
In-Reply-To: <510F78AB.4000602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Chen Gang <gang.chen@asianux.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130204 01:04]:
> Hi Tony,
> 
> On 02/01/2013 11:45 PM, Tony Lindgren wrote:
> > * Chen Gang <gang.chen@asianux.com> [130130 03:50]:
> >>
> >>   the fields must be null-terminated:
> >>   the caller may use it as null-terminted string, next.
> > 
> > Added Peter to cc on this one too, it's best that he queues
> > all the twl changes.
> 
> I can create a branch for you in our gitorious tree
> (git://gitorious.org/omap-audio/linux-audio.git) for this patch. But I think
> for now it would be best if you could take this via linux-omap (the file is
> under arch/arm/mach-omap2 anyways)

OK thanks I'll apply with your ack to omap-for-v3.9/fixes-noncritical.

Tony
