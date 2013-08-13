From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: [PATCH v2] serial: OMAP: add RS485 support
Date: Tue, 13 Aug 2013 12:07:01 +0100
Message-ID: <520A1355.1050301@newflow.co.uk>
References: <52079822.9020103@newflow.co.uk> <20130812225638.GA30919@kroah.com> <520A08FE.5070804@newflow.co.uk> <CAAwP0s1QyNjQb+0zhK_UeHraTW+R6Mefq1E4HyV-XJ4fV42w+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAwP0s1QyNjQb+0zhK_UeHraTW+R6Mefq1E4HyV-XJ4fV42w+g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, jslaby@suse.cz
List-Id: linux-omap@vger.kernel.org

On 13/08/13 11:54, Javier Martinez Canillas wrote:

<snip>

> 
> Hi Mark,
> 
> I've seen several attempts to add RS485 support to the omap serial
> driver and it is always nack-ed. There seems to be concerns about
> controlling the RTS by software when RS485 is not supported by the
> UART hardware. Please refer to [1] and [2] for more information.

Hmmmm ... okay, I guess I'll just have to maintain our own code (as
did the OP in [1]).

Thanks for the info.
