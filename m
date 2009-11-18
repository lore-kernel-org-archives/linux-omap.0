From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/8] musb: Update musb_init() call for all OMAP3 boards
Date: Wed, 18 Nov 2009 09:34:46 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702B856@dbde02.ent.ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
	<4B02CFC1.3090601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4B02CFC1.3090601-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sergei Shtylyov
> Sent: Tuesday, November 17, 2009 10:01 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; davinci-linux-open-
> source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org;
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gadiyar, Anand
> Subject: Re: [PATCH 3/8] musb: Update musb_init() call for all OMAP3
> boards
> 
> Ajay Kumar Gupta wrote:
> 
> > musb_init() has been modified to pass board specific data so updating
> > this function call from all OMAP3 boards.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c
> > index 1145a25..0e9380c 100644
> > --- a/arch/arm/mach-omap2/usb-musb.c
> > +++ b/arch/arm/mach-omap2/usb-musb.c
> > @@ -124,12 +124,6 @@ static struct musb_hdrc_platform_data musb_plat = {
> >  	/* .clock is set dynamically */
> >  	.set_clock	= musb_set_clock,
> >  	.config		= &musb_config,
> > -
> > -	/* REVISIT charge pump on TWL4030 can supply up to
> > -	 * 100 mA ... but this value is board-specific, like
> > -	 * "mode", and should be passed to usb_musb_init().
> > -	 */
> > -	.power		= 50,			/* up to 100 mA */
> 
>     That should obviously be a part of patch 1/8...

It was actually a part of 1/8 earlier but as this is OMAP specific and
[1/8] is generic so moved it to OMAP specific patch here.

-Ajay
> 
> WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
