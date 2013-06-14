From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/6] omap cleanup for v3.11 merge window
Date: Fri, 14 Jun 2013 14:28:15 -0700
Message-ID: <20130614212815.GB17326@quad.lixom.net>
References: <pull-1371061475-206272>
 <51b8bce9.1265310a.49c1.ffff940eSMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44828 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab3FNV2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 17:28:10 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so1024400pab.31
        for <linux-omap@vger.kernel.org>; Fri, 14 Jun 2013 14:28:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51b8bce9.1265310a.49c1.ffff940eSMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Jun 12, 2013 at 11:24:33AM -0700, Tony Lindgren wrote:
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/cleanup-signed
> 
> for you to fetch changes up to 09182ab11b49b67d04598b19eb89cf0bbd672a60:
> 
>   ARM: OMAP4: hwmod data: Remove irq entries from mcspi, mmc hwmods (2013-06-12 09:41:46 -0700)
> 
> ----------------------------------------------------------------
> Move omap4 over to device tree based booting. This allows us to get rid
> a big pile of platform init code for things that are already handled by
> device tree related code. As am33xx is already device tree based, we
> can also remove the same data for am33xx.

Hm. This one has a somewhat silly conflict with the am33xx hwmod fix for uart2.
I.e. the fix is reverted since the code is no longer needed -- data comes from
device tree. Please double-check my merge resolution on it though.


-Olof
