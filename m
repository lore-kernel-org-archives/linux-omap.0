From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
Date: Thu, 2 Jun 2016 12:45:59 -0500
Message-ID: <CAOCHtYiWYrwSidHnKv4siFT-wU=tt5-YeDTwbM022ZTxdPFYYA@mail.gmail.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com> <20160602173932.GF5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602173932.GF5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Yong Li <yong.b.li@intel.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux kernel <linux-kernel@vger.kernel.org>, sdliyong@gmail.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 2, 2016 at 12:39 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Robert Nelson <robertcnelson@gmail.com> [160602 10:39]:
> > On Thu, Jun 2, 2016 at 2:41 AM, Yong Li <yong.b.li@intel.com> wrote:
> >
> > > From: Yong Li <sdliyong@gmail.com>
> > >
> > > Without this patch, I2C-1 is missing on beaglebone black boards
> > >
> > > Signed-off-by: Yong Li <sdliyong@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/am335x-boneblack.dts | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> >
> >
> > This is also 'common' for the white/green, if your really going to push
> > this, please add it to:
> >
> > am335x-bone-common.dtsi
>
> But isn't this exposed on the cape pins? So the use can be
> whatever for these pins?

That is correct, "i2c1" is on the cape connector, with no primary
function defined.

Currently on mainline, the board and cape eeprom i2c bus's are enabled.

i2c0 = board eeprom
i2c2 = 'cape' eeprom

personally, nak by me to add i2c1 by default, should use overlay's to enable it.

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
