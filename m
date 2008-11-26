From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 21:22:27 +0000
Message-ID: <20081126212227.GB6514@sirena.org.uk>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<200811261034.42356.david-b@pacbell.net>
	<20081126200750.GK6234@sirena.org.uk>
	<200811261244.33631.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200811261244.33631.david-b@pacbell.net>
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

On Wed, Nov 26, 2008 at 12:44:33PM -0800, David Brownell wrote:

> Let me insert a minor plug from the PM perspective that it would be
> good to find a way that the codecs can sit in the proper places in
> the driver model tree.  Example with twl4030:  it's an I2C device
> and thus should be a child of something like

This is exactly what I'm saying about allowing the machine, codec and
platform drivers to probe separately.  It's the major benefit of v2.
