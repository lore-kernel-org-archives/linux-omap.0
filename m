From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3] wlcore: add wl1285 compatible
Date: Fri, 5 May 2017 06:21:20 -0700
Message-ID: <20170505132120.GC3489@atomide.com>
References: <20170505094434.28312-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170505094434.28312-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170505 02:47]:
> Motorola Droid 4 uses a WL1285C. With differences between the
> chips not being public let's add explicit binding for wl1285
> instead of relying on wl1283 being very similar.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Hi Dave,
> 
> I previously send this in two patches, but its hard to apply without
> requiring multiple kernel releases (the driver must be updated before
> the DTS change). Since the actual change is not very complex Marcel
> Holtmann & Tony Lindgren suggested, that I send this directly to you
> in a single patch for inclusion into 4.12. This also means, that the
> remaining series can be queued normally for 4.13.

Acke-by: Tony Lindgren <tony@atomide.com>
