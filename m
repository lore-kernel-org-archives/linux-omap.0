From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 3/3] ASoC: add support for Amstrad E3
 (Delta) machine
Date: Wed, 22 Jul 2009 13:19:26 +0100
Message-ID: <20090722121925.GE21171@rakim.wolfsonmicro.main>
References: <200907220523.01107.jkrzyszt@tis.icnet.pl>
	<20090722110328.GB7622@sirena.org.uk>
	<s5hhbx50wwl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5hhbx50wwl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 22, 2009 at 01:39:22PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > +	/* Setup pins after corresponding bits if changed */
> > > +	if ((bool)snd_soc_dapm_get_pin_status(codec, "Speaker") !=
> > > +			(bool)(function & (1 << AMS_DELTA_SPEAKER))) {

> > Don't like these casts...  why are they needed?

> Because the right side is the bit operation?

Ick, yes.

> The cast doesn't look nice, though...

Indeed.  I'd suggest rewriting to try to do less in the if statement - a
helper function seems to be in order here since the same code is
repeated several times with different pins and bitmasks.
