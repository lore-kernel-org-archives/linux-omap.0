From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] usb: musb: fix bug in musb_start_urb
Date: Mon, 23 Feb 2009 14:05:42 -0800
Message-ID: <200902231405.42762.david-b@pacbell.net>
References: <1233921146-4046-1-git-send-email-ajay.gupta@ti.com> <498C515B.20603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:27971 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752881AbZBWWFp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 17:05:45 -0500
In-Reply-To: <498C515B.20603@ru.mvista.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Friday 06 February 2009, Sergei Shtylyov wrote:
> Ajay Kumar Gupta wrote:
> 
> > urb->transfer_buffer_length and urb->transfer_buffer should be
> > updated based on urb->actual_length.For a fresh and first time urb,
> > actual_length will be zero but for urbs which has been stopped and
> > restarted (as bulk nak scheme does) actual_length may not be zero.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
>     NAK, this is not a problem for the current driver since URBs do not ever 
> get restarted.

Resolvable by changing the patch description to not say
this is a "fix".

However, since this is a two line change, I think I'll
just merge this with the patch adding the bulk RX retry
logic.


> Also, musb_host_tx() doesn't update urb->actual_length --  
> please fix it too.

That would be a good point if the retry patch touched
any TX paths.  But it doesn't.


> Also, you must not clear qh->iso_idx when restarting -- you  
> must not start ISO transfer all over again too. Also, you should not set  
> musb->ep0_state to MUSB_EP0_START again in this case (I agree that control 
> transfers will remain not restartable from an arbitatry place even then).

But the [3/3] patch only adds NAK timeout support for
bulk RX.  And ISO transfers can't NAK in the first place.

Plus, as noted in a comment you could see in this patch,
this only touches (re)start for bulk/interrupt transfers.
Not ISO; not control.

- Dave
