From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Fri, 13 Nov 2015 17:05:33 +0100
Message-ID: <56460A4D.30303@atmel.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
 <20151110232341.GU12143@google.com> <5642E546.3040806@ti.com>
 <20151111072041.GA13174@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151111072041.GA13174@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Brian,

Le 11/11/2015 08:20, Brian Norris a =E9crit :
> Hi,
>=20
> On Wed, Nov 11, 2015 at 12:20:46PM +0530, R, Vignesh wrote:
>> On 11/11/2015 4:53 AM, Brian Norris wrote:
>>> On Tue, Nov 10, 2015 at 10:59:55AM +0530, Vignesh R wrote:
>>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>>>> index cce80e6dc7d1..2f2c431b8917 100644Hi
>>>> --- a/include/linux/spi/spi.h
>>>> +++ b/include/linux/spi/spi.h
>>>> @@ -361,6 +361,11 @@ static inline void spi_unregister_driver(stru=
ct spi_driver *sdrv)
>>>>   * @handle_err: the subsystem calls the driver to handle an error=
 that occurs
>>>>   *		in the generic implementation of transfer_one_message().
>>>>   * @unprepare_message: undo any work done by prepare_message().
>>>> + * @spi_mtd_mmap_read: some spi-controller hardwares provide memo=
ry.
>>>> + *                     Flash drivers (like m25p80) can request me=
mory
>>>> + *                     mapped read via this method. This interfac=
e
>>>> + *                     should only be used by mtd flashes and can=
not be
>>>> + *                     used by other spi devices.
>>>>   * @cs_gpios: Array of GPIOs to use as chip select lines; one per=
 CS
>>>>   *	number. Any individual value may be -ENOENT for CS lines that
>>>>   *	are not GPIOs (driven by the SPI controller itself).
>>>> @@ -507,6 +512,11 @@ struct spi_master {
>>>>  			       struct spi_message *message);
>>>>  	int (*unprepare_message)(struct spi_master *master,
>>>>  				 struct spi_message *message);
>>>> +	int (*spi_mtd_mmap_read)(struct  spi_device *spi,
>>>> +				 loff_t from, size_t len,
>>>> +				 size_t *retlen, u_char *buf,
>>>> +				 u8 read_opcode, u8 addr_width,
>>>> +				 u8 dummy_bytes);
>>>
>>> Is this API really sufficient? There are actually quite a few other
>>> flash-related parameters that might be relevant to a controller. I
>>> presume you happen not hit them because of the particular cases you=
're
>>> using this for right now, but:
>>>
>>>  * How many I/O lines are being used? These can vary depending on t=
he
>>>    type of flash and the number of I/O lines supported by the contr=
oller
>>>    and connected on the board.
>>>
>>
>> This API communicates whatever data is currently communicated via
>> spi_message through spi_sync/transfer_one interfaces.
>=20
> No it doesn't. A spi_message consists of a list of spi_transfer's, an=
d
> each spi_transfer has tx_nbits and rx_nbits fields.
>=20
>>>  * The previous point can vary across parts of the message. There a=
re
>>>    various combinations of 1/2/4 lines used for opcode/address/data=
=2E We
>>>    only support a few of those combinations in m25p80 right now, bu=
t
>>>    you're not specifying any of that in this API. I guess you're ju=
st
>>>    making assumptions? (BTW, I think there are others having proble=
ms
>>>    with the difference between different "quad" modes on Micron fla=
sh; I
>>>    haven't sorted through all the discussion there.)
>>>
>>
>> How is the spi controller currently being made aware of this via
>> m25p80_read / spi_sync() interface? AFAIK, mode field of spi_device
>> struct tell whether to do normal/dual/quad read but there is no info
>> communicated wrt 1/2/4 opcode/address/data combinations.
>=20
> Yes there is. m25p80 fills out spi_transfer::rx_nbits. Currently, we
> only use this for the data portion, but it's possible to support more
> lines for the address and opcode portions too, using the rx_nbits for
> the opcode and address spi_transfer struct(s) (currently, m25p80_read=
()
> uses 2 spi_transfers per message, where the first one contains opcode=
 +
> address + dummy on a single line, and the second transfer receives th=
e
> data on 1, 2, or 4 lines).
>=20

In September I've sent a series of patches to enhance the support of QS=
PI flash
memories. Patch 4 was dedicated to the m25p80 driver and set the
rx_nbits / tx_nbits fields of spi_transfer struct(s) in order to config=
ure the
number of I/O lines independently for the opcode, address and data part=
s.
The work was done for m25p80_read() but also for _read_reg(), _write_re=
g() and
_write().
The patched m25p80 driver was then tested with an at25 memory to check =
non-
regression.

This series of patches also added 4 enum spi_protocol fields inside str=
uct
spi_nor so the spi-nor framework can tell the (Q)SPI controller driver =
what SPI
protocol should be use for erase, read, write and register read/write
operations, depending on the memory manufacturer and the command opcode=
=2E
This was done to better support Micron, Spansion and Macronix QSPI memo=
ries.

I have tested the series with Micron QSPI memories and Atmel QSPI contr=
oller
and I guess Marek also tested it on his side with Spansion QSPI memorie=
s and
another QSPI controller.

So if it can help other developers to develop QSPI controller drivers, =
the
series is still available there:

for the whole series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/37=
1170.html

for patch 4 (depends on patch 2 for enum spi_protocol):
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/37=
1173.html

Best Regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
