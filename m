From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Tue, 25 Nov 2014 19:05:04 +0100
Message-ID: <5474C4D0.1060908@linutronix.de>
References: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de> <545BC8C1.4070503@ti.com> <545BCF3F.8020705@linutronix.de> <CAGo_u6qTqp1Wpo8E26gLpStu_EiRw32gstkCiXw+EWNDWSnHbw@mail.gmail.com> <20141106203544.GE31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20141106203544.GE31454@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On 11/06/2014 09:35 PM, Tony Lindgren wrote:
> The pinctrl change in this patch and the wake-up events are a separate
> issue.

So this patch can go in and wake-up issue will be fixed once the
infrastructure is there. No misunderstanding here?

> Tony
> 

Sebastian
