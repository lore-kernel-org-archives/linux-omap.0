From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/3] arm: dts: omap3-gta04: Add handling for tv output
Date: Tue, 13 Jan 2015 07:56:35 -0800
Message-ID: <20150113155634.GD2419@atomide.com>
References: <1417642402-20538-1-git-send-email-marek@goldelico.com>
 <1417642402-20538-4-git-send-email-marek@goldelico.com>
 <54B4EF43.50300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B4EF43.50300@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Marek Belisko <marek@goldelico.com>, plagnioj@jcrosoft.com, bcousson@baylibre.com, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150113 02:14]:
> On 03/12/14 23:33, Marek Belisko wrote:
> > Add handling for gta04 tv out chain:
> > venc -> opa362 -> svideo
> > 
> > Use invert-polarity in venc node because opa362
> > is doing polarity inversion also.
> > 
> > Signed-off-by: Marek Belisko <marek@goldelico.com>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 49 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> 
> Looks fine to me.
> 
> Tony, do you want to pick this up? I can take the first two patches via
> fbdev.

OK will pick the dtsi change.

Thanks,

Tony
