From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Can a phone hook switch follow alsa jack model?
Date: Mon, 29 Jun 2009 18:35:58 +0200
Message-ID: <200906291835.59534.jkrzyszt@tis.icnet.pl>
References: <4A40D896.8010208@tis.icnet.pl> <4A437226.4090202@tis.icnet.pl>
	<20090629143215.GA23835@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090629143215.GA23835@rakim.wolfsonmicro.main>
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
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday 29 June 2009 16:32:15 Mark Brown wrote:
> On Thu, Jun 25, 2009 at 02:48:38PM +0200, Janusz Krzysztofik wrote:
> > During my previous, gpio-keys based attempt, I submitted a patch
> > that added new SW_HANDSET_PICK_UP event definition to
> > include/linux/input.h. Even if not accepted because of no
>
> Something like hook switch would be a more common name - the switch is
> closed when the phone is on hook.

I guess so.

> > comments, especially on the name I have choosen. However, there were
> > another name proposed by ams-delta board maintainer, Jonathan
> > McDowell - SW_PHONE_HOOK. Even if my wording may better match those
> > already existing ..._INSERT names, I am not sure which one should I
> > use.
>
> The _INSERT isn't at all appropriate since there's nothing being
> inserted here - the _INSERT names refer to the fact that something is
> being plugged in to a jack.

Sure, that's why I tried to replace _INSERT with _PICK_UP, that probably can 
closely refer to what can happen to a handset, while still following the 
general trend of ending switch related event names with action names.

> > Please also note that SND_JACK_HEADSET, that I temporarily use for
> > now, is an alias for SND_JACK_HEADPHONE | SND_JACK_MICROPHONE. Those
> > two can be seen as matching what a handset actually is. On headset
> > jack insert/remove, two distinct reports/events are generated, one
>
> OTOH a phone going on hook tends to mean something rather different in
> UI terms to having something plugged into a jack - it's part of the
> normal flow of making a phone call.

That's how I argued once in my message to Jonathan:
> I have choosen a different name to distinguish the switch actual function
> from what we know from telephony world as a switch that connects a phone to
> a line in response to a handset pick up.

Mark,
Thanks for sharing your thoughts. I am not going to waste your time on this 
linguistic debate any more. For now, I keep on using SND_JACK_HEADSET unless 
somebody happens to hit upon a better idea. If there are no other votes, I 
will try to work out a consistent set of symbols using one or another of 
already considered names that would best match current naming schema.

Cheers,
Janusz
