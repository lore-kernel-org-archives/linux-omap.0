From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Thu, 11 Sep 2014 18:04:32 +0200
Message-ID: <5411C810.7070906@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de> <20140911151114.GD28458@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140911151114.GD28458@ci00147.xsens-tech.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 09/11/2014 05:11 PM, Frans Klaver wrote:

> I can still reproduce it on am335x. I can get out of it as soon as
> something else gets written to the console though.
> 
> # echo "<3>something" >/dev/kmsg

Is this to stall it or to get out of it?

> 
> Frans

Sebastian
