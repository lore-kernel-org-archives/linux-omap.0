From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] Integrate the twl4030 power code into new twl4030
	mfd
Date: Fri, 24 Oct 2008 15:53:14 -0700
Message-ID: <20081024225314.GM16354@atomide.com>
References: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com> <87skql62k6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53999 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYJXWxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 18:53:17 -0400
Content-Disposition: inline
In-Reply-To: <87skql62k6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [081024 15:39]:
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> 
> > This patchset integrates the twl4030 power code into the new twl4030 mfd framework.
> > The scripts will be moved to the board specific data.
> >
> > Peter 'p2' De Schrijver (6):
> >   Add defines and data types for twl4030.
> >   Move existing TWL4030 code to drivers/mfd
> >   Hook twl4030 power code into twl4030 core.
> >   3430sdp and ldp use custom twl4030 power scripts.
> >   Generic twl4030 power script for 3430 based boards.
> >   omap3 evm, beagle and overo use the generic twl4030 script
> 
> Tony,
> 
> This looks good to me.  Rather than pull this into pm-<next>, this
> could go straight into linux-omap, and then Peter should submit to
> mainline.

OK, sounds good to me.

Tony
