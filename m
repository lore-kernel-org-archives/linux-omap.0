From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Tue, 16 Sep 2014 09:48:59 -0700
Message-ID: <20140916164858.GA1580@atomide.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <20140912224324.GK18849@atomide.com>
 <5416D2A0.5020407@linutronix.de>
 <541833C0.5020106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <541833C0.5020106@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140916 05:58]:
> On 09/15/2014 01:50 PM, Sebastian Andrzej Siewior wrote:
> > I changed the restore function the fix the am335x-evm + less "freez=
e".
> > And now we have this. So let me search=E2=80=A6
>=20
> IER was 0 by accident. It fixed in TX path.
> I pushed uart_v10_pre1 which should have it fixed aport from other
> things=E2=80=A6

Just verified that works for my off-idle test case thanks.

> I am going to address the review comments, to split the DMA callbacks
> as requested and if nobody comes up with something fancy we will have=
 a
> v10 :)

OK

Regards,

Tony
