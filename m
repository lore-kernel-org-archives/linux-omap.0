From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround for AM33xx
Date: Thu, 11 Sep 2014 19:04:03 +0200
Message-ID: <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de> <20140911151114.GD28458@ci00147.xsens-tech.local> <5411C810.7070906@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5411C810.7070906@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Frans Klaver <frans.klaver@xsens.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 11 September 2014 18:04:32 CEST, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>On 09/11/2014 05:11 PM, Frans Klaver wrote:
>
>> I can still reproduce it on am335x. I can get out of it as soon as
>> something else gets written to the console though.
>> 
>> # echo "<3>something" >/dev/kmsg
>
>Is this to stall it or to get out of it?

This is to get out of it. I do this from an ssh connection after the console got stuck. The 3 kind of ensures the message is actually sent to ttyS0.


>
>> 
>> Frans
>
>Sebastian
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
