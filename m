From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Sun, 21 Sep 2014 22:41:00 +0200
Message-ID: <20140921204100.GA10111@linutronix.de>
References: <54119AAA.9080907@linutronix.de>
 <20140911151114.GD28458@ci00147.xsens-tech.local>
 <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140917102812.GA20438@ci00147.xsens-tech.local>
Sender: linux-serial-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

* Frans Klaver | 2014-09-17 12:28:12 [+0200]:

>- Bone Black: Yocto poky, core-image-minimal
>  Login, "less file" locks up, doesn't show anything. I can exit using
>  Ctrl-C.

So I have the same with my and the serial-omap driver. No difference
here. The trace looks like this:
|           <idle>-0     [000] d.h.   444.393585: serial8250_handle_irq=
: iir cc lsr 61
|           <idle>-0     [000] d.h.   444.393605: serial8250_rx_chars: =
get 0d
received the enter key

|           <idle>-0     [000] d.h.   444.393609: serial8250_rx_chars: =
insert d lsr 61
|           <idle>-0     [000] d.h.   444.393614: uart_insert_char: 1
|           <idle>-0     [000] d.h.   444.393617: uart_insert_char: 2
|           <idle>-0     [000] dnh.   444.393636: serial8250_tx_chars: =
empty
|      kworker/0:2-753   [000] d...   444.393686: serial8250_start_tx: =
empty?1
|      kworker/0:2-753   [000] d.h.   444.393699: serial8250_handle_irq=
: iir c2 lsr 60
|      kworker/0:2-753   [000] d.h.   444.393705: serial8250_tx_chars: =
empty
|               sh-1042  [000] d...   444.393822: serial8250_start_tx: =
empty?1
|               sh-1042  [000] d.h.   444.393836: serial8250_handle_irq=
: iir c2 lsr 60
|               sh-1042  [000] d.h.   444.393842: serial8250_tx_chars: =
empty
|               sh-1042  [000] d...   444.393855: serial8250_start_tx: =
empty?0
|               sh-1042  [000] d.h.   444.393863: serial8250_handle_irq=
: iir c2 lsr 60
|               sh-1042  [000] d.h.   444.393867: serial8250_tx_chars: =
put 0d
|               sh-1042  [000] d.h.   444.393871: serial8250_tx_chars: =
put 0a

shell responded with "\r\n" which I see and then

|               sh-1042  [000] d.h.   444.394057: serial8250_handle_irq=
: iir c2 lsr 60
|               sh-1042  [000] d.h.   444.394065: serial8250_tx_chars: =
empty

nothing more. less isn't sending data for some reason. Exactly the same
thing happens in a Debian environment except that it continues:
=E2=80=A6
|             bash-2468  [000] d.h.    99.657899: serial8250_tx_chars: =
put 0a
|             bash-2468  [000] d.h.    99.658089: serial8250_handle_irq=
: iir c2 lsr 60
|             bash-2468  [000] d.h.    99.658095: serial8250_tx_chars: =
empty
=3D>
|             less-2474  [000] d...    99.696038: serial8250_start_tx: =
empty?0
|             less-2474  [000] d.h.    99.696069: serial8250_handle_irq=
: iir c2 lsr 60
|             less-2474  [000] d.h.    99.696078: serial8250_tx_chars: =
put 1b
|             less-2474  [000] d.h.    99.696082: serial8250_tx_chars: =
put 5b
|             less-2474  [000] d.h.    99.696085: serial8250_tx_chars: =
put 3f
|             less-2474  [000] d.h.    99.696087: serial8250_tx_chars: =
put 31

It has to be something about the environment. Booting Debian and chroot
into this RFS and less works perfectly. But since it behaves like that
with both drivers, I guess the problem is somewhere else=E2=80=A6

>  vi runs normally, only occupies part of the total screen estate in
>  minicom. After quitting, a weird character shows up (typically I see
>  =C3=BF there), but minicom can use the rest of the screen estate aga=
in.
>  If we disregard the odd character, this is much like the behavior we
>  have on the omap-serial driver.
>- Custom board: Yocto poky, custom image
>  Login, "less file" locks up, showing only "=C3=BF" in the top left c=
orner
>  of the screen. Can get out of there by having something dumped throu=
gh
>  /dev/kmsg.

I managed to run into something like that with vi on dra7 and with
little more patience on am335x as well by "vi *" and then ":n".

This gets fixed indeed by writing. Hours of debugging and a lot of hair
less later: the yocto RFS calls set_termios quite a lot. This includes
changing the baudrate (not by yocto but the driver sets it to 0 and the=
n
to the requested one) and this seems to be responsible for the "bad
bytes". I haven't figured out yet I don't see this with omap-serial.
Even worse: If this (set_termios()) happens while the DMA is still
active then it might stall it. A write into the FIFO seems to fix it an=
d
this is where your "echo >/dev/kmsg" fixes things.
If I delay the restore_registers part of set_termios() until TX-DMA is
complete then it seems that the TX-DMA stall does not tall anymore.

>Having it summed up like this, I think we're back at ncurses and its
>interaction with the serial driver.
>
>Hope this helps. Thanks for your effort so far,
>Frans

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
