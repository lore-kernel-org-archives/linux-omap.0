From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by default
Date: Thu, 19 Apr 2012 20:00:12 +0530
Message-ID: <CAMrsUdJ_ewe1td9nOO+0ociP4O_tyPgjH=w11r_mFW_yc7PDAQ@mail.gmail.com>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
 <87vckyq6ti.fsf@ti.com> <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
 <87mx69nms2.fsf@ti.com> <20120418200833.24ef25ff@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120418200833.24ef25ff@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 19, 2012 at 12:38 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> The point is that wakeups should be enabled whenever driver is in use,
>> and disabled when the driver is not in use.
>
>
> Which is the tty_port methods for initialisation and shutdown, which are
> mutex protected against each other and hang up.
>
> Not sure how the uart layer glue exposes that.

Is it okay to read the port flags to identify the port state in
driver whether the serial port shutdown ops is called from
port_suspend or due to port closure.

Since port_shutdown gets called even from uart_suspend_port

Is things like

test_bit(ASYNCB_SUSPENDED, &port->flags);
or
test_bit(ASYNCB_CLOSING, &port->flags);

allowed in low level driver ?

--
Thanks,
Govindraj.R
