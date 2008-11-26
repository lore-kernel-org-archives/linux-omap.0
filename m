From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 21:16:15 +0000
Message-ID: <20081126211614.GA6514@sirena.org.uk>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<200811261034.42356.david-b@pacbell.net>
	<20081126200750.GK6234@sirena.org.uk>
	<200811261233.13259.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200811261233.13259.david-b@pacbell.net>
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

On Wed, Nov 26, 2008 at 12:33:12PM -0800, David Brownell wrote:

> And maybe more; that's just me summarizing unconnected pins,
> not the datasheet.  There are also cost-reduced parts with
> less audio capability.

...

> I make no claim about audio expertise -- the nearest I come
> to it is observing a few years back that there was a huge
> framework hole, which ASoC seems to fill -- but I wonder if
> it shouldn't suffice just to provide a mask of capabilities
> that are wired up on a given board.

It's possible - if the differences can be handled by marking some pins
as connected or disconnected and possible specifying a different system
clock rate to the chip then that approach was what I was expecting.
If there is more substantial differences such as having the clocking
arranged differently then separate drivers start to make more sense.
