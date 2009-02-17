From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: Question regarding how to submit patches
Date: Tue, 17 Feb 2009 02:43:27 +0200
Message-ID: <20090217004327.GA14031@everest.verdurent.com>
References: <1234799464.3238.460.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:41954 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbZBQAnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 19:43:32 -0500
Received: by ewy14 with SMTP id 14so2103662ewy.13
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 16:43:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1234799464.3238.460.camel@blackhole>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap@vger.kernel.org

On Mon, Feb 16, 2009 at 10:51:03AM -0500, Peter Barada wrote:
> Does anyone have a pointer on how to prepare patches for inclusion into
> the linx-omap tree(s)?  I'm looking for something that demonstrates it
> as I'm quite unfamiliar with git...

The kernel source has a file Documentation/SubmittingPatches that outlines the basic steps in getting your changes upstream. Kernelnewbies[1] also has a good list of dos and don'ts.

You don't _have_ to use git to submit patches, unified diffs are fine.

Regards,
Amit

[1] http://kernelnewbies.org/UpstreamMerge

-- 
-------------------------------------------------------------------------
Amit Kucheria			amit _dot_ kucheria@<NOSPAM>verdurent.com
Kernel Developer, Verdurent
--------------------------------------------------------------------------
