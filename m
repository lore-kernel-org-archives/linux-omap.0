From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: (v4.4/v4.5)-stable-queue build and qemu failures
 (arm:allmodconfig, arm:pxa_defconfig, arm:omap2plus_defconfig)
Date: Tue, 3 May 2016 06:53:47 -0700
Message-ID: <5728AD6B.5020106@roeck-us.net>
References: <20160429201914.GA27596@roeck-us.net>
 <CAHCN7xJ0vS9GHWmg__z5SQtHKfdCDGKD6m0_=zewbY65Jyf9PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xJ0vS9GHWmg__z5SQtHKfdCDGKD6m0_=zewbY65Jyf9PA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/03/2016 06:35 AM, Adam Ford wrote:
> On Fri, Apr 29, 2016 at 3:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> v4.4 (arm:allmodconfig):
>>
>> drivers/mtd/nand/pxa3xx_nand.c: In function 'alloc_nand_resource':
>> drivers/mtd/nand/pxa3xx_nand.c:1753:7: error: 'np' undeclared
>>
>> v4.5 (arm:allmodconfig, arm:pxa_defconfig):
>>
>> drivers/dma/pxa_dma.c: In function 'pxad_probe':
>> drivers/dma/pxa_dma.c:1421:24: error: 'struct mmp_dma_platdata' has no member named 'nb_requestors'
>>
>> There is also a qemu runtime failure with omap2plus_defconfig in v4.4.
>>
>> [    2.412322] omap_i2c 48070000.i2c: bus 0 rev3.3 at 2600 kHz
>> [    2.417541] omap_i2c 48060000.i2c: bus 2 rev3.3 at 100 kHz
>> [    2.429443]
>> [    2.429534] =====================================
>> [    2.429718] [ BUG: bad unlock balance detected! ]
>> [    2.429962] 4.4.8-00025-gcd58757 #1 Not tainted
>> [    2.430145] -------------------------------------
>> [    2.430328] kworker/u2:0/6 is trying to release lock (&rdev->mutex) at:
>> [    2.430694] [<c03b40e4>] regulator_set_voltage+0x40/0x54
>> [    2.430877] but there are no more locks to release!
>>
>
> I am also seeing this in 4.4.8 on an DM3730.  I didn't see it in
> 4.4.3.  I can also help bisect if it helps.
> -adam
>

I ended up bisecting it [1]. The problem is seen in 4.4.7 and 4.4.8
(I originally thought 4.4.6 was affected as well, but it was introduced
in 4.4.7). It will be fixed in 4.4.9; the necessary patches are already
in the queue.

Guenter

---
[1] http://thread.gmane.org/gmane.linux.kernel.stable/176811
