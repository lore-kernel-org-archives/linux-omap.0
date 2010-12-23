From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP USB Changes for Merge Window
Date: Thu, 23 Dec 2010 12:39:20 -0800
Message-ID: <20101223203920.GQ7771@atomide.com>
References: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56731 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab0LWUjZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 15:39:25 -0500
Content-Disposition: inline
In-Reply-To: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [101223 00:47]:
> Hi Tony,
> 
> please queue the following two patches for Merge Window.
> 
> The following changes since commit b79540fcbbcf9b379c9197f63c5a883bbe3adfd4:
> 
>    Linux-omap rebuilt: Merged branches from Paul and Kevin and mux changes (2010-12-22 19:13:33 -0800)

This can't be pulled as it would pull in tons of non-mainline
commits from the linux-omap master branch.

Everybody, all the pullable branches must be based on something
in the mainline kernel, like a recent -rc tag. If that won't work,
then some commit needs to be agreed on separately that will go
to mainline, like the omap-for-linus branch.

Further, please wait few days before sending the pull request
in case somebody wants to ack your patches. Sending a pull request
with the patches to be reviewed is kind of pointless.. Sure in this
case these are pretty trivial patches, but still.

Anyways, I'll apply these into a temporary branch and will
merge into omap-for-linus within next few days assuming no
problems.

Regards,

Tony
