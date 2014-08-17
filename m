From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v7] 8250-core based serial driver for OMAP + DMA
Date: Sun, 17 Aug 2014 22:35:12 +0200
Message-ID: <20140817203512.GA24330@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <20140815181704.GH17769@csclub.uwaterloo.ca>
 <53EE5BF8.3010007@linutronix.de>
 <20140815202826.GC9239@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140815202826.GC9239@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren | 2014-08-15 13:28:27 [-0700]:

>> It configured the trigger levels to 1 for RX and 16 for TX.
>
>Hmm that weird RX trigger level is a workaround for lost characters.
>
>See commit 0ba5f66836 (tty: serial: OMAP: use a 1-byte RX FIFO
>threshold in PIO mode :)
>
>There's paste test in that commit, I wonder if the 8250 drivers
>can deal with it any better?

I recall that I used it as a console and didn't see any missing chars.
I will try test but I am traveling this week=E2=80=A6

>Regards,
>
>Tony

Sebastian
