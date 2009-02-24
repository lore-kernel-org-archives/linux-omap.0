From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] usb: musb: fix bug in musb_start_urb
Date: Tue, 24 Feb 2009 18:50:27 +0300
Message-ID: <49A41743.5090207@ru.mvista.com>
References: <1233921146-4046-1-git-send-email-ajay.gupta@ti.com> <498C515B.20603@ru.mvista.com> <200902231405.42762.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60297 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756199AbZBXPtz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2009 10:49:55 -0500
In-Reply-To: <200902231405.42762.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

Hello.

David Brownell wrote:

>>Ajay Kumar Gupta wrote:

>>>urb->transfer_buffer_length and urb->transfer_buffer should be
>>>updated based on urb->actual_length.For a fresh and first time urb,
>>>actual_length will be zero but for urbs which has been stopped and
>>>restarted (as bulk nak scheme does) actual_length may not be zero.

>>>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

>>    NAK, this is not a problem for the current driver since URBs do not ever 
>>get restarted.

> Resolvable by changing the patch description to not say
> this is a "fix".

> However, since this is a two line change, I think I'll
> just merge this with the patch adding the bulk RX retry
> logic.

    Yes, that's what should've been done from the start.

>>Also, musb_host_tx() doesn't update urb->actual_length --  
>>please fix it too.

> That would be a good point if the retry patch touched
> any TX paths.  But it doesn't.

    If one teaches musb_start_urb() to restart, that one should at least be 
consistent I think.

>>Also, you must not clear qh->iso_idx when restarting -- you  
>>must not start ISO transfer all over again too. Also, you should not set  
>>musb->ep0_state to MUSB_EP0_START again in this case (I agree that control 
>>transfers will remain not restartable from an arbitatry place even then).

> But the [3/3] patch only adds NAK timeout support for
> bulk RX.  And ISO transfers can't NAK in the first place.

> Plus, as noted in a comment you could see in this patch,
> this only touches (re)start for bulk/interrupt transfers.
> Not ISO; not control.

    All I was asking for was a bit of consistency. Note that I have already 
done all the changes that I requested for and can post them.
    URB restart is also going to be used for the interrupt transfers BTW.

> - Dave

WBR, Sergei
