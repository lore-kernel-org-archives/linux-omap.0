From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] ARM: dts: omap4 clock data
Date: Tue, 04 Jun 2013 11:34:49 -0700
Message-ID: <20130604183449.10233.48956@quantum>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-3-git-send-email-mturquette@linaro.org>
 <20130604145543.GK3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130604145543.GK3331-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2013-06-04 07:55:43)
> * Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [130603 23:45]:
> > This is a first pass at creating a unique node for each clock in the
> > OMAP4 power, reset and & clock manager (PRCM).  So far I have only
> > converted mux clocks & fixed-rate clocks, which coexist with the current
> > clock data in the kernel.  The rest needs to be done but better to
> > publish early and often to see what others think of this approach.
> 
> > +/* FIXME need to print the address directly */
> > +/*
> > +#include "../../mach-omap2/prm44xx.h"
> > +#include "../../mach-omap2/cm2_44xx.h"
> > +#include "../../mach-omap2/cm1_44xx.h"
> > +*/
> 
> I don't think you're using the above includes any longer
> in this file?
> 

Correct.  I actually spotted this before emailing the patches out at
midnight, but by then I didn't care to fix it.  The benefits of marking
a patch as "RFC" ;-)

I had a mind to use the new preprocessor capabilities of dtc for the
PRCM bit masks and shift values, but instead I ended up using the raw
hex values.  I've actually come to prefer using the raw hex values for
DT, which I think makes more sense for a description of the hardware
which is not tied to any Linux implementation.

Regards,
Mike

> Regards,
> 
> Tony
