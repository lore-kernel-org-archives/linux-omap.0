From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 0/3] MFD/GPIO: Add twl6040 GPO driver
Date: Wed, 19 Sep 2012 12:22:00 +0200
Message-ID: <20120919102200.GI3647@sortiz-mobl>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
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
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Thu, Aug 16, 2012 at 03:13:12PM +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v1:
> - Removed the ti,use-gpo property from DT bindings
> - Register the GPO driver if we booted with DT blob or in legacy if the pdata
>   for the GPO driver is present
> - DT binding Documentation update
> 
> The Documentation update has reference to the twl6040.dtsi file which will be
> created to hold the common/static properties for the twl6040.
> To avoid cross tree merge issues later I have only included the Documentation
> update to this series and I will send the actual .dtsi/.dts changes via
> linux-omap. If this is not a problem.
> 
> The dependencies for this series are in mainline and I think this series can
> go via GPIO if Samuel agrees with the changes.
> 
> Intro mail from v1:
> 
> The following series adds support for the GPO (General Purpose Output) on the
> twl6040/41 audio chip.
> The series has been tested on SDP4430, compile tested for x86_64 and x86_32 bit
> to be sure it does not introduce build breakage.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   mfd: twl6040: Fix GPO mask
>   mfd: twl6040: Add twl6040-gpio child
>   gpio: Add basic support for TWL6040 GPOs
All 3 patches applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
