From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: serial_core: Add mechanism to identify port
 closure.
Date: Fri, 20 Apr 2012 14:27:40 +0100
Message-ID: <20120420142740.053b9981@pyramind.ukuu.org.uk>
References: <1334919473-18870-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1334919473-18870-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9c4c05b..0dc246d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1284,6 +1284,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>  		uart_wait_until_sent(tty, uport->timeout);
>  	}
>  
> +	state->uart_port->closing = true;

So what are the locking rules for this - when is it valid and when can it
be tested.

This also still seems a hack to me - the core tty code doesn't have
suspend/resume/open/close confused. The uart layer does, so really the
uart layer needs untangling. I'm skeptical yet another magic state
variable is the answer, particularly when the locking model for the
variable appears undefined.

Teach the uart core code to pass an extra argument indicating whether its
really doing shutdown/open or merely doing suspend/resume. It's perfectly
sensible that it tries to use the same helper for both, its broken that
the called code cannot tell which.

The parameter would also be a local variable which avoids all the locking
questions.

Alan
