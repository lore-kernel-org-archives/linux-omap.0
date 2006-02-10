From: RAVI SHANGAR <ravishangar@gmail.com>
Subject: Kernel panic when a Qt application is executed(using mouse)
Date: Fri, 10 Feb 2006 18:26:01 +0530
Message-ID: <ade4abe50602100456h27719264l22d08db971ae2f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I am using linux 2.6.12 kernel in OMAP1510 innovator. I ported a Qt/E
application to the target and executed it.

Execution is fine for the first trial using the mouse for button clicks.

When i run it for the second time again, I can't use the mouse or when i
quit the application (either by mouse/keyboard), the following *kernel pani=
c
* message appears( note: some messages at the start were not captured)

But I didn't get any problem like this with the touchscreen used for the
same Qt/E application.

Please give a solution.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*KERNEL PANIC MESSAGE:*

*Unable to handle kernel NULL pointer dereference at virtual address
00000000*

*pgd =3D c0004000*

*[00000000] *pgd =3D 00000000*

*Internal error: Oops: 0[#1]*

*Modules linked in:*

*CPU:0*

*PC is at __init_begin+0x3fff80*

*r7 =3D 00000002 r6 =3D c0315F54*

*r5 =3D 0000001E r4 =3D C0314000*

*[<c00581d8>] <irq_exit+0x0/0x58> from [<c002ad5c>] <asm_do_IRQ+0x94/0xa4>*

*r4 =3D C037442C*

*[<c002acc8>] <asm_do_IRQ+0x0/0xa4> from [<c0029774>] <__irq_svc+0x34/0x84>=
*

*r6 =3D FFFFFFFF r5 =3D FEFECB00*

*r4 =3D FFFFFFFF*

*[<c0039178>] <omap_pm_idle+0x0/0xc0> from [<c002b7d8>] <cpu_idle+0x58/0xb0=
>
*

*[<c002b780>] <cpu_idle+0x0/0xb0> from [<c002902c>] <__init_end+0x2c/0x34>*

*r6 =3D C0317090 r5 =3D C03739D8*

*r4 =3D C038188C*

*[<c0029000>] <__init_end+0x0/0x34> from [<c000880c>]
<start_kernel+0x188/0x1cc>*

*[<c0008684>] <start_kernel+0x0/0x1cc> from [<10008094>] <0x10008094>*

*Code: bad PC value*

*<0> Kernel panic - not syncing: Aiee, killing interrupt handler!*

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

**

**
