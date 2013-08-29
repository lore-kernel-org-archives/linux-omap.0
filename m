From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] late dra7xx PRCM and hwmod support for v3.12
 merge window
Date: Thu, 29 Aug 2013 16:46:33 -0700
Message-ID: <20130829234633.GE29606@quad.lixom.net>
References: <pull-1377526896-974252>
 <521b6476.4902310a.1183.6ea6SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50299 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3H2XrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 19:47:12 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so1570549pab.10
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 16:47:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <521b6476.4902310a.1183.6ea6SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Aug 26, 2013 at 07:21:36AM -0700, Tony Lindgren wrote:
> The following changes since commit cf470a1b1a741bca00080ebc70968b4f22d9b1ea:
> 
>   Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc (2013-08-14 01:01:41 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/dra7xx-prcm
> 
> for you to fetch changes up to e3e1970f892d873e0f01c4516eaf986ae3a91e13:
> 
>   Merge tag 'for-v3.12/dra7xx' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.12/soc (2013-08-26 02:53:05 -0700)

I contemplated holding this off for 3.13 given the volume of code this late,
but since it's all for new platform I'll merge it in.


-Olof
