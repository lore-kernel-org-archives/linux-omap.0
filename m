From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] tty: serial_core: Add mechanism to identify port closure.
Date: Mon, 23 Apr 2012 14:25:35 +0530
Message-ID: <CAMrsUdLaamf9boyMF824iTXdDce0qB3AiUfMiM3a1gL2DcVPqA@mail.gmail.com>
References: <1334919473-18870-1-git-send-email-govindraj.raja@ti.com> <20120420142740.053b9981@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120420142740.053b9981@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Alan,

On Fri, Apr 20, 2012 at 6:57 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/s=
erial_core.c
>> index 9c4c05b..0dc246d 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1284,6 +1284,8 @@ static void uart_close(struct tty_struct *tty,=
 struct file *filp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_wait_until_sent(tty, uport->timeout=
);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 state->uart_port->closing =3D true;
>
> So what are the locking rules for this - when is it valid and when ca=
n it
> be tested.
>
> This also still seems a hack to me - the core tty code doesn't have
> suspend/resume/open/close confused. The uart layer does, so really th=
e
> uart layer needs untangling. I'm skeptical yet another magic state
> variable is the answer, particularly when the locking model for the
> variable appears undefined.
>
> Teach the uart core code to pass an extra argument indicating whether=
 its
> really doing shutdown/open or merely doing suspend/resume. It's perfe=
ctly
> sensible that it tries to use the same helper for both, its broken th=
at
> the called code cannot tell which.
>
> The parameter would also be a local variable which avoids all the loc=
king
> questions.

Yes adding a _state_ local variable from port_shutdown from serial_core=
 layer
and passing the same to low level driver can inform the low level drive=
r.
whether current ops is shutdown or a suspend.

Also, looking into the struct uart_ops.

struct uart_ops {
=2E
=2E
        int             (*set_wake)(struct uart_port *, unsigned int st=
ate);
=2E
=2E
};

Unfortunately set wake is not being used in serial_core.c
So this uart ops can be used to enable wakeups
when port is opened and disable wakeups when port
is closed.

If set_wake is not supposed to be used in this manner I
will fall back to option1 to use state variable for shutdown ops.

tmp patch as in here[1] to use set_wake.

--
Thanks,
Govindraj.R

[1]:

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
index 9c4c05b..c176ff2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1426,6 +1426,9 @@ static void uart_port_shutdown(struct tty_port *p=
ort)
 	 */
 	uport->ops->shutdown(uport);

+	if (uport->ops->set_wake)
+		uport->ops->set_wake(uport, false);
+
 	/*
 	 * Ensure that the IRQ handler isn't running on another CPU.
 	 */
@@ -1512,6 +1515,9 @@ static int uart_open(struct tty_struct *tty,
struct file *filp)
 		goto err_dec_count;
 	}

+	if (uport->ops->set_wake)
+		uport->ops->set_wake(uport, true);
+
 	/*
 	 * Make sure the device is in D0 state.
 	 */
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
