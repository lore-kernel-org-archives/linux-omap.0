From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/8] musb: Get power (mA) from board data
Date: Wed, 18 Nov 2009 09:42:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702B863@dbde02.ent.ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
	<4B02C45C.4060407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4B02C45C.4060407-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org]
> Sent: Tuesday, November 17, 2009 9:12 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; davinci-linux-open-
> source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org;
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gadiyar, Anand
> Subject: Re: [PATCH 2/8] musb: Get power (mA) from board data
> 
> Hello.
> 
> Ajay Kumar Gupta wrote:
> 
> > Different board may have different power sourcing capability and
> > now with 'struct musb_hdrc_board_data' in place; pass this data
> > from board files and also modify musb_core.c to get 'power' data
> > from 'plat->board_data'.
> 
>     This should be part of the patch 1/8 to keep the code compiling.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index 3a61ddb..818ccda 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -2033,7 +2033,9 @@ bad_config:
> >  		if (is_otg_enabled(musb))
> >  			hcd->self.otg_port = 1;
> >  		musb->xceiv->host = &hcd->self;
> > -		hcd->power_budget = 2 * (plat->power ? : 250);
> > +		if (plat->board_data)
> > +			hcd->power_budget =
> > +				2 * (plat->board_data->power ? : 250);
> 
>     Shouldn't it be:
> 
> +
> +		hcd->power_budget = 2 * (plat->board_data &&
> +				         plat->board_data->power ?
> +					 plat->board_data->power : 250);

But the next patch on 'extvbus' would again need a check for
' plat->board_data ' so added both in same 'if' check.

-Ajay
> 
> WBR, Sergei
