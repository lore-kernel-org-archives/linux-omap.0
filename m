From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: introduce i2c-cbus driver
Date: Tue, 4 Sep 2012 12:31:42 +0300
Message-ID: <20120904093142.GB855@harshnoise.musicnaut.iki.fi>
References: <1346703805-31598-1-git-send-email-aaro.koskinen@iki.fi>
 <1346703805-31598-2-git-send-email-aaro.koskinen@iki.fi>
 <20120904090506.GA12397@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120904090506.GA12397-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 04, 2012 at 12:05:07PM +0300, Felipe Balbi wrote:
> > + * CBUS I2C driver for Nokia Internet Tablets.

[...]

> this version misses the entire IRQ handling we already had on linux-omap
> tree, so it's quite a regression.

There's no interrupts used in plain CBUS protocol/communication I think?

But Retu MFD supports the GPIO IRQ. I added the code for this set. And
the power button driver (patch 4/4) is using this functionality:

# cat /proc/interrupts
[...]
204:         29      GPIO  retu-mfd
224:         29      RETU  retu-pwrbutton

A.
