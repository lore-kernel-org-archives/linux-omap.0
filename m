From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 11 Nov 2015 12:20:46 +0530
Message-ID: <5642E546.3040806@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
 <20151110232341.GU12143@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151110232341.GU12143@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Brain,

On 11/11/2015 4:53 AM, Brian Norris wrote:
> Hi Vignesh,
> 
> Sorry for the late review. I did not have time to review much back when
> you submitted your first RFCs for this.
> 
> On Tue, Nov 10, 2015 at 10:59:55AM +0530, Vignesh R wrote:
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index cce80e6dc7d1..2f2c431b8917 100644Hi
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -361,6 +361,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
>>   * @handle_err: the subsystem calls the driver to handle an error that occurs
>>   *		in the generic implementation of transfer_one_message().
>>   * @unprepare_message: undo any work done by prepare_message().
>> + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory.
>> + *                     Flash drivers (like m25p80) can request memory
>> + *                     mapped read via this method. This interface
>> + *                     should only be used by mtd flashes and cannot be
>> + *                     used by other spi devices.
>>   * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
>>   *	number. Any individual value may be -ENOENT for CS lines that
>>   *	are not GPIOs (driven by the SPI controller itself).
>> @@ -507,6 +512,11 @@ struct spi_master {
>>  			       struct spi_message *message);
>>  	int (*unprepare_message)(struct spi_master *master,
>>  				 struct spi_message *message);
>> +	int (*spi_mtd_mmap_read)(struct  spi_device *spi,
>> +				 loff_t from, size_t len,
>> +				 size_t *retlen, u_char *buf,
>> +				 u8 read_opcode, u8 addr_width,
>> +				 u8 dummy_bytes);
> 
> Is this API really sufficient? There are actually quite a few other
> flash-related parameters that might be relevant to a controller. I
> presume you happen not hit them because of the particular cases you're
> using this for right now, but:
> 
>  * How many I/O lines are being used? These can vary depending on the
>    type of flash and the number of I/O lines supported by the controller
>    and connected on the board.
> 

This API communicates whatever data is currently communicated via
spi_message through spi_sync/transfer_one interfaces.

>  * The previous point can vary across parts of the message. There are
>    various combinations of 1/2/4 lines used for opcode/address/data. We
>    only support a few of those combinations in m25p80 right now, but
>    you're not specifying any of that in this API. I guess you're just
>    making assumptions? (BTW, I think there are others having problems
>    with the difference between different "quad" modes on Micron flash; I
>    haven't sorted through all the discussion there.)
> 

How is the spi controller currently being made aware of this via
m25p80_read / spi_sync() interface? AFAIK, mode field of spi_device
struct tell whether to do normal/dual/quad read but there is no info
communicated wrt 1/2/4 opcode/address/data combinations. And there is no
info indicating capabilities of spi-master wrt no of IO lines for
opcode/address/data that it can support.

>    There are typically both flash device and SPI controller constraints
>    on this question, so there needs to be some kind of negotiation
>    involved, I expect. Or at least, the SPI master needs to expose which
>    modes it can support with this flash-read API.
> 

If spi-master capabilities are known then spi_mmap_read_supported() (or
a new function perhaps) can be used for negotiation. These capabilities
can be added incrementally once ability to specify spi-master
capabilities are in place.

> Also, this API doesn't actually have anything to do with memory mapping.
> It has to do with the de facto standard flash protocol. So I don't think
> mmap belongs in the name; it should be something about flash. (I know of
> at least one other controller that could probably use this API, excpet
> it doesn't use memory mapping to accomplish the accelerated flash read.)
> 

As far as TI QSPI controller is concerned, the accelerated read happens
via mmap port whereby a predefined memory address space of SoC is
exposed as QSPI mmap region. This region can be accessed like normal
RAM(via memcpy()) and the QSPI controller interface takes care of
fetching data from flash on SPI bus automatically hence, I named it as
above. But, I have no hard feelings if it needs to be generalized to
spi_mtd_read() or something else.

Regards
Vignesh
