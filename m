From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: Fix WLAN compatible
Date: Mon, 12 Jun 2017 00:30:21 -0700
Message-ID: <20170612073021.GR3730@atomide.com>
References: <20170608211608.9051-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170608211608.9051-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170608 14:19]:
> Motorola Droid 4 uses a WL1285C, so use proper compatible value.
> To avoid regressions while support for the new compatible value
> is added to the Linux kernel, the old compatible value is preserved
> as fallback.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Hi,
> 
> The patch adding ti,wl1285 support to wlcore has been send separately.
> Due to the fallback compatible value there is no dependency between
> the patches.

OK great, applying into omap-for-v4.13/dt thanks.

Tony
