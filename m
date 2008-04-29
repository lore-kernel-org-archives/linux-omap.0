From: Brian Swetland <swetland@google.com>
Subject: Re: Android on N810 File System Problem
Date: Tue, 29 Apr 2008 02:00:32 -0700
Message-ID: <20080429090032.GA25363@bulgaria.corp.google.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com> <48116F5C.9040009@googlemail.com> <20080425183605.GA27479@kedavra.cpe.vivax.com.br> <87fxt7my4o.fsf@nokia.com> <20080427223248.GA5962@kedavra.cpe.vivax.com.br> <20080428233827.GE8449@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:61388 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761321AbYD2JBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 05:01:19 -0400
Content-Disposition: inline
In-Reply-To: <20080428233827.GE8449@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Kalle Valo <kalle.valo@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

[Tony Lindgren <tony@atomide.com>]
> 
> I've merged Jarkko's asoc patch to linux-omap for testing. Have not
> gotten any sound out of it on my n810 though.. Maybe some alsamixer
> settings issue?
> 
> Kalle, do you have any tips on getting WLAN to work on n8x0?

This was the show-stopper for me.  When I last got things hobbling
along on n8x0, the binary-only wlan module was incompatible with
newer kernels than 2.6.21 (changes in some network data structures).

The newer android builds expect 2.6.24 or more recent.  I'm hoping
that Nokia will release a newer build of the wlan module for 2.6.24
at some point.  That'd be a big motivator for me to spend time hacking
on the platform again.

The other thing I'd like to sort out is how to interact with the
battery charging and status without needing proprietary userspace
code.  Probably a lot easier to reverse engineer than the wlan driver
at least.

Brian
