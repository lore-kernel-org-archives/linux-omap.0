From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 7 Jun 2010 22:11:50 -0500
Message-ID: <AANLkTilRzAZbwEbc-52BfjntH83upmJZvAFE8fldRaXL@mail.gmail.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
	<1273073589-2485-5-git-send-email-ohad@wizery.com> <4C0D4004.5060303@ti.com>
	<AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<4C0D807E.2080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48097 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab0FHDML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 23:12:11 -0400
Received: by wyi11 with SMTP id 11so2877407wyi.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Jun 2010 20:12:10 -0700 (PDT)
In-Reply-To: <4C0D807E.2080607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Deepak,

On Mon, Jun 7, 2010 at 6:27 PM, Deepak Chitriki <deepak.chitriki@ti.com> wrote:
>> Ohad Ben-Cohen wrote:
>> Somewhat relevant note about mailbox performance: omap_mbox_msg_send
>> often (i.e. when the kfifo is empty) can just send the message
>> directly, without triggering the tasklet to do that. Applying such a
>> change will substantially improve the mailbox performance, and will
>> make the shift to workqueues even more reasonable. I've got a patch
>> for that, I'll post it soon.
>>
>
> tasklet is run in atomic context,so I wonder how mailbox performance will
> increase if you switch from tasklet to workqueue?

In general moving from tasklet to workqueues will probably increase
some scheduling latencies.

Nevertheless, if we'll send mailbox messages directly whenever
possible, without triggering any deferred context, we'll be improving
mailbox performance on average, because most of the time we will get
rid of the scheduling latencies entirely.

Thanks,
Ohad.
