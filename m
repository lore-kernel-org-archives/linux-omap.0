From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 7/7] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Mon, 25 Apr 2016 08:05:57 -0500
Message-ID: <20160425130557.GA11485@rob-hp-laptop>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
 <1461343238-29274-8-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461343238-29274-8-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 22, 2016 at 11:40:38AM -0500, Franklin S Cooper Jr wrote:
> From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> [fcooper-l0cyMroinI0@public.gmane.org: Add eCAP and use updated bindings for PWMSS and ePWM]
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
>  arch/arm/boot/dts/dra7.dtsi                        | 90 ++++++++++++++++++++++
>  4 files changed, 122 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
