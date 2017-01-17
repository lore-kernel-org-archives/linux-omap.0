From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] tty: serial: 8250_omap: Enable DMA support
Date: Tue, 17 Jan 2017 15:35:28 +0530
Message-ID: <f978273d-39eb-e5d7-a95e-4a2e4be9e23c@ti.com>
References: <20170113080201.6515-1-vigneshr@ti.com>
 <20170113182021.GD2630@atomide.com>
 <b27b95a9-40b8-ebef-3457-ce87db6b26e5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b27b95a9-40b8-ebef-3457-ce87db6b26e5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Tuesday 17 January 2017 11:36 AM, Vignesh R wrote:
> 
> 
> On Friday 13 January 2017 11:50 PM, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [170113 00:03]:
>>> This patch series re enables DMA support for UART 8250_omap driver.
>>>
>>> Tested on AM335x, AM437x that use EDMA and OMAP5 and DRA74 EVM with
>>> SDMA.
>>
>> Is 8250_omap serial console working for you on omap5 in general?
>>
>> I've noticed that it's really unresponsive for me as if the FIFO
>> interrupt was not working. For example logging in might take several
>> attempts and a long time with each character showing up much later
>> after some timeout.
>>
> 
> Yes, I did face the same issue on omap5 using 8250_omap driver for
> console. Looks like this bug has existed all along.
> 

This looks a separate issue, I don't see any errata specific errata wrt
UART on OMAP5. I will try to debug further.

-- 
Regards
Vignesh
