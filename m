From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: counter: new bindings for TI eQEP
Date: Mon, 2 Sep 2019 16:02:38 +0100
Message-ID: <20190902150238.GA30757@bogus>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190901225827.12301-3-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190901225827.12301-3-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, David Lechner <david@lechnology.com>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun,  1 Sep 2019 17:58:23 -0500, David Lechner wrote:
> This documents device tree binding for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes:
> - fixed style issues
> - fixed generic node name
> - (was suggested to drop descriptions since there is only one interrupt and one
>   clock, but I opted to keep them anyway)
> v2 changes:
> - convert to .yaml format
> - rename clock to "sysclkout"
> 
>  .../devicetree/bindings/counter/ti-eqep.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
