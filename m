From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/3] ASoC: Add support for Conexant
	CX20442-11 voice modem codec
Date: Tue, 28 Jul 2009 18:07:29 +0200
Message-ID: <200907281807.31070.jkrzyszt@tis.icnet.pl>
References: <200907220522.29221.jkrzyszt@tis.icnet.pl>
	<200907281659.36000.jkrzyszt@tis.icnet.pl>
	<20090728150727.GA10870@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090728150727.GA10870@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

Tuesday 28 July 2009 17:07:27 Mark Brown wrote:
> On Tue, Jul 28, 2009 at 04:59:33PM +0200, Janusz Krzysztofik wrote:
> > Following that model, the line discipline code didn't seam to belong to a
> > codec driver for me. If it could be recognized as a new bus dirver, it
> > should be pushed down probably into a separate module. However, if it was
> > rather some kind of a bus adapter driver, it seamed to belong to the
> > machine code.
>
> The way it looks with the current code the line discipline itself is
> going to apply equally well to any serial port that's used - I'm not
> clear what's system-specific about it.  The bit that connects the line
> discipline to the line is a different matter but the bit that interacts
> with the TTY layer after registration is working through a pluggable
> abstraction layer and shouldn't, I'd expect, be specific to the
> particular serial port.

Mark,
I think I can't tell anything more before I try to implement it in a way you 
suggest, so I will.

What I would like to retain from the current codec driver are those two modes 
of operation: without and with the line discipline activated. Initially, the 
codec would be registered as a platform device, as it is now. Activation of 
the line discipline would deregister the codec device from the platform bus 
and reregister it again, now as the line discipline provided device. Is this 
possible with current ASoC framework?

Thanks,
Janusz
