From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 03/10] documentation/dt: Add l3-noc bindings
Date: Thu, 8 Sep 2011 11:06:04 -0700
Message-ID: <20110908180604.GC2967@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1314191356-10963-4-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, tony@atomide.com, manjugk@ti.com, devicetree-discuss@lists.ozlabs.org, Randy Dunlap <rdunlap@xenotime.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 24, 2011 at 03:09:09PM +0200, Benoit Cousson wrote:
> Add documentation for the l3-noc bindings.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  .../devicetree/bindings/arm/omap/l3-noc.txt        |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> new file mode 100644
> index 0000000..dbfa878
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> @@ -0,0 +1,18 @@
> +* TI - L3 Network On Chip (NoC)
> +
> +This version is an implementation of the generic NoC IP
> +provided by Arteris.

Hahaha.  Here's the documentation.  Okay.

> +
> +Required properties:
> +- compatible : Should be "ti,l3-noc", "arteris,noc"

Should probably be "ti,omap4-l3-noc", and it isn't necessary to have a
value for the IP core vendor... or at least if an arteris value is
provided, then it should have some form of ip-core version
information.

> +- hwmods: "l3_main_1", ... One hwmod for each noc domain.

Is there some documentation on how the "hwmods" property is to be
used?  I expect that this should be "ti,hwmods" because this is a TI
specific property.

> +
> +Examples:
> +
> +ocp {
> +	compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;
> +	hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> +};
> -- 
> 1.7.0.4
> 
