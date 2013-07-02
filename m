From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
Date: Tue, 2 Jul 2013 05:20:53 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC4E6FE@DBDE04.ent.ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
 <871u7hom0q.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <871u7hom0q.fsf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
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
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Bedia,
 Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 02, 2013 at 05:45:01, Kevin Hilman wrote:
> Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org> writes:
> 
> > On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> > is available to enable Alarm Wakeup feature. This register needs to be
> > properly handled for the rtcwake to work properly.
> >
> > Platforms using such IP should set "ti,am3352-rtc" in rtc device dt
> > compatibility node.
> >
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> > Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
> > Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> > Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
> > Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
> > Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> > Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 
> Acked-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> ...with a minor nit below...
> 
> > ---
> > :100644 100644 b47aa41... 5a0f02d... M	Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > :100644 100644 761919d... 666b0c2... M	drivers/rtc/rtc-omap.c
> >  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    6 ++-
> >  drivers/rtc/rtc-omap.c                             |   56 +++++++++++++++++---
> >  2 files changed, 54 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > index b47aa41..5a0f02d 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > @@ -1,7 +1,11 @@
> >  TI Real Time Clock
> >  
> >  Required properties:
> > -- compatible: "ti,da830-rtc"
> > +- compatible:
> > +	- "ti,da830-rtc"  - for RTC IP used similar to that on DA8xx SoC family.
> > +	- "ti,am3352-rtc" - for RTC IP used similar to that on AM335x SoC family.
> > +			    This RTC IP has special WAKE-EN Register to enable
> > +			    Wakeup generation for event Alarm.
> >  - reg: Address range of rtc register set
> >  - interrupts: rtc timer, alarm interrupts in order
> >  - interrupt-parent: phandle for the interrupt controller
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index 761919d..666b0c2 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -72,6 +72,8 @@
> >  #define OMAP_RTC_KICK0_REG		0x6c
> >  #define OMAP_RTC_KICK1_REG		0x70
> >  
> > +#define OMAP_RTC_IRQWAKEEN		0x7C
> > +
> 
> nit: letters in hex numbers are usually lower-case.

Thanks for the review. V2 will soon follow.

> 
> 
> Kevin
> 


Regards, 
Gururaja
