From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Can a phone hook switch follow alsa jack model?
Date: Thu, 25 Jun 2009 12:05:08 +0100
Message-ID: <20090625110508.GF17812@sirena.org.uk>
References: <4A40D896.8010208@tis.icnet.pl>
	<20090623222255.GA5617@sirena.org.uk>
	<4A4229EB.2090606@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4A4229EB.2090606@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 24, 2009 at 03:28:11PM +0200, Janusz Krzysztofik wrote:
> Mark Brown wrote:

> type. Don't you think that a new type like SND_JACK_PHONE_HOOK or 
> SND_JACK_PHONE_HANDSET should be defined for the purpose? Even if 
> HEADSET may not be very different from HANDSET, corresponding 
> SW_HEADPHONE_INSERT and SW_MICROPHONE_INSERT event names seem have very 
> little to do with picking up a phone.

Possibly, TBH I had thought I'd seen something for off-hook when I
looked at this originally but I can't seem to spot it now.

> So, if I want to follow the ASoC jack model, my in-kernel hook switch 
> handler should only power on/off the handset, not touching the 
> speakerphone at all. The latter should be controlled from userspace. 
> Please correct me if I am missing something.

That's my initial guess - I've not looked at your particular hardware
so it may not end up being the best way of dealing with your system but
from what you said it was the approach that sprang to mind.
