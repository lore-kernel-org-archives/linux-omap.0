From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH v5 01/58] mtd: nand: denali: add missing nand_release()
 call in denali_remove()
Date: Fri, 11 Dec 2015 10:50:21 -0600
Message-ID: <CADhT+wcNFxD6Zv9w8W0sontVWa6zOkHjyK42Tw=Y_1X2XCTZfQ@mail.gmail.com>
References: <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
	<1449842554-29898-1-git-send-email-boris.brezillon@free-electrons.com>
	<20151211161008.056a0f47@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20151211161008.056a0f47@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Stefan Agner <stefan@agner.ch>, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-samsung-soc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electr>
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On Fri, Dec 11, 2015 at 9:10 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> + Dinh (who made commit 2a0a288ec258)
>
> Also added back the Fixes tag.
>
> On Fri, 11 Dec 2015 15:02:34 +0100
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>
>> Unregister the NAND device from the NAND subsystem when removing a denali
>> NAND controller, otherwise the MTD attached to the NAND device is still
>> exposed by the MTD layer, and accesses to this device will likely crash
>> the system.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> Fixes: 2a0a288ec258 ("mtd: denali: split the generic driver and PCI layer")
>
>> ---
>> Changes since v4:
>> - remove Cc stable and fixes tags
>> - calculate the dma buffer size before calling nand_release()
>>
>>  drivers/mtd/nand/denali.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
>> index 67eb2be..fdfea05 100644
>> --- a/drivers/mtd/nand/denali.c
>> +++ b/drivers/mtd/nand/denali.c
>> @@ -1622,9 +1622,11 @@ EXPORT_SYMBOL(denali_init);
>>  /* driver exit point */
>>  void denali_remove(struct denali_nand_info *denali)
>>  {
>> +     int bufsize = denali->mtd.writesize + denali->mtd.oobsize;
>> +
>> +     nand_release(&denali->mtd);
>>       denali_irq_cleanup(denali->irq, denali);
>> -     dma_unmap_single(denali->dev, denali->buf.dma_buf,
>> -                      denali->mtd.writesize + denali->mtd.oobsize,
>> +     dma_unmap_single(denali->dev, denali->buf.dma_buf, bufsize,
>>                        DMA_BIDIRECTIONAL);

Not sure what is the need to add bufsize here, but the commit message
doesn't reflect the change.

Dinh
