From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 5/5] omap dt changes for v3.10 merge window
Date: Thu, 11 Apr 2013 04:06:45 -0700
Message-ID: <20130411110645.GA8802@quad.lixom.net>
References: <pull-1365483063-475562>
 <51639e43.d294dc0a.2f07.03b4SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57102 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3DKLGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Apr 2013 07:06:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so849999pad.17
        for <linux-omap@vger.kernel.org>; Thu, 11 Apr 2013 04:06:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51639e43.d294dc0a.2f07.03b4SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Mon, Apr 08, 2013 at 09:51:03PM -0700, Tony Lindgren wrote:
> The following changes since commit 5852264f9d6139751796853fdfca9d5230cbfb97:
> 
>   Merge tag 'omap-devel-b-for-3.10' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into for_3.10/dts_merged (2013-04-09 00:11:05 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dt-signed-v2
> 
> for you to fetch changes up to 161e89a689bb88004b757986eefda2402448eef7:
> 
>   ARM/dts: OMAP3: fix pinctrl-single configuration (2013-04-08 17:00:22 -0700)
> 
> ----------------------------------------------------------------
> Device tree updates for omaps via Benoit Cousson <b-cousson@ti.com>.
> 
> Note that the branch has dependencies to two other branches:
> 
> - omap-devel-b-for-3.10 from Paul to get the AM33xx missing
>   hwmod and thus avoid a regression with Santosh's hwmod
>   cleanup including in this DT series [1]. It avoids breaking
>   bisect if this series is merged before Paul's fixes.

Looks like this was part of omap/fixes-non-critical, the branch name from Paul
just didn't percolate up. At least the topmost SHA from that merge in your
history seems to be part of said branch. :)


> - omap-for-v3.10/usb branch to avoid nasty merge conflict in
>   omap3.dtsi and omap4.dtsi due to the DTS patches contained
>   in the USB branch because of a screw up by the unnamed person
>   typing this signed tag based on Benoit's comments.


Ok, it looks like this one was merged in next/drivers as omap/usb.


So based on the above, I've merged in omap/fixes-non-critical and omap/usb as
a base, and merged this on top. All of this has gone into next/dt2.

-Olof
