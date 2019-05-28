From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] ti-sysc driver changes to drop custom hwmods
 property
Date: Mon, 27 May 2019 23:16:14 -0700
Message-ID: <20190528061614.GL5447@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
 <380809b1-7152-faa5-9f43-2243fb4dad19@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <380809b1-7152-faa5-9f43-2243fb4dad19@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190528 00:58]:
> 
> 
> On 27/05/19 5:43 PM, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here are changes to improve ti-sysc driver to the point where we can
> > finally drop the custom hwmods property for most cases. This series
> > drops hwmods property only for omap4 UART and MMC as those can be
> > tested with core retention idle.
> > 
> > I'll be posting more patches for dropping hwmods properties as they
> > get tested.
> 
> Tony,
> 
> What is the base of this series? It does not apply cleanly neither on
> linux-next nor on top of 5.2->rc1. If there are dependencies do you have a
> branch?

Oh thanks for letting me know. It's against v5.2-rc1 but the first
patch of the series got accidentally left out. Looks like I used -n
option with git format-patch with -n 12 instead of -n13. I will
repost the series.

Regards,

Tony
