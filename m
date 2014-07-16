From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/6] tty: serial: 8250 core: provide a function to export
 uart_8250_port
Date: Wed, 16 Jul 2014 10:22:26 +0200
Message-ID: <53C63642.7080208@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>	<1404928177-26554-2-git-send-email-bigeasy@linutronix.de> <CAMFK0gtLHrYzWipw=9rp-cUZrKkzBAn_iXSetn016F7zvuZE0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMFK0gtLHrYzWipw=9rp-cUZrKkzBAn_iXSetn016F7zvuZE0w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/10/2014 04:30 PM, Olivier Galibert wrote:
> On Wed, Jul 9, 2014 at 7:49 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> + * The lock assumption made here is none because runtime-pm suspend/resume
>> + * callbacks should not be invoked there is any operation performed on the port.
> 
> I think there's a missing "if"?

Thanks, fixed up.

> Best,
> 
>   OG.
> 

Sebastian
