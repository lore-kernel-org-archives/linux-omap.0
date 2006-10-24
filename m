From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.18-omap-git] omap2 fullspeed usb 1/2
Date: Tue, 24 Oct 2006 11:41:16 -0700
Message-ID: <200610241141.17312.david-b@pacbell.net>
References: <001c01c6f65d$f2d11d20$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001c01c6f65d$f2d11d20$c7a3580a@swcenter.sec.samsung.co.kr>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sunday 22 October 2006 9:44 pm, Kyungmin Park wrote:

> > -------
> > NOTE:  this is just a cleaned up version of the code from 
> > Kyungmin, I don't have it behaving yet on H4, and didn't 
> > re-test on e.g. OSK.
> 
> There's missing patch. We have to modify following line.

Good catch.   It got tangled up in the H4 support patch, which I
didn't send, since that also needs "select ISP1301_OMAP" when the
OTG port is defined.

Tony, feel free to merge this patch too.  :)


> --
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 08c962a..4734e78 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -167,7 +167,7 @@ config USB_GADGET_MUSB_HDRC
>  
>  config USB_GADGET_OMAP
>  	boolean "OMAP USB Device Controller"
> -	depends on ARCH_OMAP1
> +	depends on ARCH_OMAP
>  	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
>  	help
>  	   Many Texas Instruments OMAP processors have flexible full
> 
