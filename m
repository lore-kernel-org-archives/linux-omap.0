From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 20:07:52 +0000
Message-ID: <20081126200750.GK6234@sirena.org.uk>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<20081126110854.GA6234@sirena.org.uk>
	<20081126134028.b3c6aa46.jarkko.nikula@nokia.com>
	<200811261034.42356.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200811261034.42356.david-b@pacbell.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 26, 2008 at 10:34:41AM -0800, David Brownell wrote:

> Re TWL4030 codec configuration ... I count three microphone
> input channels not used on Beagle, plus a speaker output
> and some other stuff.  So it's obvious that something which
> works on Beagle won't handle more interesting configurations
> of that audio support.  

Can someone post an overview of what the hardware configurations of
these boards are, please?  It's starting to sound like they're not very
similar at all.

> I'm told that the ASoC stuff "should" go in a separate ASoC
> area for some reason.  That still makes no good sense to me,
> so if there's a brief explanation as to why it's done that
> way, please fling me a URL.  :)

The move is in the direction you want but we're not there yet.  The fact
that things are now decomposed enough for us to be able to think about
it is a good sign here.

The biggest part of it is that the degree of coupling between the
various ASoC components is high - this is particularly obvious with v1
where the entire card is probed at once.  This includes coupling between
the drivers and the core where the degree of churn is very high right
now due to v2 merging.  It doesn't feel right to give architectures an
API that they can't rely on from one merge window to the next yet,
partly from the point of view of isolating the code for review purposes
and also due to the merge issues which would doubtless crop up.

Another part of it is that some machine drivers can get involved enough
to sit on or cross the boundary from platform data to being drivers for
substantial distinct hardware but that's very much not the case for
everything.

I've been spending time this week working on getting the ability to load
platform and codec drivers independantly merged.  That will at least
allow the instantiation of the ASoC drivers for those to be pushed out
into the architecture code, which is a start and should substantially
reduce the size of most machine drivers.  At the point where that's been
done it's probably worth looking again at the simpler machine drivers.
