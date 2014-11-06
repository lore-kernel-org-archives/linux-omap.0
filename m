From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Thu, 06 Nov 2014 20:42:55 +0100
Message-ID: <545BCF3F.8020705@linutronix.de>
References: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de> <545BC8C1.4070503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <545BC8C1.4070503@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-serial@vger.kernel.org, "tony@atomide.com" <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On 11/06/2014 08:15 PM, Nishanth Menon wrote:
> sounds good to me *IF* omap8250_enable_wakeup (wakeirq handling) is
> the way we want to continue doing things for daisychain? -> Tony, can
> you comment?
> http://marc.info/?l=linux-omap&m=141222144402707&w=2
> 
> I wonder if wakeirq explicit handling is valid anymore and something
> given the potential race and alternate approach proposed?

The wakeirq logic is already in the driver. So if we go for the
alternate approach, the pinctrl patch is obsolete? Or does it mean we
get rid of the map8250_enable_wakeup() including the second irq we have
now (and keep the pinctl change)?

Sebastian
