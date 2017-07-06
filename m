From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/2] ARM: add missing includes to header files
Date: Thu, 6 Jul 2017 16:16:07 +0100
Message-ID: <20170706151607.GC23750@n2100.armlinux.org.uk>
References: <20170704132542.27644-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704132542.27644-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 04, 2017 at 03:25:40PM +0200, Johan Hovold wrote:
> Add two missing include directives to two header files to avoid
> compile breakage when the required symbols have not already been
> defined.
> 
> The missing SCU include broke compilation of the (not-yet-merged)
> suspend support for am335x when !CONFIG_HAVE_ARM_SCU for example:
> 
> 	https://lkml.kernel.org/r/20170704131441.GH27842@localhost

These look reasonable, please send them to the patch system for merging
after this merge window, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
