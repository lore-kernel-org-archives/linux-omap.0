From: Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.de>
Subject: Re: [PATCH 02/13] bluetooth: hci_ldisc: fix deadlock condition
Date: Thu, 24 Apr 2014 11:01:07 +0200
Message-ID: <20140424090107.GB8095@punisher.2og.er.corscience.de>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
 <1398265117-11793-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398265117-11793-2-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Dear Felipe Balbi,

On Wed, Apr 23, 2014 at 09:58:26AM -0500, Felipe Balbi wrote:
> LDISCs shouldn't call tty->ops->write() from within
> ->write_wakeup().
>=20
> ->write_wakeup() is called with port lock taken and
> IRQs disabled, tty->ops->write() will try to acquire
> the same port lock and we will deadlock.
>=20
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Reported-by: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Tested-by: Andreas Bie=DFmann <andreas@biessmann.de>

on custom TI AM37xx board with 3.4.87. Therefore I vote for adding this=
 to
stable branches (at least 3.4). It applies with a slight line shifting
(init_work is not available there).

I wonder if you have seen my approach [1] to fix this deadlock.  This s=
tuff is
quiet new to me. As I understood the work_queue has a bit more overhead=
 than a
tasklet. Therefore I implemented my fix with a tasklet. Would be great =
if one
could shed some light on that.

Best regards

Andreas Bie=DFmann

[1] https://lkml.org/lkml/2014/4/16/425

> ---
>  drivers/bluetooth/hci_ldisc.c | 24 +++++++++++++++++++-----
>  drivers/bluetooth/hci_uart.h  |  1 +
>  2 files changed, 20 insertions(+), 5 deletions(-)
