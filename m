From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/2] omap fixes for v3.10 merge window part2
Date: Thu, 9 May 2013 13:15:04 -0700
Message-ID: <20130509201504.GA21598@quad.lixom.net>
References: <518bef23.e79f320a.5202.ffffc873SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51350 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3EIUPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 May 2013 16:15:04 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so2370251pab.35
        for <linux-omap@vger.kernel.org>; Thu, 09 May 2013 13:15:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <518bef23.e79f320a.5202.ffffc873SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, May 09, 2013 at 11:46:51AM -0700, Tony Lindgren wrote:
> The following changes since commit 956e46efb2478ebff7a871138458fa8124fd18dd:
> 
>   mm/slab: Fix crash during slab init (2013-05-08 15:02:33 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window-part2
> 
> for you to fetch changes up to b1dd11d60e5357c13d3f3decfb69bd07dde159bd:
> 
>   ARM: OMAP2+: Remove bogus IS_ERR_OR_NULL checking from id.c (2013-05-09 09:06:27 -0700)

Pulled, thanks.

As Arnd mentioned on an ux500 pull request earlier, we usually don't like
fixes branches on non-rc bases, but since this is targeting pre-rc1 but
post-what-we-merged, there's not much else to do.


-Olof
