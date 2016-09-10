From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Sat, 10 Sep 2016 03:11:17 +0200
Message-ID: <CAALWOA_kSghc91PGMTSE9MVbJm7SHjmVrcPfXwN_Fd+snYZdkg@mail.gmail.com>
References: <20160829223542.18871-1-tony@atomide.com> <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com> <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
 <57D1B668.3070001@gmail.com> <CAL_JsqKYqQpDrLbV0DZ-CvHfeHsXvMc-gncc9obir4gehriXOw@mail.gmail.com>
 <20160909141055.GZ4990@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909141055.GZ4990@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 8 September 2016 at 15:38, Rob Herring <robh+dt@kernel.org> wrote:
> Yes, in theory a device can go from disabled to okay, but that's
> generally never been supported. Linux takes the simple approach of
> "disabled" means ignore it. I think we'll see that change with
> overlays.

No need for future tense there, overlays are being used on a daily
basis on the BeagleBone and have already been for years.

> I don't agree. Generally, disabled means the h/w is there, but don't
> use it. There may be some cases where the hardware doesn't exist for
> the convenience of having a single dts, but that's the exception.

Yes and no. What matters is whether "don't use it" means "you can't
put it to good use" or "don't even try to reach the peripheral, bad
things will happen". Right now it's used for both cases.

Ideally the latter case would be removed from the kernel's view entirely.

On 8 September 2016 at 16:20, Nishanth Menon <nm@ti.com> wrote:
> Minor point here

It's not minor, it's quite crucial.

> maintaining dts per paper spin is just too impossible to maintain

Even if the per-spin dtsi just consists of including the common dtsi
and then applying /delete-node/ per peripheral that is disabled in
efuse? (or through firewalling, e.g. on HS devices)

> the variations if maintained as seperate dts might infact end up being
> larger in number than all the dts we have in arch/arm/boot/dts

There are 813 dts files there. Even if there were a dra7xx and am57xx
for every value of x (and there really isn't) you wouldn't get
anywhere near there.

But, fair enough, efuse bits are definitely an excellent way to get
combinatorial explosion.

Afaik those feature bits are readable through the control module on TI
SoCs though. Assuming such a thing is the norm in SoC world maybe a
"delete-if" property referencing some sort of test on register bits of
a referenced syscon node might do the trick?

On the cortex-A8 doing auto-detection would be a feasible alternative,
by reusing the existing exception mechanism to trap synchronous
aborts, but e.g. the Cortex-A15 seems to use async aborts for *every*
bus error, which makes things just very awful.

Matthijs
