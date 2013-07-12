From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for v3.11 merge window
Date: Fri, 12 Jul 2013 10:57:17 -0700
Message-ID: <20130712175717.GA27575@quad.lixom.net>
References: <20130710080241.GN5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61158 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933186Ab3GLR5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 13:57:17 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so9263696pad.0
        for <linux-omap@vger.kernel.org>; Fri, 12 Jul 2013 10:57:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130710080241.GN5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Jul 10, 2013 at 01:02:41AM -0700, Tony Lindgren wrote:
> The following changes since commit ddcf6600b133697adbafd96e080818bdc0dfd028:
> 
>   Merge tag 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2013-07-03 19:56:35 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-for-merge-window


Thanks, merged. There was a quite verbose merge conflict due to the changes of
the Kconfig in our fixes branch, so please double-check my resolution.


-Olof
