From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Thu, 4 Feb 2010 10:08:08 -0800
Message-ID: <20100204180807.GB10965@core.coreip.homeip.net>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com>
 <20100204142439.GA1139@sirena.org.uk>
 <6ed0b2681002040652r722e3df2s3f032a9fe0d0c0fe@mail.gmail.com>
 <20100204162155.GB29982@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100204162155.GB29982@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 04, 2010 at 04:21:55PM +0000, Mark Brown wrote:
> On Thu, Feb 04, 2010 at 04:52:26PM +0200, Grazvydas Ignotas wrote:
> > On Thu, Feb 4, 2010 at 4:24 PM, Mark Brown
> 
> > > The updates to fix up the boards that need this are fairly
> > > straightforward and given that it's fairly easy to identify systems
> > > which are using the driver in mainline so I'd really prefer not to go
> > > down the route of trying to carry on in the face of error, it papers
> > > over stuff now but is not robust in the face of future changes.
> 
> > What about warning and continuing only on ENODEV then? I really don't
> > want to be responsible for potentially breaking touchscreen on ~30
> > boards, where I have no idea about how things are wired up and how the
> > regulators should be set up.
> 
> I'm really not terribly enthusiastic about that approach - like I say,
> it just moves the problem about a bit and postpones the breakage in a
> potentially more obscure fashion.
> 

Maybe we should rely on platform data to tell us whether we need to plug
into regulator framework and in this case fail hard on any error?

-- 
Dmitry
