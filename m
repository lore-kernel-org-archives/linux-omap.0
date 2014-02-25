From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/2] mfd: twl6040: Small clean-ups
Date: Tue, 25 Feb 2014 15:31:04 +0100
Message-ID: <530CA928.7000707@epfl.ch>
References: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch> <530CA6BA.1000405@ti.com> <20140225142705.GC9195@lee--X1>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140225142705.GC9195@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 02/25/2014 03:27 PM, Lee Jones wrote:
>>> Here is two cleanups patches for the TWL6040 audio codec. The first
>>> one checks for an error when reading the revision register (first read
>>> in the probe path). The second removes a duplicate I2C writes.
>>>
>>> Regards,
>>> Florian
>>
>> To both:
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Applied both with Peter's Ack.
> 

Thanks!

Florian
