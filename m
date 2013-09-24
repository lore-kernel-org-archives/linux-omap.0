From: Rob Landley <rob@landley.net>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Mon, 23 Sep 2013 21:13:20 -0500
Message-ID: <1379988800.1974.68@driftwood>
References: <20130923235917.GA30967@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35242 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab3IXCNY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Sep 2013 22:13:24 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so4273303obc.6
        for <linux-omap@vger.kernel.org>; Mon, 23 Sep 2013 19:13:23 -0700 (PDT)
In-Reply-To: <20130923235917.GA30967@amd.pavel.ucw.cz> (from pavel@ucw.cz on
	Mon Sep 23 18:59:17 2013)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Will Deacon <will.deacon@arm.com>, Trivial patch monkey <trivial@kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>

On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
> During 3.12-rc, Will Deacon introduced code into arch/arm that
> requires binutils 2.22.

Um, my toolchain is using the last gplv2 snapshot of binutils out of  
git, which is just past 2.17 and can build armv7 (but not armv8).

Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some  
thought to have gone into that? Possibly a mention of it?

> diff --git a/Documentation/Changes b/Documentation/Changes
> index b175808..0f8deaf 100644
> --- a/Documentation/Changes
> +++ b/Documentation/Changes
> @@ -23,7 +23,7 @@ you probably needn't concern yourself with  
> isdn4k-utils.
> 
>  o  Gnu C                  3.2                     # gcc --version
>  o  Gnu make               3.80                    # make --version
> -o  binutils               2.12                    # ld -v
> +o  binutils               2.22                    # ld -v

When the sh4 platform did this, I just reverted the patch. (It still  
reverts cleanly ~4 years later, and builds with my old tool versions...)

Rob