From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Date: Fri, 2 Mar 2018 10:33:24 +0100
Message-ID: <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180302091025.GC30267@amd>
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

On Fri, Mar 2, 2018 at 10:10 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Linux-Regression-ID: lr#4b650f
>
> On Tue 2018-02-27 09:43:32, Linus Walleij wrote:
>> On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> > I did git bisect, and the winner seems to be:
>> >
>> > pavel@duo:/data/l/linux-n900$ git bisect bad
>> > c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
>> > commit c85823390215e52d68d3826df92a447ed31e5c80
>> > Author: Linus Walleij <linus.walleij@linaro.org>
>> > Date:   Wed Dec 27 16:37:44 2017 +0100
>> >
>> >     gpio: of: Support SPI nonstandard GPIO properties
>>
>> I have fixes queued for this, tried to send a pull request yesterday
>> but it turns out the fixes need fixing... OK I'm onto it anyways.
>
> Do you have any updates? Is there way to fix dts so that this does not
> trigger on N900?
>
> If this is taking longer to fix, should c85823390215 be reverted in
> the meantime? It does not seem particulary important/urgent...

No patience between the v4.16 release candidates eh ;)

commit 6662ae6af82df10259a70c7569b4c12ea7f3ba93
("gpiolib: Keep returning EPROBE_DEFER when we should")

and

commit ce27fb2c56db6ccfe8099343bb4afdab15e77e7b
("gpio: Handle deferred probing in of_find_gpio() properly")

that are both in Torvalds' tree since yesterday should be fixing
this, I think? Did you try just using the upstream HEAD?

Yours,
Linus Walleij
