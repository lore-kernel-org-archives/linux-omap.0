From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] tty: serial: 8250 core: allow to overwrite & export
 serial8250_startup()
Date: Thu, 10 Jul 2014 16:55:35 +0200
Message-ID: <53BEA967.4070200@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de> <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/09/2014 07:49 PM, Sebastian Andrzej Siewior wrote:
> The OMAP version of the 8250 can actually use 1:1 serial8250_startup(=
).
> However it needs to be extended by a wakeup irq which should to be
> requested & enabled at ->startup() time and disabled at ->shutdown() =
time.
>=20
> v1=E2=80=A6v2: add shutdown callback

forgot to copy the callbacks in serial8250_register_8250_port().

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
