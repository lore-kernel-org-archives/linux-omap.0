From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/3] serial: 8250_omap: check how many bytes were injected
Date: Wed, 26 Aug 2015 15:08:01 +0530
Message-ID: <55DD88F9.6010003@ti.com>
References: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de> <1439568064-7907-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439568064-7907-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, peter@hurleysoftware.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Friday 14 August 2015 09:31 PM, Sebastian Andrzej Siewior wrote:
> The function tty_insert_flip_string() returns an int and as such it
> might fail. So the result is that I kindly asked to insert 48 bytes and
> the function only insterted 32.
> I have no idea what to do with the remaining 16 so I think dropping them
> is the only option. I also increase the buf_overrun counter so userpace
> has a clue that we lost bytes.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Tested with wilink BT module on TI's DRA7 EVM.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
