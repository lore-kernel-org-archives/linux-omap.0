From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: DM3730 Bluetooth Performance differences between SERIAL_8250_OMAP
 vs SERIAL_OMAP
Date: Fri, 4 Oct 2019 14:27:39 +0200
Message-ID: <CAGm1_kv6RMUDppu6ZjY9Dq7QL=hS=D+e3KS37+V0ncbwoXE6mQ@mail.gmail.com>
References: <CAHCN7xLO5VgA6tW4p7QjwPv_QXv==zbC38TxXtsR5x9H0mUGJA@mail.gmail.com>
 <CAHCN7xJPv7W381R7LS4bB8xWWpugz2NwbTUtj-hqHnDBZ9MFzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xJPv7W381R7LS4bB8xWWpugz2NwbTUtj-hqHnDBZ9MFzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Adam,

On Fri, Oct 4, 2019 at 12:39 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Oct 4, 2019 at 5:02 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > I am running Kernel 5.3.2 trying to troubleshoot some intermittent
> > Bluetooth issues, and I think I have narrowed it down to the serial
> > driver in use.
>
> I should have also noted that it's using UART2 with CTS and RTS on the
> DM3730 (omap3630) and its configured with a baud rate of 3M.
> I tried slowing it to 115200, but that didn't help.  I tried disabling
> the DMA hooks from the device tree, and that didn't help.
>
> > By default, omap2plus_defconfig enables both SERIAL_8250_OMAP and
> > SERIAL_OMAP.  I have my console device configured as  ttyS0, and all
> > appears fine.  When I enable Bluetooth, however, I get intermittent
> > errors on an DM3730 / OMAP3630.
> >
> > Using the 8250 driver for Blueotooth I get intermittent frame errors
> > and data loss.
> >
> > Scanning ...
> > [   28.482452] Bluetooth: hci0: Frame reassembly failed (-84)
> > [   36.162170] Bluetooth: hci0: Frame reassembly failed (-84)
> >         F4:4E:FC:C9:2F:57       BluJax
> > # l2ping F4:4E:FC:C9:2F:57
> > Ping: F4:4E:FC:C9:2F:57 from 00:18:30:49:7D:63 (data size 44) ...
> > 44 bytes from F4:4E:FC:C9:2F:57 id 0 time 8.27ms
> > no response from F4:4E:FC:C9:2F:57: id 1
> > ^C2 sent, 1 received, 50% loss
> >
> > (after a fairly long hang, I hit control-c)
> >
> > However, disabling the 8250 driver and using the only SERIAL_OMAP and
> > the console routed to ttyO0, the Bluetooth works well, so I believe it
> > to be a serial driver issue and not a Bluetooth error.
> >
> > # hcitool scan
> > Scanning ...
> >         F4:4E:FC:C9:2F:57       BluJax
> > ^C
> > # l2ping F4:4E:FC:C9:2F:57
> > Ping: F4:4E:FC:C9:2F:57 from 00:18:30:49:7D:63 (data size 44) ...
> > 44 bytes from F4:4E:FC:C9:2F:57 id 0 time 6.90ms
> > ...
> > 44 bytes from F4:4E:FC:C9:2F:57 id 14 time 28.29ms
> > ^C15 sent, 15 received, 0% loss
> > #
> >
> > 0% loss and regular, repeatable communication without any Frame
> > reassembly errors.
> >
>
> I tried disabling SERIAL_OMAP and using only SERIAL_8250_OMAP, but
> that didn't help.  Because the issue goes away when I disable
> SERIAL_8250_OMAP, I am wondering if something is either being
> misconfigured or some IRQ or DMA integration is missing that may be
> present with the older SERIAL_OMAP driver.
>
> > Any suggestions on how to troubleshoot or what might cause the
> > difference between the two drivers?

Can it be related to this issue [1]? Can you confirm that 5.2 is
working as expected with the 8250 driver?

[1] https://marc.info/?l=linux-serial&m=156965039008649&w=2

Cheers,
Yegor
