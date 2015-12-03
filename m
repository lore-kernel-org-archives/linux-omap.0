From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V3 01/19] ARM: dts: am57xx: cl-som-am57x: add basic
 module support
Date: Thu, 3 Dec 2015 08:20:37 -0800
Message-ID: <20151203162037.GO23396@atomide.com>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-2-git-send-email-lifshitz@compulab.co.il>
 <20151202152326.GA16775@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151202152326.GA16775@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [151202 07:24]:
> On Tue, Dec 01, 2015 at 08:03:03PM +0200, Dmitry Lifshitz wrote:
> > Add support for CompuLab CM-SOM-AM57X board.
> > 
> > CL-SOM-AM57x is a miniature System-on-Module (SoM) based on
> > TI Sitara AM57x ARM Cortex-A15 System-on-Chip family.
> > 
> > https://www.compulab.co.il/products/computer-on-modules/cl-som-am57x-ti-am5728-am5718-system-on-module/
> > 
> > Add basic DT support for standalone module (without a carrier board):
> > 
> > * Memory configuration
> > * Heartbeat led
> > * I2C1 and I2C4
> > * PMIC
> > * SATA
> > 
> > Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> > Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applying the whole series into omap-for-v4.5/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
