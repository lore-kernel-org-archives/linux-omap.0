From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: bindings: TI WiLink modules
Date: Thu, 27 Jun 2013 16:30:10 +0300
Message-ID: <1372339810.8383.20.camel@cumari.coelho.fi>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
 <51CBC1C8.1040301@gmail.com> <1372322851.18889.53.camel@cumari.coelho.fi>
 <20130627125131.GA27285@kahuna>
 <1372337887.8383.12.camel@cumari.coelho.fi>
 <CAGo_u6qbt9dANgKq49xR=1qsCpUBhmVaPL4EK04XvTw+=4Z23g@mail.gmail.com>
 <1372339148.8383.17.camel@cumari.coelho.fi> <51CC3CEE.3050004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51CC3CEE.3050004-l0cyMroinI0@public.gmane.org>
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
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-06-27 at 08:23 -0500, Nishanth Menon wrote:
> On 06/27/2013 08:19 AM, Luciano Coelho wrote:
> > On Thu, 2013-06-27 at 08:15 -0500, Nishanth Menon wrote:
> >> On Thu, Jun 27, 2013 at 7:58 AM, Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org> wrote:
> >>> For the actual DTS files, I could add a wilink.dtsi with enumerations
> >>> for these values so they could be used in the node definitions.  But I'm
> >>> not sure it's going to be that valuable in the end.
> >> The  way GPIO HIGH was defined might help to provide guidance I think :)
> >
> > Where? As far as I can see, the GPIO flags are defined in a bitmap.
> 
> include/dt-bindings/gpio/gpio.h

Thanks! I don't see these macros used anywhere, though.

> And corresponding kernel header:
> include/linux/of_gpio.h

This seems to be a completely different thing.  This is the header that
contains the helper functions to get GPIO-related device tree nodes,
isn't it?


> just a hint. not saying frequencies were defined in header. for systems 
> that define frequencies - example cpufreq OPPs, clock node usage, we do 
> not use indexing to frequency, instead, that is the responsibility of 
> driver to convert frequency back to required index.
> git grep frequency Documentation/devicetree/bindings gives you how the 
> precedence looks like.
> 
> Personally, if given a choice, I'd go with actual frequencies rather 
> than indexes.

If I do that, I need to add also a separate flag to define whether the
XTAL clock is used or not.  For instance, we have 26MHz and 26MHz
crystal; and 38.4MHz and 38.4MHz crystal...

--
Luca.
