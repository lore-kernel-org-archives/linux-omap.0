From: Rob Herring <robh@kernel.org>
Subject: Re: seeing some junk characters on boot console with v4.9-rc1-3-g14155ca
Date: Tue, 18 Oct 2016 14:39:21 -0500
Message-ID: <CAL_JsqKgv5ez6a=F7ZxPLhZu7aHP+5ZSgaEiHx27zHk=x7iouA@mail.gmail.com>
References: <7940c6b1-22df-90f9-4ef8-43b707db6f68@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7940c6b1-22df-90f9-4ef8-43b707db6f68@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 18, 2016 at 7:08 AM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
> Hi
>
> I am seeing some junk characters on uart boot console on DRA72x platform
> [1] and even on other TI platforms, did a bisect and found the commit
> "761ed4a94582" broke it first.
>
> By reverting below two commit, I don't see the issue logs [2].
>
> 761ed4a94582 "tty:serial_core: convert uart_close to use tty_port_close"
> a5a2b13074fd "serial: core: fix potential NULL pointer dereference"

Can you test with the patch titled "tty: serial_core: Fix serial
console crash on port shutdown"[1]? It may be disabling the console
when it shouldn't.

Rob

[1] http://www.gossamer-threads.com/lists/linux/kernel/2546399
