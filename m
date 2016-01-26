From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: hwmod data: Add SSI data for omap36xx
Date: Wed, 27 Jan 2016 00:12:13 +0200
Message-ID: <20160126221213.GH15550@darkstar.musicnaut.iki.fi>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-2-git-send-email-sre@kernel.org>
 <20160126220738.GG15550@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126220738.GG15550@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Jan 27, 2016 at 12:07:38AM +0200, Aaro Koskinen wrote:
> On Sun, Jan 17, 2016 at 04:49:05PM +0100, Sebastian Reichel wrote:
> > This patch enables Synchronous Serial Interface (SSI)
> > hwmod support for OMAP36xx SoCs (used by Nokia N950/N9).
> > 
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This applies to whole series (1/5). I was able to use gprs data connection
to connect to internet with N950 + v4.5-rc1 + these patches.

Thanks,

A.
