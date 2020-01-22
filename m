From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv5 01/14] dt-bindings: remoteproc: Add OMAP remoteproc
 bindings
Date: Tue, 21 Jan 2020 20:34:54 -0600
Message-ID: <20200122023454.GA5809@bogus>
References: <20200116135332.7819-1-t-kristo@ti.com>
 <20200116135332.7819-2-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200116135332.7819-2-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s-anna-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Jan 2020 15:53:19 +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> 
> Add the device tree bindings document for the IPU and DSP
> remote processor devices on OMAP4+ SoCs.
> 
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> [t-kristo-l0cyMroinI0@public.gmane.org: converted to schema]
> Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> ---
> v5:
>   - enforced ordering of reg-names
>   - removed ti,bootreg-shift, instead added this under ti,bootreg
>     property
>   - renamed ti,autosuspend-delay to ti,autosuspend-delay-ms
>   - fixed required property handling
>   - fixed the omap5 ipu example firmware name extension
>   
>  .../remoteproc/ti,omap-remoteproc.yaml        | 322 ++++++++++++++++++
>  1 file changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
> 

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
