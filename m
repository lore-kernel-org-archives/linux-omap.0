From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Thu, 25 Sep 2014 11:24:46 +0200
Message-ID: <20140925092446.GC19396@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300>
 <54118AAB.2010205@linutronix.de>
 <5419B825.5000201@linutronix.de>
 <20140919102212.GA31784@xps8300>
 <541C0C64.5010206@linutronix.de>
 <20140922074605.GB26114@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140922074605.GB26114@xps8300>
Sender: linux-serial-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

* Heikki Krogerus | 2014-09-22 10:46:05 [+0300]:

>Well, there are no other SoCs at the moment that would need it, and
>it's actually possible that there never will be. So yes, just handle
>that also in the omap specific code.

Okay. So let me move the irq routine and the workarounds into omap then.

>Thanks,
>

Sebastian
