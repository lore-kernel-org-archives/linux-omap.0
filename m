From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [balbi-usb:i2c-transferred-bytes-on-NACK 7/9]
 drivers/media/i2c/adv7604.c:406:9: warning: initialization makes integer
 from pointer without a cast
Date: Thu, 25 Oct 2012 01:17:02 +0800
Message-ID: <20121024171702.GA6521@localhost>
References: <5087e56f.wwcO2kZCKDOco89b%fengguang.wu@intel.com>
 <20121024132323.GA16927@localhost>
 <20121024133720.GF21735@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121024133720.GF21735-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 24, 2012 at 04:37:20PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Oct 24, 2012 at 09:23:23PM +0800, Fengguang Wu wrote:
> > Sorry, this should really be CCed to the media list.
> > I'll use the list recommended by get_maintainer.pl in future.
> 
> Actually, I would suggest only testing the following branches from my
> tree:
> 
> dwc3, musb, xceiv, gadget and fixes
> 
> Those are my final branches, everything else is a temporary branch that
> I'm using just so I don't loose some patches, or to make it easy for
> other guys to test patches.

Balbi, thanks for the instructions. I'll limit future tests to the
above branches.

Thanks,
Fengguang
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
