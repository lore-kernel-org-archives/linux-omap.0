From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Wed, 24 Aug 2011 23:47:50 -0700
Message-ID: <CAFm5wm2sd3nEr3Qk+4ePUO2Y37e-He33Uy6xpvjf8rb8-t0ndA@mail.gmail.com>
References: <CAFm5wm1W03BbjNV4uZLGNjFZLKvfiLLQyP3M01r83EQ47724wQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1108121302070.15086-100000@netrider.rowland.org> <CAFm5wm1sAerG9AJB6w5W38DHRpBvLzG9UcnDWyQf8ocSfvENyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52281 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751336Ab1HYGsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 02:48:11 -0400
In-Reply-To: <CAFm5wm1sAerG9AJB6w5W38DHRpBvLzG9UcnDWyQf8ocSfvENyA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Balbi, Felipe" <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, axelhaslam@ti.com, ccross@google.com, Moiz Sonasath <m-sonasath@ti.com>

=46elipe

On Fri, Aug 12, 2011 at 10:21 AM, Pandita, Vikram <vikram.pandita@ti.co=
m> wrote:
> On Fri, Aug 12, 2011 at 10:04 AM, Alan Stern <stern@rowland.harvard.e=
du> wrote:
>>
>> On Fri, 12 Aug 2011, Pandita, Vikram wrote:
>>
>> > On Fri, Aug 12, 2011 at 8:50 AM, Alan Stern <stern@rowland.harvard=
=2Eedu> wrote:
>> > > On Fri, 12 Aug 2011, Vikram Pandita wrote:
>> > >
>> > >> From: Vikram Pandita <vikram.pandita@ti.com>
>> > >>
>> > >> musb pm_runtime_get_sync call happens in intrrupt context on ca=
ble attach case
>> > >> That can result in re-enabling the interrupts and cause side af=
fects.
>> > >>
>> > >> So move the code to a work queue.

Any chance you go to line this up for the merge window?


>> > >
>> > > Instead of creating your own, new work queue, just use the pre-e=
xisting
>> > > PM work queue. =A0In other words, replace pm_runtime_get_sync() =
with
>> > > pm_runtime_get().
>> >
>> > In this case it may not work, because immediately after a
>> > pm_runtime_get_sync(),
>> > we are going to access MUSB registers and xxx_sync() =A0call ensur=
es we
>> > will not abort.
>>
>> I don't understand. =A0Why not just access those registers from with=
in
>> the runtime_resume callback?
>
> I am not the runtime_pm expert, but as i understand, in this case:
>
> USB cable attach
> Get Interrupt from Power IC (twl6030)
> Interrupt handler calls notifier_call_chain - cable attach/detach
> notification handler in MUSB code
> Notification_handler does:
> =A0 =A0* enable clocks for musb register access
> =A0 =A0** setup musb registers to start getting control ep0 interrupt=
s
> for usb enumeration
>
> * is the part were we need to do the clock enabling synchronously.
> The runtime_resume() call-back today for musb does not have to do
> anything with USB enumeration.
>
>>
>> Alan Stern
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
