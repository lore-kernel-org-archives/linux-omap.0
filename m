From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Tue, 16 Sep 2014 14:42:01 +0200
Message-ID: <20140916124200.GK28458@ci00147.xsens-tech.local>
References: <54119AAA.9080907@linutronix.de>
 <20140911151114.GD28458@ci00147.xsens-tech.local>
 <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140916090540.GJ28458@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140916090540.GJ28458@ci00147.xsens-tech.local>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 16, 2014 at 11:05:40AM +0200, Frans Klaver wrote:
> On Mon, Sep 15, 2014 at 06:42:04PM +0200, Sebastian Andrzej Siewior wrote:
> > On 09/12/2014 12:28 PM, Frans Klaver wrote:
> > > port config is 115200 8N1. I don't recall doing anything special. I
> > > boot, login, less file and get a lock.
> > 
> > So I booted my mini Debian 7.6 (basic system + openssh) on my beagle
> > bone black which is:
> > 
> > [    0.000000] AM335X ES2.0 (neon )
> > 
> > configured a console, login, invoked "less file". The file was shown, I
> > hit on the space key so less shows me more of the file. No lock-up.
> > I tried booting via NFS and MMC. I tried various files with less.
> > 
> > My dot config is here
> > 	https://breakpoint.cc/config-am335x-bb.txt.xz
> > 
> > If there is nothing specific to the file you do less on I have no idea
> > what else it could if it is not the config.
> 
> I'll test your config and go through the differences.

So far it looks like it isn't in the config. I've tested both your and
my config on debian wheezy on a boneblack. No lock ups.

Less doesn't fill my entire screen, so it looks a bit funky when
scrolling, but I'm not sure if that's related to the driver.

I'll have to look further for things we did that may have impact here.

> Thanks,
> Frans
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
