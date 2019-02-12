From: Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH] ARM: dts: am335x: Add support for Bosch Guardian
Date: Tue, 12 Feb 2019 19:52:36 +0000
Message-ID: <c227cc363297e7d0d9bd22a096e9b5f89fca8f5c.camel@collabora.com>
References: <20190211122727.5582-1-martyn.welch@collabora.com>
         <20190212184915.GN5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212184915.GN5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2019-02-12 at 10:49 -0800, Tony Lindgren wrote:
> Hi,
> 
> * Martyn Welch <martyn.welch@collabora.com> [190211 04:27]:
> > The Bosch Guardian is a TI am335x based device.
> > 
> > It's hardware specifications are as follows:
> > 
> >  * 256 MB DDR3 memory
> >  * 512 MB NAND Flash
> >  * USB OTG
> >  * RS232
> >  * MicroSD external storage
> >  * LCD Display interface
> 
> Thanks applying into omap-for-v5.1/dt.
> 

Thanks Tony.

> Do you have some link for this device for more
> information?
> 

I'm not aware of any publicly available documentation at this time.

> > +/include/ "tps65217.dtsi"
> 
> I'll update this to use #include "tps65217.dtsi"
> while applying.
> 

OK, I found examples of both, guess I picked the wrong one :-)

Martyn

> Regards,
> 
> Tony
