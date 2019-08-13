From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra74x: Fix iodelay configuration for mmc3
Date: Tue, 13 Aug 2019 03:21:38 -0700
Message-ID: <20190813102138.GI52127@atomide.com>
References: <20190807105238.21131-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190807105238.21131-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, bcousson@baylibre.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190807 03:53]:
> According to the latest am572x[1] and dra74x[2] data manuals, mmc3
> default, hs, sdr12 and sdr25 modes use iodelay values given in
> MMC3_MANUAL1. Set the MODE_SELECT bit for these so that manual mode is
> selected and correct iodelay values can be configured.

Thanks applying into fixes.

Tony
