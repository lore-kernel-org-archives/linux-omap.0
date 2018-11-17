From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
Date: Sat, 17 Nov 2018 09:43:28 -0600
Message-ID: <20181117154328.GA4095@bogus>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 13 Nov 2018 11:31:08 +0530, Vignesh R wrote:
> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  MAINTAINERS                      |  1 +
>  include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k3.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
