From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Mon, 11 Dec 2017 08:34:43 +0100
Message-ID: <20171211073443.GB7712@kroah.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208094942.46748-2-yinbo.zhu@nxp.com>
 <20171208102111.GA16245@kroah.com>
 <87vahhpkhw.fsf@linux.intel.com>
 <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 11, 2017 at 03:15:37AM +0000, Yinbo Zhu wrote:
> 
> 
> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@linux.intel.com] 
> Sent: Friday, December 08, 2017 6:44 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Yinbo Zhu <yinbo.zhu@nxp.com>
> Cc: Mathias Nyman <mathias.nyman@intel.com>; open list:DESIGNWARE USB3 DRD IP DRIVER <linux-usb@vger.kernel.org>; open list:DESIGNWARE USB3 DRD IP DRIVER <linux-omap@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry Huang <jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
> Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
> 
> 
> >Hi,
> 
> >Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Fri, Dec 08, 2017 at 05:49:41PM +0800, yinbo.zhu@nxp.com wrote:
> >> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> >> 
> >> Description: This is a occasional problem where the software
> >
> > No need for a "Description:" word.  That's just assumed here, right?
> 
> I will remove "Description:" thanks.
> >> issues an End Transfer command while a USB transfer is in progress, 
> >> resulting in the TxFIFO  being flushed when the lower layer is 
> >> waiting for data,causing the super speed (SS) transmit to get blocked.
> >> If the End Transfer command is issued on an IN endpoint to flush out 
> >> the pending transfers when the same IN endpoint is doing transfers on 
> >> the USB, then depending upon the timing of the End Transfer (and the 
> >> resulting internal FIFO flush),the lower layer (U3PTL/U3MAC) could 
> >> get stuck waiting for data indefinitely. This blocks the transmission 
> >> path on the SS, and no DP/ACK/ERDY/DEVNOTIF packets can be sent from 
> >> the device.
> >> Impact: If this issue happens and the transmission gets blocked, then 
> >> the USB host aborts and resets/re-enumerates the device.
> >> This unblocks the transmitt engine and the device functions normally.
> >> 
> >> Workaround: Software must wait for all existing TRBs to complete 
> >> before issuing End transfer command.
> >> 
> >> Configs Affected:
> >> LS1088-48A-R1.0, LS2081A-R1.1, LS2088-48A-R1.0, LS2088-48A-R1.1, 
> >> LX2160-2120-2080A-R1.
> >
> > What are these Configs?  That doesn't seem to match up with anything 
> > that is in the kernel tree that I can see.
> 
> These configs is soc information, I don't enable it on these platform dts.
> Although the erratum issue can't be reproduced.  

I do not understand what this means, please explain it a bit better.

thanks,

greg k-h
