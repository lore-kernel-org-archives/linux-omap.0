From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Enable Errata 430973 for OMAP3
Date: Thu, 9 Jun 2016 01:03:38 -0700
Message-ID: <20160609080337.GO22406@atomide.com>
References: <1463700017-18527-1-git-send-email-nm@ti.com>
 <20160609071512.GK22406@atomide.com>
 <20160609075734.GA8595@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160609075734.GA8595@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160609 01:00]:
> Hi,
> 
> On Thu, Jun 09, 2016 at 12:15:13AM -0700, Tony Lindgren wrote:
> > * Nishanth Menon <nm@ti.com> [160519 16:23]:
> > > Enable Erratum 430973 similar to commit 5c86c5339c56 ("ARM:
> > > omap2plus_defconfig: Enable ARM erratum 430973 for omap3") - Since
> > > multiple defconfigs can exist from various points of view (multi_v7,
> > > omap2plus etc.. it is always better to enable the erratum from the
> > > Kconfig selection point of view so that downstream kernels dont have
> > > to rediscover this all over again.
> > 
> > This should safe to select now. Note that proc-v7.S still does not
> > do anything with multiarch to configure it. So the bootloader still
> > needs to enable it, or it needs to be done in the machine init like
> > n900 does.
> 
> mh I totally forgot about 430973. I still think [0] is the
> better solution. IIRC I never uploaded them to Russel's
> patchsystem, though :(
> 
> [0] http://comments.gmane.org/gmane.linux.kernel/2002603

Sure makes sense to me. Meanwhile, Nishanth's patch prevents
hitting the same issue over and over.

Regards,

Tony
