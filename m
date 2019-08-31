From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH 2/2] DTS: ARM: gta04: introduce legacy
 spi-cs-high to make display work again
Date: Sat, 31 Aug 2019 08:48:52 +0200
Message-ID: <20190831084852.5e726cfa@aktux>
References: <cover.1562597164.git.hns@goldelico.com>
        <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
        <20190724194259.GA25847@bogus>
        <2EA06398-E45B-481B-9A26-4DD2E043BF9C@goldelico.com>
        <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com>
        <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, 5 Aug 2019 12:29:19 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Jul 26, 2019 at 12:43 AM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Jul 25, 2019 at 12:23 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:  
> 
> > > I tried to convince Linus that this is the right way but he convinced
> > > me that a fix that handles all cases does not exist.
> > >
> > > There seem to be embedded devices with older DTB (potentially in ROM)
> > > which provide a plain 0 value for a gpios definition. And either with
> > > or without spi-cs-high.
> > >
> > > Since "0" is the same as "GPIO_ACTIVE_HIGH", the absence of
> > > spi-cs-high was and must be interpreted as active low for these
> > > devices. This leads to the inversion logic in code.
> > >
> > > AFAIR it boils down to the question if gpiolib and the bindings
> > > should still support such legacy devices with out-of tree DTB,
> > > but force in-tree DTS to add the legacy spi-cs-high property.
> > >
> > > Or if we should fix the 2 or 3 cases of in-tree legacy cases
> > > and potentially break out-of tree DTBs.  
> >
> > If it is small number of platforms, then the kernel could handle those
> > cases explicitly as needed.
> >  
> > > IMHO it is more general to keep the out-of-tree DTBs working
> > > and "fix" what we can control (in-tree DTS).  
> >
> > If we do this, then we need to not call spi-cs-high legacy because
> > we're stuck with it forever.  
> 
> I agree. The background on it is here:
> https://lkml.org/lkml/2019/4/2/4
> 
> Not using the negatively defined (i.e. if it is no there, the line is
> by default active low) spi-cs-high would break
> PowerPC, who were AFAICT using this to ship devices.
> 
is this thing now just waiting for someone to do a s/legacy//?

Regards,
Andreas
