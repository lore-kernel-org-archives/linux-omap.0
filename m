From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 12:51:00 +0300
Message-ID: <AANLkTiklmOz0WXY1piHCfiXDaObGwbGxWBT8Vcco25Uk@mail.gmail.com>
References: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<4C0D807E.2080607@ti.com>
	<AANLkTilRzAZbwEbc-52BfjntH83upmJZvAFE8fldRaXL@mail.gmail.com>
	<20100608.065558.189709308.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:13140 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0FHJvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 05:51:01 -0400
Received: by ey-out-2122.google.com with SMTP id 25so238444eya.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Jun 2010 02:51:00 -0700 (PDT)
In-Reply-To: <20100608.065558.189709308.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: ohad@wizery.com, felipe.contreras@nokia.com, deepak.chitriki@ti.com, fernando.lugo@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

On Tue, Jun 8, 2010 at 6:55 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> Date: Tue, 8 Jun 2010 05:11:50 +0200
>
>> Hi Deepak,
>>
>> On Mon, Jun 7, 2010 at 6:27 PM, Deepak Chitriki <deepak.chitriki@ti.=
com> wrote:
>>>> Ohad Ben-Cohen wrote:
>>>> Somewhat relevant note about mailbox performance: omap_mbox_msg_se=
nd
>>>> often (i.e. when the kfifo is empty) can just send the message
>>>> directly, without triggering the tasklet to do that. Applying such=
 a
>>>> change will substantially improve the mailbox performance, and wil=
l
>>>> make the shift to workqueues even more reasonable. I've got a patc=
h
>>>> for that, I'll post it soon.
>>>>
>>>
>>> tasklet is run in atomic context,so I wonder how mailbox performanc=
e will
>>> increase if you switch from tasklet to workqueue?
>>
>> In general moving from tasklet to workqueues will probably increase
>> some scheduling latencies.
>>
>> Nevertheless, if we'll send mailbox messages directly whenever
>> possible, without triggering any deferred context, we'll be improvin=
g
>> mailbox performance on average, because most of the time we will get
>> rid of the scheduling latencies entirely.
>
> I think that this depends on the situation.
>
> 1) too many messages are coming, buffering and tasklet works
> =C2=A0 efficiently at onece, for good throughput.
> 2) too few messages, the latency won't be a problem? Or some PM case
> =C2=A0 may be concerned.
>
> I guess that most of the case, we just care about the throughput of
> encoding and decoding, but I am afraid that data themselves are sent
> via shared memory and the traffic of mailbox message may not be so
> big. I'd like to see the actual data for practical usecases.
>
> Does TI have some typical test pattern to measure throughput? Or Feli=
pe?

What exactly are you interested in? The amount of messages being sent
on typical video encoding/decoding scenarios? My guess is that it
would be one or two messages per frame (60 msgs/s tops).

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
