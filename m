From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] w1: masters: omap_hdq: Add support for 1-wire mode
Date: Fri, 27 Feb 2015 10:55:12 +0100
Message-ID: <10805905.OnX7kRTk9d@wuerfel>
References: <1425029057-5075-1-git-send-email-vigneshr@ti.com> <1425029057-5075-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425029057-5075-2-git-send-email-vigneshr@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 27 February 2015 14:54:17 Vignesh R wrote:
> +- compatible : should be "ti,omap3-1w" or "ti,am43xx-hdq"
> 

Do not use wildcards in the compatible string, use real part numbers
if you don't know the actual name of the device.

	Arnd
