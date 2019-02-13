From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Letux-kernel] [PATCH] ARM: dts: omap3-gta04: declare backlight
 in lcd node
Date: Wed, 13 Feb 2019 07:49:06 -0800
Message-ID: <20190213154906.GU5720@atomide.com>
References: <20190211162007.15626-1-andreas@kemnade.info>
 <E556C766-1B1D-4352-9D64-D18B631ADB7D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E556C766-1B1D-4352-9D64-D18B631ADB7D@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190211 18:14]:
> 
> > Am 11.02.2019 um 17:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > The lcd display of the gta04 has a backlight but the backlight
> > was not referenced in the lcd node, so screen blanking did
> > not turn off the backlight. Fix that.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> 
> Works fine.
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks applied into omap-for-v5.1/dt.

Tony
