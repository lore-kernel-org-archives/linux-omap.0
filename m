From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: bus: ti-gpmc: Add AAD timings properties
Date: Tue, 29 Dec 2015 12:35:52 -0600
Message-ID: <20151229183552.GN12450@rob-hp-laptop>
References: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
 <1451309961-7247-3-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451309961-7247-3-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 28, 2015 at 02:39:21PM +0100, Neil Armstrong wrote:
> In order to support advanced AAD timings, add these properties to the DT
> GPMC bindings.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-gpmc.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
