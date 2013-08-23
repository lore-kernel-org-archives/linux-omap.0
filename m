From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: hwmod-data: Add SSI information
Date: Fri, 23 Aug 2013 18:53:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308231852070.22768@utopia.booyaka.com>
References: <1376237628-1077-1-git-send-email-sre@debian.org> <1376237877-1740-1-git-send-email-sre@debian.org> <alpine.DEB.2.02.1308210113040.6426@utopia.booyaka.com> <20130823182928.GD5753@earth.universe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130823182928.GD5753@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, Kevin Hilman <khilman@deeprootsystems.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, 23 Aug 2013, Sebastian Reichel wrote:

> On Wed, Aug 21, 2013 at 01:22:09AM +0000, Paul Walmsley wrote:
> > > From: Sebastian Reichel <sre@ring0.de>
> > > This patch adds Synchronous Serial Interface (SSI) hwmod support for
> > > OMAP34xx SoCs.
> > 
> > a few comments:
> > 
> > - please add your Signed-off-by: to the patch description, per 
> > Documentation/SubmittingPatches
> 
> I assumed this was only important, when I actually want to submit
> patches.  This was merely a first RFC. I will do this for the next
> round of patches.

OK makes sense.  Just FYI, usually when folks send out RFCs, they put 
"RFC" in the patch description for each patch.  So the subject line might 
read:

[RFC PATCH 1/3] ARM: OMAP2+: hwmod-data: Add SSI information

> > - please drop "omap34xx_ssi_irqs" and "omap34xx_ssi_addrs" - that data 
> > should go into DT now
> 
> I'm currently working on converting the driver to use DT.
> I will send another patch when I'm done.

OK great.


- Paul
