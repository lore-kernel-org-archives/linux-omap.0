From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654
 SoCs
Date: Tue, 4 Dec 2018 17:16:07 -0600
Message-ID: <20181204231607.GA16737@bogus>
References: <20181119094509.22542-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119094509.22542-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 19 Nov 2018 15:15:09 +0530, Vignesh R wrote:
> AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
> handle AM654 SoCs. Also, it seems that existing compatible strings used
> in the kernel DTs were never documented. So, document them now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
