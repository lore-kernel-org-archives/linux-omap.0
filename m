From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: add dtsi for palmas
Date: Mon, 10 Jun 2013 10:29:18 -0600
Message-ID: <51B5FEDE.5070900@wwwdotorg.org>
References: <1370855059-5342-1-git-send-email-j-keerthy@ti.com>
 <1370855059-5342-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370855059-5342-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/10/2013 03:04 AM, J Keerthy wrote:
> Adds palmas mfd and palmas regulator nodes.

Nits:

Well, you're really adding files that provide the nodes, not the nodes
themselves.

Palmas and MFD should be correctly capitalized.

> diff --git a/arch/arm/boot/dts/palmas.dtsi b/arch/arm/boot/dts/palmas.dtsi

> +&palmas {
...
> +	palmas_pmic {
...
> +		ti,ldo6-vibrator;

Isn't that board-specific? I don't know the HW well enough to say, but I
assume that since there's a property, the whole point must be that some
boards want it set and some don't.

> +		regulators {
> +			smps123_reg: smps123 {
> +				regulator-name = "smps123";
> +			};

So the node labels here duplicate those in omap5-uevm.dts in patch 2/2.
While dtc allows this, I don't think there's much point duplicating the
labels. I'd tend to only put the labels in omap5-uevm.dts and not put
them here. That will completely avoid the possibility of the labels in
this file from conflicting with any other labels in any top-level
board.dts file.

I also wonder if this file is actually terribly useful. The only thing
that this file provides is the regulator-name property. It seems simpler
just to put that into each board.dts file. The added advantage of doing
that, is that if a board doesn't use a particular regulator, the node
won't appear, and the regulator won't get registered.
