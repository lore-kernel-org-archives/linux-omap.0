From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/3] omap defconfig changes for v4.1
Date: Fri, 3 Apr 2015 10:50:20 -0700
Message-ID: <20150403175020.GD23023@localhost>
References: <pull-1426799683-420388>
 <550b5961.65f8420a.142c.ffff9cfeSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35624 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbDCRuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 13:50:23 -0400
Received: by patj18 with SMTP id j18so122463033pat.2
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2015 10:50:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <550b5961.65f8420a.142c.ffff9cfeSMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Mar 19, 2015 at 04:14:00PM -0700, Tony Lindgren wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/v4.1-defconfig
> 
> for you to fetch changes up to 1fd6d08cbd4bd8984241c7cef2f7c5cb67fce1aa:
> 
>   ARM: omap2plus_defconfig: Enable n900 modem as loadable modules (2015-03-16 12:48:44 -0700)
> 
> ----------------------------------------------------------------
> Few omap2plus_defconfig updates to add commonly used drivers as
> loadable modules.
> 
> Note that I'll do patches for armv7_defconfig for these at some
> point too once we're happy with omap2plus_defconfig to avoid
> extra churn on the defconfig files.

Merged, thanks.

-Olof
