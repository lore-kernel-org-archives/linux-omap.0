From: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 08/10] video: da8xx-fb: obtain fb_videomode info from dt
Date: Mon, 7 Jan 2013 09:21:15 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA7FC7A@DBDE01.ent.ti.com>
References: <cover.1357304090.git.afzal@ti.com>
 <78e026555731e0bbe8475610279d3e5265d124b9.1357304090.git.afzal@ti.com>
 <20130107091131.GC23478@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130107091131.GC23478-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Valkeinen,
 Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Steffen,

On Mon, Jan 07, 2013 at 14:41:31, Steffen Trumtrar wrote:
> On Mon, Jan 07, 2013 at 10:41:30AM +0530, Afzal Mohammed wrote:

> > Obtain fb_videomode details for the connected lcd panel using the
> > display timing details present in DT.

> > +- display-timings: list of different videomodes supported by the lcd
> > +  panel, represented as childs, can have multiple modes supported, if
> > +  only one, then it is considered native mode, if multiple modes are
> > +  provided, native mode can be set explicitly, more details available
> > +  @Documentation/devicetree/bindings/video/display-timing.txt

> Keep in mind that the text combined with...

> > +		if (of_get_fb_videomode(np, lcdc_info, 0)) {
> > +			dev_err(&dev->dev, "timings not available in DT\n");
> > +			return NULL;
> > +		}
> > +		return lcdc_info;
> > +	}
> 
> ... this is not correct. You are just supporting the first display-timings
> subnode (of_get_fb_videomode(..., 0)).


Yes right, I will modify the text to reflect what the driver does.

Regards
Afzal
