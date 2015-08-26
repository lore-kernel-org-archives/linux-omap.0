From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/3] serial: 8250: move rx_running out of the bitfield
Date: Wed, 26 Aug 2015 18:28:13 +0530
Message-ID: <55DDB7E5.6090604@ti.com>
References: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de> <55DD88E2.3000401@ti.com> <55DDB48B.80701@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DDB48B.80701@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 26 August 2015 06:13 PM, Peter Hurley wrote:
> On 08/26/2015 05:37 AM, Sekhar Nori wrote:
>> On Friday 14 August 2015 09:31 PM, Sebastian Andrzej Siewior wrote:
>>> From: John Ogness <john.ogness@linutronix.de>
>>>
>>> That bitfield is modified by read + or + write operation. If someone
>>> sets any of the other two bits it might render the lock useless.
>>>
>>> While at it, remove other bitfields as well to avoid more such
>>> errors.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Tested with wilink BT module on TI's DRA7 EVM.
>>
>> Tested-by: Sekhar Nori <nsekhar@ti.com>
> 
> Already in Greg's tty-next tree (and 4.3-rc1 pull request), Sekhar.

Oops, no problem. Did not notice that.

Thanks,
Sekhar
