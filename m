From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/5] Add phy support for AM335X platform using Generic
 PHy framework
Date: Mon, 8 Jul 2013 17:34:37 -0300
Message-ID: <20130708203435.GB2596@localhost>
References: <1373280201-31785-1-git-send-email-george.cherian@ti.com>
 <51DB16A1.6010006@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51DB16A1.6010006-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jul 08, 2013 at 09:44:33PM +0200, Sebastian Andrzej Siewior wro=
te:

> We need two nodes each one with a glue layer and a musb child node. T=
he
> instances crap in kernel has to vanish. Also that means your phy node=
s
> are wrong. This is not musb with two ports but two musb instances eac=
h
> with one port.
>=20

I agree completely. The current DT representation looks definitely odd,
and we should be looking at improving it.

I wonder if this is now possible, given the DT is supposed to be stable=
 ABI.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
