From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq handling
Date: Sat, 15 Nov 2014 08:42:03 +0300
Message-ID: <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com> <1416014452-6712-2-git-send-email-al.kochet@gmail.com> <20141115014859.GC808@saruman> <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com> <20141115034756.GA2917@saruman> <20141115035328.GA3289@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141115035328.GA3289@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello again.

> (please, never top-post)
Sorry.

Sorry for the inaccurate presentation of ideas. I am not a native Engli=
sh speaker.

=46irst about patches:
[PATCH 1/2] and [PATCH 2/2] - intended to solve two independent problem=
s.
They were sent as series, In the future, try not to do so, In order not=
 to mislead.

> How could I ever call omap_i2c_complete_cmd() with 'err' set as 0 if =
I
> had either a NACK or Arbitration Lost ?

[PATCH 1/2] - fix AL, NACK handling and does not apply to [PATCH 2/2].
It not cause of problem solved of [PATCH 2/2].

> =08right, this is the same as it was before. If count reaches 100 we =
will
> omap_i2c_complete_cmd().
*No*

During refactoring submitted a series of patches was made the mistake.
This error alters the behavior of the interrupt handler, if it ends wit=
h the message=20
"Too much work in one IRQ".

Error in the commit 66b9298878742f08cb6e79b7c7d5632d782fd1e1.=20
All subsequent commits were correct and translate this error further.

In the parent commit 3312d25e1abdc41be8a75a1b2c3ccaa39a14ed99
(the commit before 66b9298878742f08cb6e79b7c7d5632d782fd1e1) in case
count reaches 100, loop breaks *without* calling omap_i2c_complete_cmd(=
).

In commit 66b9298878742f08cb6e79b7c7d5632d782fd1e1, in case
count reaches 100, loop breaks and omap_i2c_complete_cmd() *get called*=
=2E

To see that, you need to open two versions of a file i2c-omap.c, side b=
y side.

i2c-omap.c version corresponding to parent commit:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/i2c/busses/i2c-omap.c?id=3D3312d25e1abdc41be8a75a1b2c3ccaa39a14ed=
99#n823

i2c-omap.c version corresponding next commit:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/i2c/busses/i2c-omap.c?id=3D66b9298878742f08cb6e79b7c7d5632d782fd1=
e1#n823

According to wikipedia: "Code refactoring is the process of restructuri=
ng existing computer code =96 changing the factoring =96=20
without changing its external behavior.'

And commit's (66b9298878742f08cb6e79b7c7d5632d782fd1e1) message states =
what:
i2c: omap: switch over to do {} while loop
this will make sure that we execute at least once.
No functional changes otherwise.

But functional change present!
It's call of omap_i2c_complete_cmd()!

The next question: What affects this change?
If count reaches 100 and loop breaks and no error occupy during loop pr=
ocessing,
and no error would be set in err_cmd, omap_i2c_complete_cmd will set 0 =
as
result of transfer and wakeup omap_i2c_xfer. In other words, current i2=
c transfer
will be aborted with incorrect (success) status set. But, does transfer=
 completed in real?
Do buf data was sent to i2c slave device or received from it in real?
Upper layer code would thing, that data was sent successfully.

How to see that bug in real live? Just add extra delayes into isr threa=
d.
I did it unintentionally inserting dev_warn into isr thread.

BTW. I made more testing and provide more logs to demonstrate affected =
changes.


> which deadlock are you talking about ? How do you trigger it ? Where =
are
> the lockup debug traces ?
>=20
> Well, I tried to debug I2C ISR hang issue (thats another question I
> want to discuss later) using output to console. I places few dev_warn
>=20
> if you found a bug with the ISR, why discuss it later ? How can I
> understand if you found a real bug without proper logs ?


I put in order my thoughts and describe. It's next problem, not related=
 to patch1/patch2.

In general, the problem (the 3rd one) is that linux either hang or segf=
ault
in the i2c-omap driver if another master on the i2c bus (multimaster en=
vironment),
submit write request to General Call Address. In that case ISR could no=
t correctly
handle RDR (or XRDY, ARDY, or that ever). Thats becase i2c-omap driver =
doesn't
correctly handle i2c-controller's slave mode. But controller enter slav=
e mode
after each master transfer. Yes, AAS and GC interrupts masked, but i2c-=
controller
still sends RDR (or that ever events) when it detect slave access from =
another master on the bus.

I have two safe solutions of the (3rd) problem in the mind:
- keep interrupts disabled between i2c-master access (I think about imp=
lementing
i2c_omap_interrupt_enable_clr/i2c_omap_interrupt_enable_set helpers and=
 putting
them in the right places)
- keep controller disabled between i2c-master access (keep EN-bit of CO=
N register 0)

That solutions also help with races between isr and xfer_msg.

What do you think about that?

How to reproduce 3-rd problem:
In order to ease reproduce, you should disable i2c controller from ente=
ring suspend mode:
echo on > /sys/devices/platform/omap/omap_i2c.2/power/control

And then, using another i2c-master, connected to the same (i2c.2) bus,
initiate I2C write transfer to Generall Call Address, than linux ether =
hang or isr thread segfault :)
