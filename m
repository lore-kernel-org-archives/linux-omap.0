From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Tue, 22 Oct 2019 09:06:43 -0700
Message-ID: <20191022160643.GR5610@atomide.com>
References: <20190828150037.2640-1-aford173@gmail.com>
 <20190905230443.GA52127@atomide.com>
 <CAHCN7xL0fbr=Sv+b=0AuGB1PPhAAFdAFLEd_iBM+ZMTkUw5sHQ@mail.gmail.com>
 <CAHCN7xL-Gfxe0qF5w7BUsHnyhcNNpmCnchdKErnmiqggXfsLWw@mail.gmail.com>
 <20190909134033.s26eiurpat3iekse@pali>
 <20190909163543.GQ52127@atomide.com>
 <CAHCN7xJjMNOLT5oPn8CArApM5b2ksPon8eALq=gUi0ZqoLjGHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xJjMNOLT5oPn8CArApM5b2ksPon8eALq=gUi0ZqoLjGHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <adam.ford@logicpd.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191022 12:13]:
> On Mon, Sep 9, 2019 at 11:35 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Pali Rohár <pali.rohar@gmail.com> [190909 13:41]:
> > > On Monday 09 September 2019 08:37:09 Adam Ford wrote:
> > > > I applied this on 5.3 and it is working.  I assume the same is true in for-next.
> >
> > Hmm I noticed I stopped getting RNG data after several rmmod modprobe
> > cycles, or several hd /dev/random reads. Anybody else seeing that?
> >
> > > > Do you want to submit a formal patch?  I  can mark it as 'tested-by'
> > > > This really helps speed up the startup sequence on boards with sshd
> > > > because it delays for nearly 80 seconds waiting for entropy without
> > > > the hwrng.
> > >
> > > Hi! When applying a patch, could you please disable this rng for n900?
> > >
> > > In omap3-n900.dts for rng should be status = "disabled" (as Tony already
> > > wrote), similarly like for aes.
> >
> > Yeah I'll post a proper patch after -rc1.
> 
> Tony,
> 
> I am just following up on this.  Without the HWRNG there are some
> tools and daemons like sshd which wait a long time at startup.  The
> patch you sent really helps speed up the startup time in these cases.
> At least in my case, it shaves 80 seconds off by eliminating the
> delays.
> 
> Do you think you'll have time to post a more formal patch?  If not, I
> can do it.  I just don't know which mailing list is the more
> appropriate.  I was able to verity your patch on a DM3730 and OMAP3530

Yeah sorry for the delays, I'll post it when I get a chance to
work on that again. I need to first deal with the other pending
patches for v5.5, and we've had quite a few fixes for v5.4.

Regards,

Tony
