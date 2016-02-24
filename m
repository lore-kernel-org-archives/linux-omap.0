From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] HSI: omap-ssi: add clk change support
Date: Wed, 24 Feb 2016 16:19:09 +0100
Message-ID: <4852048.rpY1LniVlK@wuerfel>
References: <1454201558-31285-1-git-send-email-sre@kernel.org> <1454201558-31285-3-git-send-email-sre@kernel.org> <20160223023443.GB19629@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223023443.GB19629@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 23 February 2016 03:34:43 Sebastian Reichel wrote:
> 
> On Sun, Jan 31, 2016 at 01:52:38AM +0100, Sebastian Reichel wrote:
> > This adds support for frequency changes of the SSI
> > functional clock, which may occur due to DVFS.
> 
> I queued this one for 4.6.
> 

This causes a regression when SSI is a loadable module:

ERROR: "omap_ssi_port_update_fclk" [drivers/hsi/controllers/omap_ssi.ko] undefined!

I suspect that there is now some form of circular dependency between the
various modules, but I couldn't figure it out. Can you have a look,
and maybe revert the commit in linux-next for the time being?

	Arnd
