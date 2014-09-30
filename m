From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] regmap: Allow read_reg_mask to be 0
Date: Tue, 30 Sep 2014 23:29:34 +0200
Message-ID: <542B20BE.3060200@metafoo.de>
References: <1412093220-24690-1-git-send-email-dmurphy@ti.com> <542B1ABE.5000900@metafoo.de> <542B1E38.4020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <542B1E38.4020702@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, broonie@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/30/2014 11:18 PM, Dan Murphy wrote:
> Lars
>
> On 09/30/2014 04:03 PM, Lars-Peter Clausen wrote:
>> On 09/30/2014 06:07 PM, Dan Murphy wrote:
>>> There may be spi devices that do not require a
>>> register read mask to read the registers.
>>>
>>> Currently the code sets the read mask based on
>>> a non-zero value passed in from the driver or if that
>>> value is 0 sets the read mask to 0x80.
>>
>> It only sets it to the bus default if both read_flag_mask and write_flag_mask are 0. The assumption is that both of them being zero is a invalid configuration and either of them (or both) have to be non-zero for proper operation, since otherwise the device can't tell the difference between a read and a write.
>>
>> Do you have a device where both the read and the write mask is 0?
>>
>> - Lars
>
> Yes I do have a device that the read/write mask are both 0.
>
> The device, which is already in production, has a specific control register that sets either the reading or writing of the rest of the registers.
>
> Here is the data sheet
>
> http://www.ti.com/lit/ds/symlink/afe4403.pdf
>
> See page 61 control0.
>
> Driver is written for this part just want to get this lead patch in or maybe an alternate solution.

Looking at this the generic SPI regmap implementation might not necessarily 
be the best thing to use here and you are probably better of implementing 
either your own regmap bus or reg_read/reg_write callbacks that 
automatically set/clear the SPI_READ bit in the control register depending 
on the operation.

- Lars
