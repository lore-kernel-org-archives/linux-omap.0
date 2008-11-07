From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [patch 2.6.28-rc3-omap git] hsmmc gpio updates
Date: Fri, 7 Nov 2008 06:19:25 -0800
Message-ID: <5e088bd90811070619h73120f30ye7608e2aaff5e514@mail.gmail.com>
References: <200811062115.30519.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:38178 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYKGOT1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 09:19:27 -0500
Received: by nf-out-0910.google.com with SMTP id d3so614218nfc.21
        for <linux-omap@vger.kernel.org>; Fri, 07 Nov 2008 06:19:25 -0800 (PST)
In-Reply-To: <200811062115.30519.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Thu, Nov 6, 2008 at 9:15 PM, David Brownell <david-b@pacbell.net> wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
>
> Rework card detect GPIO handling in the twl4030 MMC glue:  drive
> it *only* from the hsmmc_info passed; remove most of remaining
> "we know we're always a twl4030 GPIO" logic.
>
> Add write-protect switch detection support to that glue.  Stub
> in a not-present WP GPIO into most boards.  (Beagle's is real.)
>
> Teach the hsmmc driver how to use the card detect and writeprotect
> methods, and move some data structure init earlier so that when IRQs
> come in, more of the data used by their handlers is initialized.
>
> Verified on Beagle (WP, card detect events) and Overo (boots, both
> card and wlan are seen).  Beagle behaves fully, and is the model
> to follow for the common case where the TWL4030 gpio-0 card detect
> magic is used.

Nice work!  Overo uses TWL4030 gpio-0 for card detect (just like
Beagle) and GPIO-54 for WP.

Would you like me to prepare a patch to add on top of yours or would
you prefer to add it to yours (if you have a revision planned)?

Steve
