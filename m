From: "Li, Yong B" <yong.b.li@intel.com>
Subject: RE: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
Date: Fri, 3 Jun 2016 05:46:50 +0000
Message-ID: <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC@SHSMSX101.ccr.corp.intel.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
 <20160602173932.GF5995@atomide.com>
 <CAOCHtYiWYrwSidHnKv4siFT-wU=tt5-YeDTwbM022ZTxdPFYYA@mail.gmail.com>
 <20160602175635.GG5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602175635.GG5995@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux kernel <linux-kernel@vger.kernel.org>, "sdliyong@gmail.com" <sdliyong@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I can submit a V2 version about the "disabled", or just drop this patch?

Thanks,
Yong
-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com] 
Sent: Friday, June 3, 2016 1:57 AM
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Li, Yong B <yong.b.li@intel.com>; Benoit Cousson <bcousson@baylibre.com>; Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; Russell King <linux@arm.linux.org.uk>; linux-omap@vger.kernel.org; devicetree <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; linux kernel <linux-kernel@vger.kernel.org>; sdliyong@gmail.com
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry

* Robert Nelson <robertcnelson@gmail.com> [160602 10:48]:
> On Thu, Jun 2, 2016 at 12:39 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Robert Nelson <robertcnelson@gmail.com> [160602 10:39]:
> > > On Thu, Jun 2, 2016 at 2:41 AM, Yong Li <yong.b.li@intel.com> wrote:
> > >
> > > > From: Yong Li <sdliyong@gmail.com>
> > > >
> > > > Without this patch, I2C-1 is missing on beaglebone black boards
> > > >
> > > > Signed-off-by: Yong Li <sdliyong@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/am335x-boneblack.dts | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > >
> > >
> > > This is also 'common' for the white/green, if your really going to 
> > > push this, please add it to:
> > >
> > > am335x-bone-common.dtsi
> >
> > But isn't this exposed on the cape pins? So the use can be whatever 
> > for these pins?
> 
> That is correct, "i2c1" is on the cape connector, with no primary 
> function defined.
> 
> Currently on mainline, the board and cape eeprom i2c bus's are enabled.
> 
> i2c0 = board eeprom
> i2c2 = 'cape' eeprom
> 
> personally, nak by me to add i2c1 by default, should use overlay's to enable it.

Yes sounds like the best we can do is define it but set it with status = "disabled" for now.

Regards,

Tony
