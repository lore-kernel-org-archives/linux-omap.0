From: "Arun KS" <getarunks@gmail.com>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Thu, 27 Nov 2008 10:31:18 +0530
Message-ID: <dfeb90390811262101ge24d63fie91e47b72738d4a2@mail.gmail.com>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<20081126110854.GA6234@sirena.org.uk>
	<20081126134028.b3c6aa46.jarkko.nikula@nokia.com>
	<200811261034.42356.david-b@pacbell.net>
	<20081126200750.GK6234@sirena.org.uk>
	<40134428-B064-4C6A-9229-FBEC8918B296@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <40134428-B064-4C6A-9229-FBEC8918B296@student.utwente.nl>
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
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>, David Brownell <david-b@pacbell.net>, "Stanley.Miao" <stanley.miao@windriver.com>, Mark Brown <broonie@sirena.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 27, 2008 at 1:50 AM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Op 26 nov 2008, om 21:07 heeft Mark Brown het volgende geschreven:
>
>> On Wed, Nov 26, 2008 at 10:34:41AM -0800, David Brownell wrote:
>>
>>> Re TWL4030 codec configuration ... I count three microphone
>>> input channels not used on Beagle, plus a speaker output
>>> and some other stuff.  So it's obvious that something which
>>> works on Beagle won't handle more interesting configurations
>>> of that audio support.
>>
>> Can someone post an overview of what the hardware configurations of
>> these boards are, please?  It's starting to sound like they're not very
>> similar at all.
>
> On the codec level all these board use a variant of the TWL4030. The
> variants differ slightly in what kind of extra goodies they provide. On the
> board level not every feature of the TWL familiy is used, the beagle only
> analog in and analog out, the overo exposes more interfaces, etc.
>
> Other people can fill in the details, but these are the differences I can
> think of.

omap2evm and omap3evm uses only auxiliary input(AUXR/AUXL)  and
Headset stereo output (HSOR/HSOL)

Regards,
Arun
>
> regards,
>
> Koen
>
