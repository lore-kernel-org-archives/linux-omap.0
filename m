From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: dts: dra7: Enable workaround for errata i870 in
 PCIe host mode
Date: Fri, 28 Sep 2018 10:27:48 -0700
Message-ID: <20180928172748.GJ5662@atomide.com>
References: <20180928060442.24312-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928060442.24312-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [180927 23:08]:
> Add ti,syscon-unaligned-access property to PCIe RC nodes to set
> appropriate bits in CTRL_CORE_SMA_SW_7 register to enable workaround for
> errata i870.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> This patch is split from v3 here:
> https://lore.kernel.org/patchwork/cover/967020/
> Dependent DT binding documentation and driver changes are now merged via
> PCI tree and part of next-20180928

OK thanks applying into omap-for-v4.20/dt.

Tony
