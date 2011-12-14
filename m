From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Wed, 14 Dec 2011 21:50:08 +0530
Message-ID: <CAAL8m4x6ToG5uuKebqSvJaYg6YQjwFK017AiOFVm0-6BtmiCCA@mail.gmail.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
 <87fwgow9vz.fsf@ti.com> <CAAL8m4wR-3WDYf_c56-h1ZtCg=Ob2T+FvOOaXLSKK1pyo9oh8Q@mail.gmail.com>
 <877h1znpdo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <877h1znpdo.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 8:59 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Wed, Dec 14, 2011 at 12:56 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>
>>> [...]
>>>
>>>> I have re-based this patch series against LO master
>>>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>>>
>>>> Same is available here [1]
>>>>
>>>> I have tested this patch series along with:
>>>>
>>>> 1.) Tero's V11 irq chaining series
>>>> =A0 =A0 =A0http://www.spinics.net/lists/linux-omap/msg61445.html
>>>> =A0 =A0 (This patch series is used for uart wakeup handling using
>>>> =A0 =A0 =A0 prcm_irq chaining)
>>>>
>>>> 2.) Rajendra's hwmod change
>>>> =A0 =A0 =A0http://www.spinics.net/lists/arm-kernel/msg148632.html
>>>> =A0 =A0 =A0(This patch handles init_no_idle flag setting
>>>> =A0 =A0 =A0 without this patch there will be boot warning however
>>>> =A0 =A0 =A0 all pm features will work after boot up.)
>>>>
>>>> 3.) Vishwa's io daisy chain changes.
>>>> =A0 =A0 =A0http://permalink.gmane.org/gmane.linux.ports.arm.omap/6=
5500
>>>> =A0 =A0 =A0(tested with and without this patch series pm features =
works).
>>>>
>>>> Same combination of patches based on above commit id
>>>> used for testing is available here [2].
>>>
>>> Please have a closer look at your branch.
>>>
>>> The second commit[1] commits the .rej file from a failed patch appl=
y,
>>> so obviously doesn't do what was intended.
>>>
>>
>> Sorry my bad I have refreshed the uart runtime branch [1]
>> & test branch [2].
>
> Can you add another patch which fixes these compiler warnings:
>
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c: In function 's=
erial_omap_irq':
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warning=
: 'ch' may be used uninitialized in this function [-Wuninitialized]
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: '=
ch' was declared here
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warning=
: 'ch' may be used uninitialized in this function [-Wuninitialized]
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: '=
ch' was declared here
>

Here is the patch [1] and pushed to
git://gitorious.org/runtime_3-0/runtime_3-0.git for_3_3/lo_rc4_uartrunt=
ime

--
Thanks,
Govindraj.R

[1]:

=46rom 3a40f4e1a4c6db40d06cc6c5536ec06e9e5daf3d Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Wed, 14 Dec 2011 21:24:11 +0530
Subject: [PATCH] OMAP2+: UART: Fix compilation/sparse warnings

=46ixes below compilation warning.

drivers/tty/serial/omap-serial.c: In function 'serial_omap_irq':
drivers/tty/serial/omap-serial.c:228:29: warning: 'ch' may be used
uninitialized in this function [-Wuninitialized]

=46ix below sparse warning.

drivers/tty/serial/omap-serial.c:392:52: warning: incorrect type in
argument 2 (different signedness)
drivers/tty/serial/omap-serial.c:392:52:    expected int *status
drivers/tty/serial/omap-serial.c:392:52:    got unsigned int *<noident>

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index f3ff0ca..7b0303d 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -166,11 +166,12 @@ static void serial_omap_stop_rx(struct uart_port =
*port)
 	pm_runtime_put_autosuspend(&up->pdev->dev);
 }

-static inline void receive_chars(struct uart_omap_port *up, int *statu=
s)
+static inline void receive_chars(struct uart_omap_port *up,
+		unsigned int *status)
 {
 	struct tty_struct *tty =3D up->port.state->port.tty;
-	unsigned int flag;
-	unsigned char ch, lsr =3D *status;
+	unsigned int flag, lsr =3D *status;
+	unsigned char ch =3D 0;
 	int max_count =3D 256;

 	do {
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
