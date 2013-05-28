From: Jon Hunter <jgchunter@gmail.com>
Subject: Re: [PATCH v2 12/14] Documentation: dt: binding: omap: am43x counter
Date: Tue, 28 May 2013 22:26:05 +0100
Message-ID: <51A520ED.9070106@gmail.com>
References: <cover.1369658705.git.afzal@ti.com>
 <755964dc45ae4f023540c05e5739fca87d0ea70b.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <755964dc45ae4f023540c05e5739fca87d0ea70b.1369658705.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On 27/05/13 15:37, Afzal Mohammed wrote:
> AM43x 32K counter binding.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/counter.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/counter.txt b/Documentation/devicetree/bindings/arm/omap/counter.txt
> index 5bd8aa0..9c48dca 100644
> --- a/Documentation/devicetree/bindings/arm/omap/counter.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/counter.txt
> @@ -2,6 +2,7 @@ OMAP Counter-32K bindings
>  
>  Required properties:
>  - compatible:	Must be "ti,omap-counter32k" for OMAP controllers
> +		"ti,am4372-counter32k","ti,omap-counter32k" for AM43x counter
>  - reg:		Contains timer register address range (base address and length)
>  - ti,hwmods:	Name of the hwmod associated to the counter, which is typically
>  		"counter_32k"

Changelog should state why this is needed.

Jon
