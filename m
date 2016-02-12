From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] ARM: dts: OMAP3-N950-N9: Enable SSI module
Date: Fri, 12 Feb 2016 14:00:40 -0800
Message-ID: <20160212220039.GH19432@atomide.com>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453045749-22642-3-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160117 07:50]:
> The Nokia N950 and Nokia N9 have a modem attached to their
> first ssi port. This change adds all necessary information
> to initialize the SSI module, but does not yet add the
> modem information.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Picking this patch into omap-for-v4.6/dt thanks.

Tony
