From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 08 Jun 2010 12:55:39 +0300 (EEST)
Message-ID: <20100608.125539.39172600.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
	<20100608.064632.104051482.Hiroshi.DOYU@nokia.com>
	<AANLkTilasmQgcyckgBgpJspRHhsshDlVtdleItZiMp8M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39620 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab0FHKBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 06:01:18 -0400
In-Reply-To: <AANLkTilasmQgcyckgBgpJspRHhsshDlVtdleItZiMp8M@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: fernando.lugo@ti.com, ohad@wizery.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 11:43:28 +0200

> On Tue, Jun 8, 2010 at 6:46 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
>>> I think the best thing to do here is remove the spinlock, if not,
>>> you are preventing that omap_mbox_msg_send be executed from a
>>> tasklet or isr context. That maybe in this moment it is not called
>>> but it could be needed in the future. The caller of
>>> omap_mbox_msg_send should be take care of that function can not be
>>> call simultaneously.
>>
>> What about adding another function, omap_mbox_msg_send_sync()?
> 
> That's exactly what I was thinking about when I heard the problem.
> Would this function send all the msgs already queued, and then wait
> for the current one actually be sent?

Could be as you said. I haven't thought that much.

What I just thought was to bypass kfifo and tasklet and to put a
message directly to H/W fifo. Maily just for the above case which
Fernando described above.

Fernando, what do you think on Felipes?
