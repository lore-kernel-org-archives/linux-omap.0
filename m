From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Date: Fri, 2 Mar 2018 13:07:43 +0100
Message-ID: <CACRpkda-VLsMVqYx3Y6+3JtLJERhmeJZF5g4Gd9ecvgR1Nnr0A@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302103127.GA2081@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180302103127.GA2081@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, ext Tony Lindgren <tony@atomide.com>, =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>, Sebastian Reichel <sre@kernel.org>, Martijn Braam <martijn@brixit.nl>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Patrik Bachan <patrikbachan@gmail.com>, Ivajlo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Kevin Hilman <khilman@kernel.org>, serge@hallyn.com, Mark Brown <broonie@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel Baluta <daniel.baluta@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, kernel list <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>, Thorsten Leemhuis <regressions@leemhuis.info>, clayton@craftyguy.net, Sakari Ailus <sakari.ailus@linux.intel.com>, =?UTF-8?Q?Pali_Roh=C3=
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 2, 2018 at 11:31 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2018-03-02 10:33:24, Linus Walleij wrote:
>> On Fri, Mar 2, 2018 at 10:10 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Linux-Regression-ID: lr#4b650f
>> >
>> > On Tue 2018-02-27 09:43:32, Linus Walleij wrote:
>> >> On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> >>
>> >> > I did git bisect, and the winner seems to be:
>> >> >
>> >> > pavel@duo:/data/l/linux-n900$ git bisect bad
>> >> > c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
>> >> > commit c85823390215e52d68d3826df92a447ed31e5c80
>> >> > Author: Linus Walleij <linus.walleij@linaro.org>
>> >> > Date:   Wed Dec 27 16:37:44 2017 +0100
>> >> >
>> >> >     gpio: of: Support SPI nonstandard GPIO properties
>> >>
>> >> I have fixes queued for this, tried to send a pull request yesterday
>> >> but it turns out the fixes need fixing... OK I'm onto it anyways.
>> >
>> > Do you have any updates? Is there way to fix dts so that this does not
>> > trigger on N900?
>> >
>> > If this is taking longer to fix, should c85823390215 be reverted in
>> > the meantime? It does not seem particulary important/urgent...
>>
>> No patience between the v4.16 release candidates eh ;)
>>
>> commit 6662ae6af82df10259a70c7569b4c12ea7f3ba93
>> ("gpiolib: Keep returning EPROBE_DEFER when we should")
>>
>> and
>>
>> commit ce27fb2c56db6ccfe8099343bb4afdab15e77e7b
>> ("gpio: Handle deferred probing in of_find_gpio() properly")
>>
>> that are both in Torvalds' tree since yesterday should be fixing
>> this, I think? Did you try just using the upstream HEAD?
>
> After I spent hours bisecting, I was kind of assuming you'd cc me on
> merge request or something like that... so that I could test it before
> going mainline.

Sorry, I'm not very good with planning and coordination. I just
try my best to keep this working.

I guess ideally we should use Bugzilla to track regressions
like this, but it also comes with a bit of overhead so I don't
know if it helps more than trying to keep things in the head.

> Which of those should fix it?

The first one I guess, the second is mostly about supporting
-EPROBE_DEFER for different use cases.

> I tested today's mainline, and... sound fails, different way:
>
> pavel@n900:~$ cat /proc/asound/cards
>  0 [RX51           ]: RX-51 - RX-51
>                        RX-51
> pavel@n900:~$ cd g/tui/ofone/
> pavel@n900:~/g/tui/ofone$ cd
> pavel@n900:~$ festival --tts
>                        ahoj
>                        ^D
>                        uname -a
>
> (Festival is hung).

Sorry but I need some background here, I have no idea what
festival is, other than it seems to be some kind of userspace
test program?

>> Ok, so this code looks pretty crazy to me: I tried removing the
>> "of_find_spi_gpio" part, and audio started working.
>
> Hmm. Looks like audio is working w/o any changes, too. Not sure why
> festival hung on me before.

Does it mean that mainline is working find for you or
do we need to look deeper into the problem in the OF
lookup?

Yours,
Linus Walleij
