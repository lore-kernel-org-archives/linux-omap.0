From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: dwc3: gadget: fix burst size corruption
Date: Thu, 1 May 2014 09:45:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405010941550.1152-100000@iolanthe.rowland.org>
References: <20140501211424.GE30575@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140501211424.GE30575@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhuang Jin Can <jin.can.zhuang@intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 1 May 2014, Zhuang Jin Can wrote:

> > again, you found a bug on the gadget driver. Fix that. composite.c
> > guarantees that for those functions which don't pass bMaxBurst,
> > gadget->maxburst will be set to *at least* 1.
> > 
> I agree the real fix should be in the gadget driver. The patch intents
> to prevent hibernatition from being corrupted by a bad gadget driver.
> If OEMs develop their own gadget driver forgetting to call
> config_ep_by_speed(), it'll turn out to be everything works except
> dwc3 hibernation, and they'll complain to dwc3. f_ffs is an
> example has SuperSpeed support but doesn't call config_ep_by_speed().
> It's just for robustness, and dwc3 is not doing anything wrong.
> It did cause me a long time to figure out why the hibernation was broken.

You could include the check, for the sake of robustness, in dwc3 -- but
if it fails, you should write a message to the kernel log saying that
the gadget driver needs to be fixed.

Alan Stern
