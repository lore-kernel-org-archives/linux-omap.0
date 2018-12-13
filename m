From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap5: Add l4 interconnect hierarchy and
 ti-sysc data
Date: Wed, 12 Dec 2018 17:19:50 -0800
Message-ID: <20181213011950.GM6707@atomide.com>
References: <20181115224546.61475-1-tony@atomide.com>
 <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
 <ebc7e271-8717-fe9d-d24f-ae406860b913@ti.com>
 <20181212171143.GG6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181212171143.GG6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181212 17:12]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181212 02:44]:
> > On 12/12/2018 12.12, Peter Ujfalusi wrote:
> > > Reverting this patch in linux-next-20181210 will make the ethernet
> > > working again.
> > > 
> > > bootlog w/ revert: https://pastebin.com/dpRk1xWv
> > > bootlog w/o revert: https://pastebin.com/PWrBttxd
> > 
> > on omap5-uevm.
> 
> Thanks for testing. Looks like it works for me with
> loadable modules. And looks like changing just the phy to
> use CONFIG_NOP_USB_XCEIV=y in my .config is not enough to
> make it fail, I see it fail too with EHCI built-in.
> 
> It's probably some -EPROBE_DEFER type issues, but I need
> to debug more.

Yes there's an issue where nop_reset() for phy-generic is
not called by ehci-omap. I'll post a fix for that separately.

I also noticed that sata phy reg entries need fixing up
for omap5, will also post a patch for that.

Regards,

Tony
