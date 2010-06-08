From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 12:43:28 +0300
Message-ID: <AANLkTilasmQgcyckgBgpJspRHhsshDlVtdleItZiMp8M@mail.gmail.com>
References: <4C0D4004.5060303@ti.com>
	<AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
	<20100608.064632.104051482.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:17766 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab0FHJn3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 05:43:29 -0400
Received: by ey-out-2122.google.com with SMTP id 25so238044eya.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Jun 2010 02:43:28 -0700 (PDT)
In-Reply-To: <20100608.064632.104051482.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: fernando.lugo@ti.com, ohad@wizery.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

On Tue, Jun 8, 2010 at 6:46 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
>> I think the best thing to do here is remove the spinlock, if not,
>> you are preventing that omap_mbox_msg_send be executed from a
>> tasklet or isr context. That maybe in this moment it is not called
>> but it could be needed in the future. The caller of
>> omap_mbox_msg_send should be take care of that function can not be
>> call simultaneously.
>
> What about adding another function, omap_mbox_msg_send_sync()?

That's exactly what I was thinking about when I heard the problem.
Would this function send all the msgs already queued, and then wait
for the current one actually be sent?

-- 
Felipe Contreras
