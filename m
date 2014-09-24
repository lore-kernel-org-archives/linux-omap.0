From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/5] omap soc changes for v3.18 merge window
Date: Tue, 23 Sep 2014 22:07:40 -0700
Message-ID: <20140924050740.GA30340@localhost>
References: <pull-1410478051-378788>
 <5412304a.04a8440a.56eb.ffff9329SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48719 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbaIXFih (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2014 01:38:37 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so678573pad.35
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2014 22:38:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5412304a.04a8440a.56eb.ffff9329SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Sep 11, 2014 at 04:28:55PM -0700, Tony Lindgren wrote:
> The following changes since commit d7eb67f7fef9c046f27a975118da2324de65a90c:
> 
>   Merge branch 'pull/v3.18/powerdomain-fixes' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.18/fixes-not-urgent (2014-09-08 15:04:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/soc-for-v3.18
> 
> for you to fetch changes up to 377fb3f5d9a34b2913939e0620c1c585b5913bab:
> 
>   ARM: OMAP5+: Reuse OMAP4 PM code for OMAP5 and DRA7 (2014-09-09 19:13:41 -0700)
> 
> ----------------------------------------------------------------
> SoC related changes for omaps for v3.18 merge window:
> 
> - PM changes to make the code easier to use on newer SoCs
> - PM changes for newer SoCs suspend and resume and wake-up events
> - Minor clean-up to remove dead Kconfig options
> 
> Note that these have a dependency to the fixes-v3.18-not-urgent
> tag and is based on a commit in that series.

Merged. Note that this also has a fresh conflict with the latest fixes,
so please check that I resolved it correctly.



-Olof
