From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
Date: Tue, 7 Jun 2016 12:14:57 -0500
Message-ID: <CAOCHtYhBSS+D-BQH28FO+RxyzvDg-yeX+6nvLu11G3TNkF7ELg@mail.gmail.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
 <20160602173932.GF5995@atomide.com> <CAOCHtYiWYrwSidHnKv4siFT-wU=tt5-YeDTwbM022ZTxdPFYYA@mail.gmail.com>
 <20160602175635.GG5995@atomide.com> <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC@SHSMSX101.ccr.corp.intel.com>
 <20160607060004.GD22406@atomide.com> <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FD673@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FD673@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Yong B" <yong.b.li@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux kernel <linux-kernel@vger.kernel.org>, "sdliyong@gmail.com" <sdliyong@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 7, 2016 at 1:14 AM, Li, Yong B <yong.b.li@intel.com> wrote:
> Thanks Tony.
>
> I checked the DTS/overlays using linux-yocto-4.1 kernel(Ostro OS). It seems to me that the kernel/u-boot do not include the latest overlay support patch. And I also tested the latest Debian 8.4 using BBB boards, the I2C1 does not work too. This patch is the simplest solution for I2C1/I2C2 in linux-yocto-4.1.

ps, your patch is also broken, you didn't even mux the pins, so i2c1
doesn't work for you anyways. ;)

pinctrl-0 = <&i2c2_pins>; -> pinctrl-0 = <&i2c1_pins>;

Option 1:

With the latest BBB image's, we utilize "cape_universal", thus you can
enable I2C1 via:

root@beaglebone:~# config-pin -l P9.17
default gpio gpio_pu gpio_pd spi i2c pwm

root@beaglebone:~# config-pin -l P9.18
default gpio gpio_pu gpio_pd spi i2c pwm

root@beaglebone:~# config-pin P9.17 i2c

root@beaglebone:~# config-pin P9.18 i2c

Option 2, for the BB-I2C1 overlay:

add

cape_enable=bone_capemgr.enable_partno=BB-I2C1

Option 3, wait for Pantelis's solution... ;)

http://comments.gmane.org/gmane.linux.kernel/2234662

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
