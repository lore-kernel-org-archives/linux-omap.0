From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Wed, 23 Mar 2011 01:20:23 +0900
Message-ID: <AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110322155730.GD30303@linux-sh.org>
Sender: linux-input-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 23, 2011 at 12:57 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Mar 23, 2011 at 12:43:54AM +0900, Magnus Damm wrote:
>> On Wed, Mar 23, 2011 at 12:32 AM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Wed, Mar 23, 2011 at 12:22:05AM +0900, Magnus Damm wrote:
>> >> I believe all other i2c keyboard drivers use module_init().
>> >>
>> > We do not change initcall ordering around unless there is a reason to do
>> > so, as it's assumed that a given initcall has been chosen for a reason.
>>
>> Yes, obviously this driver is special and all other keypad drivers are wrong.
>>
> I'm not sure why you're purposely trying to be dense. I was explaining
> why it's not uncommon to find drivers using subsys_initcall for various
> non-obvious reasons and why blindly changing them without valid rationale
> generally causes more trouble than it prevents. In the case of a keypad
> driver it's unlikely to matter, but someone may still have had a reason
> for doing so. Given that your patch is fixing a problem, this is what
> should be reflected in your commit text, not some vague hand-waving about
> what everyone else is doing or what could hypothetically lead to
> problems.

Sure, including the problem description is of course a good thing.

>> It would be interesting to hear why subsys_initcall() was put there in
>> the first place.
>>
> In this case I would suspect general indifference or simply copying other
> drivers. I2C is a bit of a tricky case with regards to ordering in
> general, but at least input devices are relatively straightforward.

I remember having to move the init order around at least once before
in the case of i2c, so I'm not so surprised when new initcall issues
come up now and then.

Perhaps the original driver author remembers why subsys_initcall() was
put there.

>> The keypad driver tries to use the I2C bus before the I2C bus driver
>> is initialized. Isn't that a pretty good reason to change the initcall
>> order?
>>
> Yes, and that part is also not mentioned anywhere in your commit text.
> Starting to see a pattern?

"This may lead to problems with the tca6416 driver being initialized
before the I2C bus driver."

The "may" above comes from that I don't know the i2c bus driver
initcall time on non-SH-Mobile platforms. So this may trigger on other
platforms, or it may not depending on their cpu/board code and I2c bus
driver.

>> > You had a reason, great. Next time put it in your commit text.
>>
>> Whatever. Let me know which lines you'd like to add and I'll send a V2.
>>
> I don't think it's too much to ask that you write a commit text that
> actually mentions what problem you are experiencing and fixing. I also
> don't know why this needs to be pointed out. One shouldn't have to work
> for an explanation of what purpose your patch serves when you're the one
> trying to get it merged.

I agree that it's not too much to ask for. This patch did however have
20 lines of commit message for a one line change. Obviously the words
were not chosen well enough to please everyone, but compared to most
commit messages I read I believe my description was at least rather
detailed.

/ magnus
