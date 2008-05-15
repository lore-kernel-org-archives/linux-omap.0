From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Make N810 keyboard work with console
Date: Thu, 15 May 2008 10:22:00 -0700
Message-ID: <20080515172159.GO8928@atomide.com>
References: <1210824079-22548-1-git-send-email-tony@atomide.com> <20080515085852.GF12699@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55582 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYEORV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 13:21:59 -0400
Content-Disposition: inline
In-Reply-To: <20080515085852.GF12699@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel.stone@nokia.com>
Cc: linux-omap@vger.kernel.org

* Daniel Stone <daniel.stone@nokia.com> [080515 01:57]:
> On Wed, May 14, 2008 at 09:01:17PM -0700, ext Tony Lindgren wrote:
> > Here are few fun patches for N810 hackers to make the integrated
> > keyboard work with console :) This should be done in a generic way
> > and the old behaviour is preserved if optional sticky keys are not
> > passed from platform_data.
> 
> Uhm.  If you're going to implement latching/locking keys, surely it'd be
> better to do this in the generic input layer than the keyboard driver?

Yeah I agree it would be best to have the sticky keys handled in the
input layer in generic way in the long run. Doing it in a generic ways
would just require passing the flags with selected keys to input layer.

> NAK from myself (for what little that means) simply due to the sheer
> horror of seeing what should, by all rights, be a tiny driver, explode
> into non-triviality. :)

Well I'll take a look at some point how to move the is_sticky handling
to input layer. Meanwhile people can use this patch to have something
usable.

Tony
