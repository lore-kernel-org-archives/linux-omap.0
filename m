From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 23 Oct 2012 11:35:06 +0200
Message-ID: <508664CA.7000601@ti.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com> <20121022155028.GA13791@core.coreip.homeip.net> <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sourav Poddar <sourav.poddar@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On 10/23/2012 11:13 AM, Linus Walleij wrote:
> On Mon, Oct 22, 2012 at 5:50 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Sourav,
>>
>> On Mon, Oct 22, 2012 at 06:43:00PM +0530, Sourav Poddar wrote:
>>> Adapt keypad to use pinctrl framework.
>>>
>>> Tested on omap4430 sdp with 3.7-rc1 kernel.
>>
>> I do not see anything in the driver that would directly use pinctrl. Is
>> there a better place to select default pin configuration; maybe when
>> instantiating platform device?
> 
> The option is to use pinctrl hogs. Then the pins will be taken,
> muxed and configured by the pin controller itself.
> 
> Another option (not implemented) is to use bus notifiers.
> 
> (I wrote about this in some other thread but can't find it now.)
> 
> Each approach above come with its own set of problems.
> 
> If the driver need to handle multiple states like default/idle/sleep
> it is IMO better to put the handling into the driver, so if that
> is what is going to happen also to this driver it could be a good
> idea to actually implement that code upfront and include in
> this submission so as to show that this driver is really going
> to exercise its pins.
> 
> But it's also a question of conformity: if other drivers in the
> system is using different states and this is the only one
> using a single "default" state, then it doesn't make sense
> to have just one driver get its pins using hogs, it's just
> inconsistent.
> 
> So Sourav, please tell us a bit about your plans for this
> and other drivers!

Yeah, this idea is to handle pinctrl from all the drivers, and
potentially change the mode during suspend when it is relevant.

Regards,
Benoit
