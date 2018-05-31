From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
Date: Wed, 30 May 2018 23:08:32 -0500
Message-ID: <20180531040832.GA30763@rob-hp-laptop>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180530141133.3711-5-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, May 30, 2018 at 07:41:31PM +0530, Faiz Abbas wrote:
> The dra76x MCAN generic interconnect module has a its own
> format for the bits in the control registers.
> 
> Therefore add a new module type, new regbits and new capabilities
> specific to the MCAN module.
> 
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../devicetree/bindings/bus/ti-sysc.txt         |  1 +
>  drivers/bus/ti-sysc.c                           | 17 +++++++++++++++++
>  include/dt-bindings/bus/ti-sysc.h               |  2 ++
>  include/linux/platform_data/ti-sysc.h           |  1 +
>  4 files changed, 21 insertions(+)

For the DT bits:

Acked-by: Rob Herring <robh@kernel.org>
