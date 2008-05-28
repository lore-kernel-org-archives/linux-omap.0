From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.26-rc3-omap vs N810 and Xomap
Date: Tue, 27 May 2008 22:46:54 -0700
Message-ID: <20080528054654.GS8845@atomide.com>
References: <20080525203855.2f6037f6@gen2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52176 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbYE1Fq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 01:46:57 -0400
Content-Disposition: inline
In-Reply-To: <20080525203855.2f6037f6@gen2.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Radoslaw Szkodzinski <astralstorm@gen2.org>
Cc: linux-omap@vger.kernel.org

* Radoslaw Szkodzinski <astralstorm@gen2.org> [080525 11:49]:
> Hello,
> 
> I've managed to get 2.6.26-rc3-omap booting (was quite easy actually).
> Now I hit a road block - I get everything to start, it boots nicely
> (checked with SSH), but fails to display anything except a white screen.
> Looks like Xomap can't (re)init framebuffer, or focus isn't transferred
> to it.
> Any known possible reasons?

Do you have any patches applied in addition to patching the machine_id?

I don't know about xomap, but last time I tried xserver-xorg-xfbdev
from debian unstable worked. That is, without touchscreen until this
patch is merged:

https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/219424

Are you starting xomap from chroot?

Tony
