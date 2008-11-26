From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 14:03:18 -0800
Message-ID: <200811261403.18464.david-b@pacbell.net>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<200811261233.13259.david-b@pacbell.net>
	<20081126211614.GA6514@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20081126211614.GA6514@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Mark Brown wrote:
> >			I wonder if
> > it shouldn't suffice just to provide a mask of capabilities
> > that are wired up on a given board.
> 
> It's possible - if the differences can be handled by marking some pins
> as connected or disconnected and possible specifying a different system
> clock rate to the chip then that approach was what I was expecting.
> If there is more substantial differences such as having the clocking
> arranged differently then separate drivers start to make more sense.

OK, from my non-expert perspective it sounds eminently do-able.
By someone else.  :)
