From: Tony Lindgren <tony@atomide.com>
Subject: Re: suggestions for latest code that offers best support of
	OMAP35x EVM
Date: Thu, 30 Oct 2008 10:41:15 -0700
Message-ID: <20081030174114.GW13227@atomide.com>
References: <dbdb2ea60810300917r4dbb22b8te5af06ff99f9eaed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54335 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbYJ3RlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 13:41:16 -0400
Content-Disposition: inline
In-Reply-To: <dbdb2ea60810300917r4dbb22b8te5af06ff99f9eaed@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* twebb <taliaferro62@gmail.com> [081030 09:22]:
> Not being very familiar with the kernel development process and git,
> I'm hoping someone can suggest which code from the l-o git offers the
> best support of the OMAP35x EVM.  I'm guessing it would be the code
> tagged "v2.6.27-omap1" but I'm not sure.  What's the general
> difference between tags "v2.6.27" and "v2.6.27-omap1"?

The difference is v2.6.27 is a tag by Linus, v2.6.27-omap1 is the
first patchset of omap patches on top of Linus' v2.6.27.

If we need to add more omap specific fixes on top of that, we'll
tag v2.6.27-omap2 and so on.

> On a more general note, is there documentation somewhere that
> describes the kernel development process, and how tags are used (or
> not) to identify particular stability points in the development
> lifecycle of a particular tree (like linux-omap)?

There are various git howto sites, also read Documentation/Submit*.

I'm not aware of any docs that would describe the -rc tags and merge
windows, but I'm sure something like that exists somewhere :)

Anybody got a link?

Tony
