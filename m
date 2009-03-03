From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add GPIO support for
	jack	reporting interface
Date: Mon, 2 Mar 2009 18:03:12 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6D789@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
	<20090226115243.GC4229@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
	<20090227130502.GA4415@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com>
	<20090302113845.GA19744@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC77862@dlee07.ent.ti.com>
	<20090302225527.GA6390@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090302225527.GA6390@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> > > That sounds like adding a callback for power updates on the jack
> > > itself to me (which isn't a bad idea), rather than changing the 
> > > report function of the jack detection method.  The need for
> > > machine-specific extra actions probably isn't specific to jacks
> > > that are detected via GPIOs.

> > In that situation, power updates should come only when the jack
> > reporting bits are either all active (jack enabled) or none (jack 
> > disabled), is that correct?

> No, the jack detect bits can change independently - you won't always
> physically be able to get everything that can be detected to report at
> once (eg, something that can distinguish between headphones and line
> output) or things may not always be present together (eg, a jack could
> detect headphones but no microphone even if it's possible  that both
> may be present simultaneously).

Then, when to trigger the callback? Every time jack status is going to
be updated?
