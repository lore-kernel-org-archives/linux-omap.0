From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Mon, 15 Sep 2014 13:50:56 +0200
Message-ID: <5416D2A0.5020407@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <20140912224324.GK18849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140912224324.GK18849@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

On 09/13/2014 12:43 AM, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140910 12:30]:
>> the diff of v8=E2=80=A6v9 is small:
>> - rebased on top's of Greg's tty-next branch
>> - fixed #10 where we might have THRE interrupt enabled for longer th=
an
>>   needed
>> - re-did register setup in #10. Before this "less file" could freeze=
 the
>>   am335x-evm.
>=20
> FYI, looks like merging in your uart_v9 branch for testing
> with my hwmod changes now fails to produce RX characters on omap3.
>=20
> The device wakes up just fine to the wake-up interrupt, and then
> serial8250_handle_irq() gets called, but I'm not seeing anything
> in the console getting printed out. It's like all the RX characters
> are getting lost instead of just the first one. The RX characters
> work fine when the system is running.
>=20
> So it seems there's been some kind of regression since v8?

I changed the restore function the fix the am335x-evm + less "freeze".
And now we have this. So let me search=E2=80=A6

> Regards,
>=20
> Tony
>=20

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
