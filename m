From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] ARM/DT: edma: Get IP configuration from hardware
Date: Tue, 13 May 2014 14:03:28 +0530
Message-ID: <5371D8D8.8000003@ti.com>
References: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 May 2014 01:13 PM, Peter Ujfalusi wrote:
> Hi,
> 
> We are requesting redundant information via DT for the driver since the very same
> data is available in the HW: by reading and decoding the content of CCCFG
> register we can get:
> Number of channels: NUM_DMACH
> Number of regions: NUM_REGN
> Number of slots (PaRAM sets): NUM_PAENTRY
> Number of TC/EQ: NUM_EVQUE
> 
> So these does not need to be provided by the DT binding.
> 
> The driver will no longer look for these properties from DT and they can be
> removed from the binding documentation and from the dtsi files as well.
> The change will not introduce regression when new kernel is booted using older
> DTB (since we just ignore the mentioned properties).

Peter, to which baseline do these patches apply? I tried applying them
to v3.15-rc5 but 1/4 doesn't apply cleanly.

Thanks,
Sekhar
