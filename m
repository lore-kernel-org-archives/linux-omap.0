From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 3/3] ASoC: add support for Amstrad E3
 (Delta) machine
Date: Wed, 22 Jul 2009 16:55:36 +0200
Message-ID: <4A672868.6040502@tis.icnet.pl>
References: <200907220523.01107.jkrzyszt@tis.icnet.pl>
	<20090722110328.GB7622@sirena.org.uk>
	<s5hhbx50wwl.wl%tiwai@suse.de>
	<20090722121925.GE21171@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090722121925.GE21171@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

Mark Brown wrote:
> On Wed, Jul 22, 2009 at 01:39:22PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>>> +	/* Setup pins after corresponding bits if changed */
>>>> +	if ((bool)snd_soc_dapm_get_pin_status(codec, "Speaker") !=
>>>> +			(bool)(function & (1 << AMS_DELTA_SPEAKER))) {
> 
>>> Don't like these casts...  why are they needed?
> 
>> Because the right side is the bit operation?
> 
> Ick, yes.
> 
>> The cast doesn't look nice, though...
> 
> Indeed.  I'd suggest rewriting to try to do less in the if statement - a
> helper function seems to be in order here since the same code is
> repeated several times with different pins and bitmasks.

Thanks, I'll rewrite as you suggest.

Janusz
