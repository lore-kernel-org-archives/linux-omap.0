From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: omap: Add empty chosen node in SoCs top level
 DTSI
Date: Tue, 27 Dec 2016 09:30:15 -0800
Message-ID: <20161227173015.GP4920@atomide.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Pali Rohar <pali.rohar@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [161219 06:45]:
> Hello Tony,
> 
> As discussed in [0], there's a regression when booting a kernel with a DTB
> that doesn't have a pre-existing chosen node. This is usually not an issue
> for most boards since u-boot creates an empty chosen node if isn't present
> in the DTB.
> 
> But it can be an issue for others bootloaders as Pali pointed out with the
> N9/900/950 phones and the Nokia Loader (NoLo).
> 
> This patch series add chosen nodes in the top level DTSI for all OMAP SoCs.
> 
> [0]: http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1294379.html

Applying these into omap-for-v4.10/fixes thanks.

Tony
