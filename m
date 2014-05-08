From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: dwc3: ep0: fix delayed status is queued too early
Date: Thu, 8 May 2014 11:22:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405081118480.1087-100000@iolanthe.rowland.org>
References: <20140509030133.GK19925@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140509030133.GK19925@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhuang Jin Can <jin.can.zhuang@intel.com>
Cc: Felipe Balbi <balbi@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, liping.zhou@intel.com, david.a.cohen@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Thu, 8 May 2014, Zhuang Jin Can wrote:

> > dwc3 _cannot_ return NYET to a SETUP packet.  The USB protocol does not 
> > allow it.  A device must always respond to SETUP with ACK.
> It true that device can not return NYET to a SETUP packet.
> A device must always respond to SETUP with ACK _if_ the SETUP packet is
> correctly received. Because there's no buffer prepared in ep0 for dwc3
> to receive the SETUP packet, I guess there will be no handshake
> returned to host. I can confirm this by doing an experiment tomorrow:)

The dwc3 driver should always prepare a buffer for the next ep0 SETUP
packet as soon as it retrieves the information for the current SETUP 
packet from the buffer.

Otherwise, as you described it, if the gadget driver never sends its 
delayed status response then the UDC will never respond to any more 
control transfers.

Alan Stern
