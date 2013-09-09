From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCHv4] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 9 Sep 2013 16:26:38 +0200
Message-ID: <A84D17B9-D194-46CC-8D9C-8CB602F2A332@dominion.thruhere.net>
References: <1378734350-30479-1-git-send-email-koen@dominion.thruhere.net> <20130909141531.GL9325@radagast>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20130909141531.GL9325@radagast>
Sender: stable-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olof@lixom.net, stable@vger.kernel.org, George Cherian <george.cherian@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org


Op 9 sep. 2013, om 16:15 heeft Felipe Balbi <balbi@ti.com> het volgende geschreven:

> Hi,
> 
> On Mon, Sep 09, 2013 at 03:45:50PM +0200, Koen Kooi wrote:
>> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
>> so create a common dtsi both can use.
>> 
>> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver 
>> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
>> of 1.8. 
>> 
>> MMC support for AM335x still isn't in, so only the LDO change has been added.
>> 
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> Tested-by: Tom Rini <trini@ti.com>
>> Tested-by: Matt Porter <matt.porter@linaro.org>
> 
> not entirelly related to $SUBJECT but having HDMI listed in BBB DTS will
> prevent the use of RF cape, no ?

Complete and utter lack of software from TI for the RF cape is preventing the RF cape from working regardless of HDMI entries.