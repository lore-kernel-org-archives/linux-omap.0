From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 4/9] pwm: pwm-tiecap: Update dt binding document to
 use proper unit address
Date: Wed, 4 May 2016 08:47:03 -0500
Message-ID: <20160504134703.GA4194@rob-hp-laptop>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-5-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462291015-1919-5-git-send-email-fcooper@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, May 03, 2016 at 10:56:50AM -0500, Franklin S Cooper Jr wrote:
> Replace unit address from 0 to the proper physical address. Also insure
> that the unit address matches the reg property address.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> index 788da6c..0d47354 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
> @@ -16,22 +16,22 @@ Optional properties:
>  
>  Example:
>  
> -ecap0: ecap@0 { /* ECAP on am33xx */
> +ecap0: ecap@48300100 { /* ECAP on am33xx */
>  	compatible = "ti,am33xx-ecap";
>  	#pwm-cells = <3>;
>  	reg = <0x48300100 0x80>;
>  	ti,hwmods = "ecap0";
>  };
>  
> -ecap0: ecap@0 { /* ECAP on am4372 */
> +ecap0: ecap@48300100 { /* ECAP on am4372 */
>  	compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
>  	#pwm-cells = <3>;
>  	reg = <0x48300100 0x80>;
>  	ti,hwmods = "ecap0";
>  };
>  
> -ecap0: ecap@0 { /* ECAP on da850 */
> +ecap0: ecap@1f06000 { /* ECAP on da850 */
>  	compatible = "ti,da850-ecap", "ti,am33xx-ecap";
>  	#pwm-cells = <3>;
> -	reg = <0x306000 0x80>;
> +	reg = <0x1f06000 0x80>;
>  };
> -- 
> 2.7.0
> 
