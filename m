From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] fix vibrations on Droid 4
Date: Fri, 17 Aug 2018 07:26:15 -0700
Message-ID: <20180817142615.GA7523@atomide.com>
References: <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
 <20180801202821.GB4033@amd>
 <20180802105535.2fvggxsma22usrfr@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802105535.2fvggxsma22usrfr@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [180802 10:59]:
> Hi,
> 
> On Wed, Aug 01, 2018 at 10:28:21PM +0200, Pavel Machek wrote:
> > Vibration GPIOs don't have anything to do with wakeup. Move it to
> > normal section; this fixes vibrations on Droid 4.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > index c27fc87..7b82179 100644
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Thanks applying into omap-for-v4.19/fixes.

Tony
