From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/3] serial: 8250_omap: check how many bytes were injected
Date: Wed, 26 Aug 2015 18:31:18 +0530
Message-ID: <55DDB89E.4000802@ti.com>
References: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de> <1439568064-7907-2-git-send-email-bigeasy@linutronix.de> <55DDB4C7.5070709@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DDB4C7.5070709@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 26 August 2015 06:14 PM, Peter Hurley wrote:
> On 08/14/2015 12:01 PM, Sebastian Andrzej Siewior wrote:
>> The function tty_insert_flip_string() returns an int and as such it
>> might fail. So the result is that I kindly asked to insert 48 bytes and
>> the function only insterted 32.
>> I have no idea what to do with the remaining 16 so I think dropping them
>> is the only option. I also increase the buf_overrun counter so userpace
>> has a clue that we lost bytes.
> 
> No objection to the patch but I'm curious whether this is something you've
> actually observed and under what circumstances.

This was observed while doing a UART internal loopback test at 3Mbaud on
TI's DRA7 EVM.

Thanks,
Sekhar
