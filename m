From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly in
 non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 18:00:56 +0200
Message-ID: <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
	<alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 3, 2012 at 9:42 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 3 Feb 2012, Grazvydas Ignotas wrote:
>> On Fri, Feb 3, 2012 at 11:54 AM, NeilBrown <neilb@suse.de> wrote:
>> > Maybe it is 37xx specific. =C2=A0I think this is a DM3730.
>>
>> Not sure if it's the same problem but with 3530 on 3.2 with
>> sleep_timeout set, I usually get first char dropped (as expected) bu=
t
>> sometimes I get corrupted char instead too. Corrupt char seems to
>> almost always happen if I set cpufreq to powersave, on performace it=
's
>> almost always ok, so maybe it's some timing problem,
>
> OK so let's distinguish between two corruption situations:
>
> 1. The first character transmitted to the OMAP UART in a serial conso=
le
> when the UART powerdomain is in a non-functional, low power state (e.=
g.,
> RET or below) is corrupted. =C2=A0This is not actually output corrupt=
ion, this
> is input corruption.
>
> 2. Characters are corrupted while the OMAP UART is transmitting data,=
 but
> there has been no recent data sent to the OMAP.
>
> Case 1 is expected and is almost certainly not a bug.  As Neil mentio=
ned
> it should be bps-rate dependent.  It occurs when the first character
> transmitted to the OMAP wakes the chip up via I/O ring/chain wakeup.
> I/O ring/chain wakeup is driven by a 32KiHz clock and is therefore
> relatively high-latency.  So this could easily cause the first charac=
ter
> or first few characters to be lost or corrupted, depending on the exa=
ct
> sequence of events, the low power state that the chip was in, etc.
>
> Case 2 is not expected.  That is likely a bug somewhere.  Neil, this =
is
> what I understood that you are experiencing.  Is that correct?
>
> Gra=C5=BEvydas, are you seeing case 1 or 2 (or something completely d=
ifferent
> ;-) ?

It's case 1. What I wanted to say is that first char is most often
nicely dropped and does not get into the terminal, so I can just type
the command after it. But in some cases terminal gets corrupted char
instead, so I must then first get rid of it somehow to successfully
send a command, which is annoying a bit. I thought that maybe there is
code somewhere that gets rid of first bad char received and maybe it
can be tuned, but judging on further discussions it's all done by
hardware?

I've also noticed if I paste a command instead, up to 3 characters can
be lost, and in some cases I get 3 corrupted chars there instead. I
paste a command to both wake the board and read the fuel gauge just
before it updates to see how much current board was draining while
suspended. I insert 3 spaces at the start of command to be eaten by
wakeup, but if it decides to corrupt those chars instead of dropping,
the whole command is ruined. It's all at 115200 baud rate.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
