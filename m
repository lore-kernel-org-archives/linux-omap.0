From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/8] musb: Update setup_usb() call for all Davinci boards
Date: Wed, 18 Nov 2009 09:39:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702B85A@dbde02.ent.ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
	<4B02C6FF.6050806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4B02C6FF.6050806-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
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
> From: Sergei Shtylyov [mailto:sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org]
> Sent: Tuesday, November 17, 2009 9:24 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; davinci-linux-open-
> source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org;
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gadiyar, Anand
> Subject: Re: [PATCH 4/8] musb: Update setup_usb() call for all Davinci
> boards
> 
> Ajay Kumar Gupta wrote:
> 
> > setup_usb() has been modified to pass board specific data so updating
> > this function call from all Davinci based boards.
> 
> > Added "struct device;" to fix below compilation warning for Davinci
> boards.
> > "musb.h: struct device, defined within parameter list"
> 
>     You should fix the missing #include in the musb.h, not band-aid it
> here...

Ok fine, As the error was only with Davinci and not with OMAP/Blackfin
So added here.

> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> > diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-
> davinci/board-dm355-evm.c
> > index 77e8067..31c5741 100644
> > --- a/arch/arm/mach-davinci/board-dm355-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> > @@ -24,6 +24,7 @@
> >  #include <media/tvp514x.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/spi/eeprom.h>
> > +#include <linux/usb/musb.h>
> >
> >  #include <asm/setup.h>
> >  #include <asm/mach-types.h>
> > @@ -317,6 +318,12 @@ static struct spi_board_info dm355_evm_spi_info[]
> __initconst = {
> >  	},
> >  };
> >
> > +/* musb board specific data */
> > +static struct musb_hdrc_board_data musb_bdata __initdata = {
> > +	.power = 250,	/* (power in mA)/2 */
> > +	.potpgt = 4,	/* (potpgt in msec)/2 */
> > +};
> > +
> >  static __init void dm355_evm_init(void)
> >  {
> >  	struct clk *aemif;
> > @@ -344,7 +351,7 @@ static __init void dm355_evm_init(void)
> >  	gpio_request(2, "usb_id_toggle");
> >  	gpio_direction_output(2, USB_ID_VALUE);
> >  	/* irlml6401 switches over 1A in under 8 msec */
> > -	setup_usb(500, 8);
> > +	setup_usb(&musb_bdata);
> 
>     Unfortunately, this will conflict with a patch queued for 2.6.33 in
> linux-davinci. Though in fact, it will render the part of this patch
> useless... :-/
> 
> > diff --git a/arch/arm/mach-davinci/include/mach/common.h
> b/arch/arm/mach-davinci/include/mach/common.h
> > index 1fd3917..dab784c 100644
> > --- a/arch/arm/mach-davinci/include/mach/common.h
> > +++ b/arch/arm/mach-davinci/include/mach/common.h
> > @@ -20,11 +20,14 @@ extern void davinci_irq_init(void);
> >  extern void __iomem *davinci_intc_base;
> >  extern int davinci_intc_type;
> >
> > +struct device;
> 
>     NAK. <linux/usb/musb.h> should be fixed instead.
> 
> > +#include <linux/usb/musb.h>
> > +
> >  /* parameters describe VBUS sourcing for host mode */
> > -extern void setup_usb(unsigned mA, unsigned potpgt_msec);
> > +extern void setup_usb(struct musb_hdrc_board_data *board_data);
> >
> >  /* parameters describe VBUS sourcing for host mode */
> > -extern void setup_usb(unsigned mA, unsigned potpgt_msec);
> > +extern void setup_usb(struct musb_hdrc_board_data *board_data);
> 
>     Don't you see -- these are duplicate? You could kill the second one.
> :-)

I saw, but though it could be some Davinci hack. I will remove it
in next version.

-Ajay
> 
>     BTW, the mentioned linux-davinci patch moved the declaration to
> <mach/usb.h> (and renamed the function too).
> 
> WBR, Sergei
