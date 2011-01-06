From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Current OMAP build failures
Date: Thu, 6 Jan 2011 18:03:45 +0000
Message-ID: <20110106180345.GG1198@n2100.arm.linux.org.uk>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk> <878vyyx8s4.fsf@ti.com> <20110106171019.GF1198@n2100.arm.linux.org.uk> <20110106174950.GU7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48203 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1AFSD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:03:56 -0500
Content-Disposition: inline
In-Reply-To: <20110106174950.GU7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 06, 2011 at 09:49:51AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 09:09]:
> > On Thu, Jan 06, 2011 at 09:05:15AM -0800, Kevin Hilman wrote:
> > > Hi Russell,
> > > 
> > > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > 
> > > > I've observed the following issues while building 2.6.37 + my devel
> > > > branch.  I don't believe any of them to be due to anything in my tree,
> > > > so would be in 2.6.37 as well.
> > > 
> > > What defconfig are you using for these builds?
> > 
> > I couldn't say offhand because they're built from configs created a while
> > back.  I tend to just re-run the build with appropriate O= arguments to
> > test things.
> > 
> > I can send the defconfigs if it'd help.
> 
> I have the following patch queued up as commit be40f7a3d7b53c1a44e11b376b4a395d6b91f58d
> which should fix the compile error you're seeing. This seems to be related
> to some option in the .config that's not happening with any of the
> defconfigs.

That'll be because I have:

CONFIG_I2C_OMAP=y

in my config, whereas most OMAP1 defconfigs don't have it enabled with
the exception of omap_h2_1610_defconfig.
