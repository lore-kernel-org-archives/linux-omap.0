From: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [2.6.29-rc7][take #2][PATCH 2/3] ARM: OMAP: Add command line
 option for I2C bus speed
Date: Tue, 17 Mar 2009 10:24:51 +0200
Message-ID: <20090317102451.dba5650b.jarkko.nikula@nokia.com>
References: <20090306161349.GC32353@atomide.com>
	<1236674831-3637-1-git-send-email-jarkko.nikula@nokia.com>
	<1236674831-3637-2-git-send-email-jarkko.nikula@nokia.com>
	<1236674831-3637-3-git-send-email-jarkko.nikula@nokia.com>
	<20090316172908.GA19229@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090316172908.GA19229-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 16 Mar 2009 18:29:08 +0100
ext Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> * Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [090310 01:47]:
> > This patch adds a new command line option "i2c_bus=bus_id,clkrate"
> > into I2C bus registration helper. Purpose of the option is to
> > override the default board specific bus speed which is supplied by
> > the omap_register_i2c_bus.
> > 
> > The default bus speed is typically set to speed of slowest I2C chip
> > on the bus and overriding allow to use some experimental
> > configurations or updated chip versions without any kernel
> > modifications.
> 
> Thanks for updating this. I've updated my omap-upstream series with
> your patches #2 and #3, looks like #1 did not need updating.
> 
Yep, no changes in #1 and it can go anyway as it since it only adds a
bit documentation to the arch/arm/plat-omap/i2c.c.

However we haven't received any comments to the patches #2 and #3
adding new command line option "i2c_bus=bus_id,clkrate" so let's see do
they go :-)


Jarkko
