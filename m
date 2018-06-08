From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: igep: Relicense the IGEP boards under
 GPLv2/X11
Date: Thu, 7 Jun 2018 23:41:00 -0700
Message-ID: <20180608064100.GM5738@atomide.com>
References: <20180606152500.14034-1-enric.balletbo@collabora.com>
 <20180608063222.GL5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180608063222.GL5738@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com, devicetree@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180607 23:32]:
> Hi,
> 
> * Enric Balletbo i Serra <enric.balletbo@collabora.com> [180606 08:27]:
> > The current GPLv2 only licensing on IGEP boards makes it very impractical
> > for other software components licensed under another license.
> > 
> > In order to make it easier for them to reuse our device trees, relicense
> > all boards under a GPLv2/X11 dual-license. Also switch to use the SPDX
> > identifiers and remove the boiler plate license text.
> 
> I don't think you have all the people in Cc who have already
> contributed patches to these files, can you please check the
> files with git log?

Oh and these still include omap3.dtsi and other GPL 2.0 licensed
files so this relicensing may not work out without lots of emails
and and acks from all the contributors.

Regards,

Tony
