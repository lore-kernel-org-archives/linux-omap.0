From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from smps10_out1
Date: Fri, 11 Oct 2013 01:30:52 -0500
Message-ID: <CAGo_u6odWJ9UKwgaVu2YZzZKuYbveBoGDf99L=rJoK1-9KJ0SA@mail.gmail.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
	<20131010141949.GA13277@kahuna>
	<52579723.6080209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52579723.6080209@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, dt list <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 11, 2013 at 1:13 AM, Kishon Vijay Abraham I <kishon@ti.com>=
 wrote:
>
>> regulator-boot-on indicates that PMIC enables it by default as part =
of
>> OTP or some internal behavior -> Looking at the measurements done on
>> uEVM and OTP information -> regulator-boot-on should be kept here.
>
> No. Actually I don=92t want PMIC to enable it by default. I want the =
palmas-usb
> driver to handle it.
> Enabling it by default makes palmas-usb to detect VBUS interrupt. Thi=
s should
> ideally be detected only when you connect a host cable.
> Btw I didn't exactly get why you want regulator-boot-on should be kep=
t here.

binding description states:
- regulator-boot-on: bootloader/firmware enabled regulator
=46urther info: include/linux/regulator/machine.h
* @boot_on: Set if the regulator is enabled when the system is initiall=
y
*           started.  If the regulator is not enabled by the hardware o=
r
*           bootloader then it will be enabled when the constraints are
*           applied.

What that means is that it is enabled by firmware/bootloader (in our
case One Time Program {OTP} inside Palmas) when the system switches on
even before the kernel starts. and we know SMPS10 is autoenabled by
Palmas OTP configuration even before first instruction in A15
executes.

I think you misunderstand this to mean that you'd like the regulator
to be *switched on* automatically at kernel boot by regulator
framework - there is no reasoning why we'd want such a binding since
we'd expect drivers to do their job of requesting and enabling
regulators on need..

Hope this helps. Let me know if I misunderstood something here.

Regards,
Nishanth Menon
