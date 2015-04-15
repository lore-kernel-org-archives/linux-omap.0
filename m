From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
Date: Wed, 15 Apr 2015 13:53:59 -0500
Message-ID: <552EB3C7.90603@ti.com>
References: <1425427237-11511-2-git-send-email-nm@ti.com> <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com> <20150310153321.GO5264@atomide.com> <54FF28F5.4040707@ti.com> <20150310173115.GS5264@atomide.com> <54FF38F3.2030703@ti.com> <CACRpkdZ1faucps07jaT9kOyviC+Sw6gPkbF=cAGCUj+DiaEgTA@mail.gmail.com> <20150318014151.GL31346@atomide.com> <20150415012910.GA29560@csclub.uwaterloo.ca> <552E9714.10001@ti.com> <20150415184454.GT29558@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150415184454.GT29558@csclub.uwaterloo.ca>
Sender: linux-gpio-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On 04/15/2015 01:44 PM, Lennart Sorensen wrote:
> On Wed, Apr 15, 2015 at 11:51:32AM -0500, Nishanth Menon wrote:
>> I am yet to post a new revision to this series - few other stuff got
>> in the way. IODelay driver in no way removes the constraint that the
>> SoC architecture has - most of the pins still need to be muxed in
>> bootloader - we cannot escape that. The reasoning for doing the mux in
>> bootloader is independent of the need for iodelay.
>>
>> Reasoning for mux in bootloader is because the mux and pull fields are
>> glitchy - much more than previous generations of TI SoCs and
>> significantly long enough to cause issues depending on the pins being
>> muxed.
> 
> Well if we know glitching is NOT an issue on our boards, then we don't
> have to do anything in the boot loader other than the basic setup for
> the serial console and emmc and SD, which has always been necesary.
> 
> I consider moving the mux setup to the bootloader a terrible design and
> won't go along with it.  We make sure all external devices have reset
> lines being held while the pinmux is being setup, so glitching is a
> non issue.

I cannot discuss customer boards on this list - the right forum for TI
support is e2e.ti.com or in cases where FAE (Field Applications
Engineer) is involved, via appropriate support path.

Now, that said, even with personal opinions in place, I have to stick
with what the SoC constraints on hand and suggested architecture we
have discussed to ensure safe platform operation at least for the
platforms we are contributing to. again... muxing in the bootloader IS
NOT what this patch is about. If we can stick to the topic in
discussion, it is probably more effective. Any improvement suggestions
to the code is more than appreciated.

>> Reasoning for iodelay is different - it is a hardware block meant to
>> control the timing of signals in a particular signal path to ensure
>> that specification compliance is met.
>>
>> Lets try not to mix the two.
> 
> Well I was told by multiple people from TI that the reason for moving
> the pinmux setup to the bootloader was because of the iodelay issue,
> so you will have to get the message made clear within TI then.
> 
I have passed on this message.

-- 
Regards,
Nishanth Menon
