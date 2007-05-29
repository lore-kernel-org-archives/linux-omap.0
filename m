From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Add more Test Modes
Date: Tue, 29 May 2007 10:16:54 -0700
Message-ID: <200705291016.54340.david-b@pacbell.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 May 2007, Felipe Balbi wrote:

> --- a/drivers/usb/musb/virthub.c
> +++ b/drivers/usb/musb/virthub.c
> @@ -362,7 +362,11 @@ int musb_hub_control(
>  				temp = MGC_M_TEST_FORCE_HOST
>  					| MGC_M_TEST_FORCE_HS;
>  
> -				/* FIXME and enable a session too */
> +				musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
> +				break;
> +			case 6:
> +				pr_debug("TEST_FIFO_ACCESS\n");
> +				temp = MGC_M_TEST_FIFO_ACCESS;

I don't see this defined in the USB 2.0 specification.
Table 11-24 shows values 1-5 only ... where is "6" defined?

FIFO access doesn't make sense as a portable test in any
case.  If it's needed for some musb-specific thing, this
should go into the vendor-specific range (0xc0 and up).

- Dave


>  				break;
>  			default:
>  				goto error;
> -- 
> 1.5.2.rc3.39.gaf9b
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
