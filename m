From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Thu, 27 Nov 2008 20:39:32 +0800
Message-ID: <1227789572.14497.117.camel@localhost>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<200811261034.42356.david-b@pacbell.net>
	<20081126200750.GK6234@sirena.org.uk>
	<200811261233.13259.david-b@pacbell.net>
	<20081126211614.GA6514@sirena.org.uk>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20081126211614.GA6514@sirena.org.uk>
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
Cc: David Brownell <david-b@pacbell.net>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2008-11-26 at 21:16 +0000, Mark Brown wrote:
> On Wed, Nov 26, 2008 at 12:33:12PM -0800, David Brownell wrote:
> 
> > And maybe more; that's just me summarizing unconnected pins,
> > not the datasheet.  There are also cost-reduced parts with
> > less audio capability.
> 
> ...
> 
> > I make no claim about audio expertise -- the nearest I come
> > to it is observing a few years back that there was a huge
> > framework hole, which ASoC seems to fill -- but I wonder if
> > it shouldn't suffice just to provide a mask of capabilities
> > that are wired up on a given board.
> 
> It's possible - if the differences can be handled by marking some pins
> as connected or disconnected and possible specifying a different system
> clock rate to the chip then that approach was what I was expecting.
> If there is more substantial differences such as having the clocking
> arranged differently then separate drivers start to make more sense.

I had considered the differences among every boards. If you want add
some board specific dapm widgets or other features, you can use the
extended interface to add them. If a board has too much differences, you
can separate it from this driver and implement it independently.

Now there are four same driver files in alsa-devel tree and there are
another three same drives waiting to be pushed. So I think this shared
diver is needed. 

After reading all of the suggestions, I reworked the driver and will
send it again. This new version has a better difference-tolerance
ability.

Stanley.
