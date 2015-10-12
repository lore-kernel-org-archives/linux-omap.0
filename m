From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Use defined GPIO constants in flags cell for
 OMAP2+ boards
Date: Mon, 12 Oct 2015 15:52:55 -0700
Message-ID: <20151012225255.GL23801@atomide.com>
References: <1444122219-30419-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444122219-30419-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [151006 02:08]:
> Many OMAP2+ DTS are not using the defined constants to express
> the GPIO polarity. Replace these so the DTS are easier to read.


Applying this into omap-for-v4.4/dt thanks.

Tony
