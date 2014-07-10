From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/6] tty: serial: 8250 core: allow to overwrite & export
 serial8250_startup()
Date: Thu, 10 Jul 2014 15:54:07 +0100
Message-ID: <20140710155407.3affb663@alan.etchedpixels.co.uk>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
	<1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed,  9 Jul 2014 19:49:33 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The OMAP version of the 8250 can actually use 1:1 serial8250_startup(=
).
> However it needs to be extended by a wakeup irq which should to be
> requested & enabled at ->startup() time and disabled at ->shutdown() =
time.
>=20
> v1=E2=80=A6v2: add shutdown callback
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

1,2 & 4

Acked by: Alan Cox <alan@linux.intel.com>
