From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] pinctrl: Add one-register-per-pin type device tree based
 pinctrl driver
Date: Sat, 14 Jul 2012 22:16:30 +0200
Message-ID: <CACRpkdYUJ3v-DoVbK6Pc6Y833Hn_0KS9PtEpjUCnMr57zfH5Bw@mail.gmail.com>
References: <20120615094938.GQ12766@atomide.com>
 <4FDB6000.5080703@wwwdotorg.org>
 <20120618055036.GU12766@atomide.com>
 <20120619135600.GX12766@atomide.com>
 <4FE39C86.5070901@wwwdotorg.org>
 <20120622083955.GZ12766@atomide.com>
 <4FE4AC40.8080400@wwwdotorg.org>
 <20120626134319.GA3483@atomide.com>
 <4FE9EBEC.9040208@wwwdotorg.org>
 <20120627102851.GC3483@atomide.com>
 <20120710091131.GQ1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120710091131.GQ1122-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 10, 2012 at 11:11 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> OK so no comments for a while. Here's the patch updated to leave out
> the comments in the binding example.

I reason like this:

- My fears is that the code gets hopeless to understand the mux, the
 only way to understand that aspect of the system will be to read the DTS
 and have the data sheet ready at hand.

But:

- Tony knows what he's doing and what is best for OMAP. And this gets
 (hopefully) all that OMAP mux code out of arch/arm.

- Surely it will be better to go through this subsystem if we're refactoring
  it all again later, and all drivers can be transferred to the abstract
  pinctrl API which is a big win in itself, bringing coherency to the
  drivers/* at large.

So applied it, so it can be evaluated in real operating environments.

But if I don't see OMAP transferred to use this I'll simply delete it
again. :-)

Yours,
Linus Walleij
