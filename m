From: Brian Swetland <swetland@google.com>
Subject: Re: Android on OMAP, possibly useful git.android.com update
Date: Wed, 2 Apr 2008 03:05:44 -0700
Message-ID: <20080402100544.GA26856@bulgaria.corp.google.com>
References: <005301c874f5$8a11c8d0$16110a0a@LongCheer.net> <47BE708F.4000802@googlemail.com> <3B6D69C3A9EBCA4BA5DA60D913027429039398E4@dlee13.ent.ti.com> <20080224095216.GA5131@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:38060 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYDBKGX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 06:06:23 -0400
Content-Disposition: inline
In-Reply-To: <20080224095216.GA5131@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Dirk Behme <dirk.behme@googlemail.com>, colorant <colorant@163.com>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com

[Brian Swetland <swetland@google.com>]
> 
> I'm hoping to get a public git repository put together with the 
> various android-specific kernel patches (binder, logger, alarm drivers,
> goldflish platform support, etc) soon.  This should at least make
> it easier for folks to merge various drivers 'n things into their
> working trees, rather than having to extract them from the kernel
> source tarball provided with emulator/sdk releases.

The core android kernel patches are now available from git.android.com.
Please be aware that these are *newer* than the M5 SDK, and I think
the binder driver in particular may not be compatible with M5.  When
the next SDK release happens, we should be able to point at a sha1
hash of the git change the kernel came from.

http://git.android.com/?p=kernel.git;a=shortlog;h=android
git://git.android.com/kernel.git

Please note that for legacy reasons the default branch is the
msm-2.6.24 branch -- you'll want to check out the "android"
branch if you're looking for the generic patches useful for
all platforms.

Enjoy,

Brian

