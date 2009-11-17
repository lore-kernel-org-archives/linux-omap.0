From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/2] serial: 8250: add UPF_NO_EMPTY_FIFO_READ flag
Date: Wed, 18 Nov 2009 03:08:40 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA689EB4@dbde02.ent.ti.com>
References: <1258492615-15963-1-git-send-email-vikram.pandita@ti.com>
 <20091117212547.0a81fa46@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20091117212547.0a81fa46@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org



>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Tuesday, November 17, 2009 3:26 PM
>To: Pandita, Vikram
>Cc: linux-serial@vger.kernel.org; akpm@linux-foundation.org; linux-omap@vger.kernel.org; Pandita,
>Vikram; Shilimkar, Santosh
>Subject: Re: [PATCH 1/2] serial: 8250: add UPF_NO_EMPTY_FIFO_READ flag
>
>On Tue, 17 Nov 2009 15:16:55 -0600
>Vikram Pandita <vikram.pandita@ti.com> wrote:
>
>> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
>> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.
>
>Nothing wrong with the requirement but I think it would keep 8250.c a lot
>cleaner if you implemented that in the serial_in method for the
>OMAP3630/4430. It would also mean anyone adding a UART_RX or any cases
>you miss don't break in future

Agree. Was contemplating this change in beginning, but lost that train of thought.
Thx for your review time.

>
>This is especially true now as you can pass a private
>serial_in/serial_out method in the port register function.

Our requirement is to over-right the serial_in for now.
Is it fine to just add serial_in over-load or do you suggest both in/out?

>
>Care to submit an alternate patch doing it that way, or see any reason
>for not ?

Working on it right away. See my patch in an hours time.

>
>Alan

