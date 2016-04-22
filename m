From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: dra7x: Support QSPI MODE-0 operation at
 64MHz
Date: Fri, 22 Apr 2016 14:33:53 -0500
Message-ID: <20160422193353.GA15316@rob-hp-laptop>
References: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
 <1461151980-28139-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461151980-28139-3-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 20, 2016 at 05:03:00PM +0530, Vignesh R wrote:
> According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
> DRA74(rev 1.1+)/DRA72 EVM can support up to 64MHz in MODE-0, whereas
> MODE-3 is limited to 48MHz. Hence, switch to MODE-0 for better
> throughput.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
> 
> v2: rebased on linux-next 20160419 to include moving to
> dra72-evm-common.dtsi
> 
> 
>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 7 +++++++
>  arch/arm/boot/dts/dra7-evm.dts                    | 6 ++----
>  arch/arm/boot/dts/dra72-evm-common.dtsi           | 6 ++----
>  3 files changed, 11 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
