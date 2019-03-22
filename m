From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-evm: Correct the regulators for the
 audio codec
Date: Fri, 22 Mar 2019 15:20:14 -0700
Message-ID: <20190322222014.GH19425@atomide.com>
References: <20190315105909.8648-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190315105909.8648-1-peter.ujfalusi@ti.com>
Sender: stable-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, Stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [190315 03:58]:
> Correctly map the regulators used by tlv320aic3106.
> Both 1.8V and 3.3V for the codec is derived from VBAT via fixed regulators.
> 
> Cc: <Stable@vger.kernel.org> # v4.14+
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v1:
> - Add stable tag for backporting to v4.14+

Thanks adding both similar patches into omap-for-v5.1/fixes.

Regards,

Tony
