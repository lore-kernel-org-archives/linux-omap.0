From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap header cleanup to make headers local for v3.7
 merge window
Date: Thu, 20 Sep 2012 20:29:46 -0700
Message-ID: <20120921032946.GA22479@quad.lixom.net>
References: <20120920230935.GM28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46206 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab2IUD3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 23:29:36 -0400
Received: by pbbrr4 with SMTP id rr4so1628635pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 20:29:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120920230935.GM28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Sep 20, 2012 at 04:09:36PM -0700, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Here's one more branch to take us a bit closer to getting the
> single zImage working on omaps. It would be nice to get merged
> into arm-soc/next/cleanup before the merge window if still
> possible.
> 
> I've based it on top of Arnd's 2203747c (ARM: omap: move
> platform_data definitions) to avoid more merge conflicts,
> and it seems to merge with few trivial include conflicts
> with current linux next and arm-soc/for-next.

Done, pulled in as omap/cleanup-headers and into next/cleanup.


-Olof
