From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Tue, 17 Feb 2009 16:07:56 -0800
Message-ID: <20090218000756.GH11928@atomide.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com> <20090213085827.d516d6aa.jarkko.nikula@nokia.com> <20090213222100.GJ7562@atomide.com> <20090215213559.0a6653a1.jhnikula@gmail.com> <20090215214501.c7386464.jhnikula@gmail.com> <499996EC.4030108@nokia.com> <20090217112513.303d62e6.jhnikula@gmail.com> <20090217235018.GF11928@atomide.com> <20090217235956.GL24800@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53680 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZBRAH6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 19:07:58 -0500
Content-Disposition: inline
In-Reply-To: <20090217235956.GL24800@guug.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Otto Solares <solca@guug.org>
Cc: linux-omap@vger.kernel.org

* Otto Solares <solca@guug.org> [090217 16:00]:
> On Tue, Feb 17, 2009 at 03:50:18PM -0800, Tony Lindgren wrote:
> > Aaro, can you please send a proper patch with Signed-off-by and I'll
> > add it to omap-fixes?
> 
> Tony: what's the purpose of omap-fixes and the difference between
> master and omap-2.6.28? if I want a "stable" kernel which branch
> should I use?

Here's the quick rundown:

- master branch is current linux-omap against recent mainline kernel

- omap-fixes is the branch for fixes going to mainline during -rc cycle

- omap-upstream is a branch of generic omap patches going to mainline
  during the next merge window

- omap1-upstream is a branch of omap1 patches going to mainline during
  the next merge cycle

- omap2-upstream is a branch of omap2 patches going to mainline during
  the next merge cycle

- omap3-upstream is a branch of omap3 patches going to mainline during
  the next merge cycle

- omap-next branch is what gets pulled into linux-next and gets merged
  to the mainline the next merge window

The omap-2.6.28 branch is there because there were few bugs and I
thought we might want to tag v2.6.28-omap2. Mostly getting the MMC
working for omap1 as far as I remember.

For "stable" you should use the whatever omap tag we have against the
recent mainline kernel, so yeah, it would be the omap-2.6.28 branch
right now.

Regards,

Tony
