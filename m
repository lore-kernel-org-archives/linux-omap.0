From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] arm: dts: gta04: add gps support
Date: Wed, 30 Jan 2019 10:04:34 +0100
Message-ID: <20190130090434.GM3691@localhost>
References: <20190129073843.14979-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129073843.14979-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 29, 2019 at 08:38:43AM +0100, Andreas Kemnade wrote:
> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> which one is mounted so use the compatibility entry for w2sg0004
> for all which will work for both.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - some s/gps/gnss/
> - not added vcc-supply because the regulator is not modelled
>   in dts at all

I strongly suggest not sending revised patches before people have a
chance to comment on your previous version and resolve any issues that
may have been raised.

Also it is customary to CC anyone how bothers to help review your
patches.

Johan
