From: "Li, Yong B" <yong.b.li@intel.com>
Subject: RE: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
Date: Tue, 7 Jun 2016 06:14:33 +0000
Message-ID: <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FD673@SHSMSX101.ccr.corp.intel.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
 <20160602173932.GF5995@atomide.com>
 <CAOCHtYiWYrwSidHnKv4siFT-wU=tt5-YeDTwbM022ZTxdPFYYA@mail.gmail.com>
 <20160602175635.GG5995@atomide.com>
 <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC@SHSMSX101.ccr.corp.intel.com>
 <20160607060004.GD22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607060004.GD22406@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux kernel <linux-kernel@vger.kernel.org>, "sdliyong@gmail.com" <sdliyong@gmail.com>
List-Id: linux-omap@vger.kernel.org

Thanks Tony.

I checked the DTS/overlays using linux-yocto-4.1 kernel(Ostro OS). It seems to me that the kernel/u-boot do not include the latest overlay support patch. And I also tested the latest Debian 8.4 using BBB boards, the I2C1 does not work too. This patch is the simplest solution for I2C1/I2C2 in linux-yocto-4.1.

Thanks,
Yong
-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com] 
Sent: Tuesday, June 7, 2016 2:00 PM
To: Li, Yong B <yong.b.li@intel.com>
Cc: Robert Nelson <robertcnelson@gmail.com>; Benoit Cousson <bcousson@baylibre.com>; Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; Russell King <linux@arm.linux.org.uk>; linux-omap@vger.kernel.org; devicetree <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; linux kernel <linux-kernel@vger.kernel.org>; sdliyong@gmail.com
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry

* Li, Yong B <yong.b.li@intel.com> [160602 22:49]:
> Hi Tony,
> 
> I can submit a V2 version about the "disabled", or just drop this patch?

Probably best to wait on this one until we know how it can be enabled without manually editing the dts file. I'm still hoping u-boot could enable it based on some environment variable..

Regards,

Tony
