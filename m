From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] mailbox: change full flag per mailbox queue instead of
 global
Date: Tue, 10 Aug 2010 11:22:15 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CC1D0605@dlee06.ent.ti.com>
References: <1276534269-19179-1-git-send-email-x0095840@ti.com>
	<AANLkTim7s8pX3k7oF7AdZobDRegx17n5gfAze1wAduoT@mail.gmail.com>
 <20100810.185803.71555007.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55917 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab0HJQWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 12:22:24 -0400
In-Reply-To: <20100810.185803.71555007.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Tuesday, August 10, 2010 10:58 AM
> To: Guzman Lugo, Fernando; ohad@wizery.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] mailbox: change full flag per mailbox queue instead
> of global
> 
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: Re: [PATCH] mailbox: change full flag per mailbox queue instead
> of global
> Date: Tue, 10 Aug 2010 16:36:42 +0200
> 
> > Hi Hiroshi,
> >
> > On Mon, Jun 14, 2010 at 7:51 PM, Fernando Guzman Lugo <x0095840@ti.com>
> wrote:
> >> As pointed by Ben Ohand, the variable rq_full flag is a global
> >> variable, so if there are multiple mailbox users there will be
> >> conflics. Now there is a full flag per mailbox queue.
> >>
> >> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> >> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> >
> > It looks like this fix didn't get thru - can you please review and
> ack/nack ?
> 
> Sure.
> 
> Fernando, could you rebase this patch against the latest omap/master?

No problem, I will send it again.

Regards,
Fernando.

