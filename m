From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 05/10] documentation/dt: Add mpu, dsp and iva bindings
Date: Thu, 8 Sep 2011 11:09:11 -0700
Message-ID: <20110908180910.GE2967@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-6-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314191356-10963-6-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, manjugk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 24, 2011 at 03:09:11PM +0200, Benoit Cousson wrote:
> Add documentation for the OMAP4 processors bindings.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 ++++++++
>  Documentation/devicetree/bindings/arm/omap/iva.txt |   18 ++++++++++
>  Documentation/devicetree/bindings/arm/omap/mpu.txt |   35 ++++++++++++++++++++
>  3 files changed, 67 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/dsp.txt b/Documentation/devicetree/bindings/arm/omap/dsp.txt
> new file mode 100644
> index 0000000..8fcd82c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/dsp.txt
> @@ -0,0 +1,14 @@
> +* TI - DSP (Digital Signal Processor)
> +
> +TI DSP included in OMAP SoC
> +
> +Required properties:
> +- compatible : Should be "ti,c64" for OMAP3 & 4
> +- hwmods: "dsp"
> +
> +Examples:
> +
> +dsp {
> +    compatible = "ti,omap4-c64", "ti,c64";
> +    hwmods = "dsp";
> +};
> diff --git a/Documentation/devicetree/bindings/arm/omap/iva.txt b/Documentation/devicetree/bindings/arm/omap/iva.txt
> new file mode 100644
> index 0000000..f428e88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/iva.txt
> @@ -0,0 +1,18 @@
> +* TI - IVA (Imaging and Video Accelerator) subsystem
> +
> +The IVA contain various audio, video or imaging HW accelerator
> +depending of the version.
> +
> +Required properties:
> +- compatible : Should be:
> +  - "ti,ivahd", "ti,iva" for OMAP4
> +  - "ti,iva2", "ti,iva" for OMAP3
> +  - "ti,iva1", "ti,iva" for OMAP2

Again, be specific to the instantiation and encode the omap version
into the compatible value.  Use the form "ti,omap4-*", etc.

g.
