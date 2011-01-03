From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Mon, 3 Jan 2011 22:45:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com>
	<20110103163447.GB2911@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	<4D220246.5020303@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4D220246.5020303-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
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
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Balbi,  Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> >>>> Add support for Texas Instuments Communication Port Programming
> Interface 4.1
> >>>> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.
> 
> >>>> At this moment, only the DMA controller and queue manager are
> supported.
> >>>> Support for the buffer manager is lacking but these chips don't have
> it anyway.
> 
> >>>> Signed-off-by: Sergei Shtylyov<sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> >>>> Signed-off-by: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
> 
> >>>     Russell, you have recently discarded this patch from your patch
> >>> system. Can we know the reason?
> 
> >> It was recently discussed with TI, and various people raised concerns
> >> about it.  I don't remember the exact details, and I wish they'd raise
> >> them with the patch author directly.  It may have been that it's
> >> inventing its own API rather than using something like the DMA engine
> >> API.
> 
> >> Adding linux-omap to try to get a response there.
> 
> > Sergei,
> > This issue was discussed recently at TI and proposal was to place it to
> > drivers/dma folder.
> 
>     Note that I have neither time nor inclination to do this work (not do
> I think it's even feasible), so it will have to fall on TI's shoulders...

This is fine. No issues. We will discuss this at length at linux-usb list.

> 
> > Moreover, even Felipe also seems to move other musb
> > DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.
> 
>     Frankly speaking, I doubt that drivers/dma/ will have place for the
> purely MUSB specific DMA engines such as the named ones (there's no TUSB
> DMA BTW it uses OMAP DMA).
I think we will get more clarity once we start on this activity.

Thanks,
Ajay
> 
> > Regards,
> > Ajay
> 
> WBR, Sergei
