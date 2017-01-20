From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] tty: serial: 8250_omap: Enable DMA support
Date: Fri, 20 Jan 2017 13:52:47 +0530
Message-ID: <9b8ae62f-5676-aa81-97cb-396de80fff7a@ti.com>
References: <20170113080201.6515-1-vigneshr@ti.com>
 <20170113182021.GD2630@atomide.com> <20170119132448.GC29998@kroah.com>
 <20170119145423.GQ7403@atomide.com> <20170119153549.GA10560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170119153549.GA10560@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Thursday 19 January 2017 09:05 PM, Greg Kroah-Hartman wrote:
> On Thu, Jan 19, 2017 at 06:54:23AM -0800, Tony Lindgren wrote:
>> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [170119 05:25]:
>>> On Fri, Jan 13, 2017 at 10:20:21AM -0800, Tony Lindgren wrote:
>>>> * Vignesh R <vigneshr@ti.com> [170113 00:03]:
>>>>> This patch series re enables DMA support for UART 8250_omap driver.
>>>>>
>>>>> Tested on AM335x, AM437x that use EDMA and OMAP5 and DRA74 EVM with
>>>>> SDMA.
>>>>
>>>> Is 8250_omap serial console working for you on omap5 in general?
>>>>
>>>> I've noticed that it's really unresponsive for me as if the FIFO
>>>> interrupt was not working. For example logging in might take several
>>>> attempts and a long time with each character showing up much later
>>>> after some timeout.
>>>>
>>>> TX on the uart on omap5 seems to work OK, I do see all the console
>>>> messages fine. And these patches do not make the issue better or
>>>> worse.
>>>
>>> Ok, I'm dropping them from my review queue then.
>>
>> It turned out to be not related to this set of patches, Vignesh
>> posted a fix for it. For this set:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Ugh, these are now gone from my queue, can someone resend them with this
> acked-by added?
> 

I have resent this series with the Ack:
http://marc.info/?l=linux-serial&m=148490028003788&w=2

-- 
Regards
Vignesh
