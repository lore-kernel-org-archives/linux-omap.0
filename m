From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC][PATCH]: Adding support for omap-serail driver
Date: Wed, 2 Sep 2009 14:10:50 +0530
Message-ID: <d6a0f7aa0909020140r46136dddgbfba29606e750a36@mail.gmail.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F9A4570A@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F9AF18CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9AF18CF@dbde02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Vikram,


> What about UART3 supporting IRDA and CIR modes?
> Is that planned to be added?
>

We do have an driver to support IrDA -- > drivers/net/irda/omap-ir.c


>>+static unsigned int check_modem_status(struct uart_omap_port *up)
>
> What is the use case for modem_status?

This is basically used to handle any change in uart line[cts,dcd],
like an change in status of cts line should be handled
which is done using the function by checking the MSR[modem status regis=
ter].

>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (jiffies_to_msecs(jiffies - up_activi=
ty) < 10000) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mod_timer(&up->uart_dma.=
rx_timer, jiffies +
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usecs_to=
_jiffies(up->uart_dma.rx_timeout));
>
> Is this a 10 second timeout? Is this acceptable way?
> This has to be done in conjunction with the inactivity timer in mach-=
omap2/serial.c

This timeout is the period where we except some activity on rx line as
we dont the time period we receive data hence we keep rx dma channel
active for minimum of 10 secs, however this can be reduced.


-----
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
