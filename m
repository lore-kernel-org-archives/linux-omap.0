From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/5] mtd: devices: m25p80: add support for mmap read
 request
Date: Thu, 3 Dec 2015 16:53:40 +0530
Message-ID: <5660263C.8020406@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-4-git-send-email-vigneshr@ti.com>
 <56600E7B.8010208@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56600E7B.8010208@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, hramrach@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>
List-Id: linux-omap@vger.kernel.org

Hi,

On 12/03/2015 03:12 PM, Cyrille Pitchen wrote:
> Hi Vignesh,
>=20
> Le 30/11/2015 06:15, Vignesh R a =E9crit :
>> Certain spi controllers may provide accelerated interface to read fr=
om
>> m25p80 type flash devices. This interface provides better read
>> performance than regular SPI interface.
>> Call spi_flash_read(), if supported, to make use of such interface.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> v4:=20
>>  * Use spi_flash_read_message struct to pass args.
>>  * support passing of opcode/addr/data nbits.
>>
>>  drivers/mtd/devices/m25p80.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p=
80.c
>> index fe9ceb7b5405..00094a668c62 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -131,6 +131,26 @@ static int m25p80_read(struct spi_nor *nor, lof=
f_t from, size_t len,
>>  	/* convert the dummy cycles to the number of bytes */
>>  	dummy /=3D 8;
>> =20
>> +	if (spi_flash_read_supported(spi)) {
>> +		struct spi_flash_read_message msg;
>> +		int ret;
>> +
>> +		msg.buf =3D buf;
>> +		msg.from =3D from;
>> +		msg.len =3D len;
>> +		msg.read_opcode =3D nor->read_opcode;
>> +		msg.addr_width =3D nor->addr_width;
>> +		msg.dummy_bytes =3D dummy;
>> +		/* TODO: Support other combinations */
>> +		msg.opcode_nbits =3D SPI_NBITS_SINGLE;
>> +		msg.addr_nbits =3D SPI_NBITS_SINGLE;
>> +		msg.data_nbits =3D m25p80_rx_nbits(nor);
>=20
> I wanted to let you know that the support of other SPI protocols has =
already
> been implemented by this series:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/=
371170.html
>=20
> patches 2 & 3 handle the probing of the (Q)SPI memory in spi_nor_scan=
() and
> select the right protocols for register read/write, memory read, memo=
ry write,
> and memory erase operations. The choice is done according to both the=
 memory
> and SPI controller capabilities.
>=20
> patch 4 updates the m25p80 driver to take advantage of the bandwidth =
increase
> allowed by QSPI protocols. For instance, the Atmel QSPI controller, l=
ike TI
> one, maps the SPI NOR memory to the system bus. Yesterday I ran mtd_s=
peedtest
> to compare Fast Read 1-1-1 (0x0b) and Fast Read 1-1-4 (0x6b). The SPI=
 clock
> frequency was limited to 83MHz. The QSPI memory is a Micron n25q128a1=
3.
>=20
> I only had to change the mode argument of spi_nor_scan() from SPI_NOR=
_QUAD to
> SPI_NOR_FAST in the atmel_quadspi driver (based on fsl-quadspi driver=
 from
> Freescale since Atmel's driver also uses the system bus mapping for m=
emory
> write operations) to force the spi-nor framework to choose the SPI 1-=
1-1
> protocol instead of the SPI-1-1-4.
>=20
> 1 - Fast Read 1-1-1
>=20
> mtd_speedtest: testing eraseblock write speed
> mtd_speedtest: eraseblock read speed is 9319 KiB/s
> [...]
> mtd_speedtest: testing page read speed
> mtd_speedtest: page read speed is 6649 KiB/s
> [...]
> mtd_speedtest: testing 2 page read speed
> mtd_speedtest: 2 page read speed is 7757 KiB/s
>=20
> 2 - Fast Read 1-1-4
>=20
> mtd_speedtest: testing eraseblock read speed
> mtd_speedtest: eraseblock read speed is 30117 KiB/s
> [...]
> mtd_speedtest: testing page read speed
> mtd_speedtest: page read speed is 13096 KiB/s
> [...]
> mtd_speedtest: testing 2 page read speed
> mtd_speedtest: 2 page read speed is 18224 KiB/s
>=20
> So the performance improvements are:
> eraseblock read speed (65536 bytes) : +223%
> page read speed (512 bytes)         :  +97%
> 2 page read speed (1024 bytes)      : +135%
>=20
>=20
> That's why I believe that you could take advantage of these performan=
ce
> improvements in the TI (Q)SPI controller driver.
>=20

Well, I based my patches on linux-next as per Brian's suggestion. If
patches to support other flash protocol modes are accepted, I would be
happy to rebase and make use of other modes. It would just be the matte=
r
of populating msg.{opcode/addr}_n_bits correctly.


>=20
> Also please note that you may have to add in the struct spi_flash_rea=
d_message
> two other fields for the number of option/mode cycles and their value=
=2E
> Option/mode cycles are sent between the address and dummy cycles. The=
y are
> used by some memory manufacturers such as Spansion, Micron and Macron=
ix to
> enter/leave their continuous read mode.
> So if uninitialized dummy cycles are interpreted by the QSPI memory a=
s
> option/mode cycles, depending on the actual value, the memory may ent=
er by
> mistake in continuous mode. Once in continuous mode, the command op c=
ode byte
> must not be sent and is not expected by the memory: the memory implic=
itly uses
> the read op code sent in the SPI message which triggered the memory t=
o enter
> continuous read mode. Next SPI messages start from the address cycles=
 until
> the right option/mode cycles are sent to leave the continuous read mo=
de.
>=20
> Currently the mtd layer doesn't use this feature but it should be awa=
re of it.
> That's why I believe we'll have to address this point in spi_nor_scan=
() and the
> "regular" m25p80() sooner or later.
>=20

Above feature can be added incrementally over this series, (as and when
m25p80 is updated) moreover ti-qspi controller does not support
option/mode cycles in memory-mapped mode, so I wont be able to test thi=
s
feature anyway.


--=20
Regards
Vignesh
