From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: Plea for MMC spec owners
Date: Wed, 07 Jun 2006 08:49:33 +0900
Message-ID: <00da01c689c3$dca1b110$c7a3580a@swcenter.sec.samsung.co.kr>
References: <4485F623.5030403@drzeus.cx>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <4485F623.5030403@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Pierre Ossman' <drzeus-list@drzeus.cx>, "'Khasim, Syed'" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

The following is written from MMC Spec. 4.2

* READ_BL_PARTIAL
Defines whether partial block sizes can be used in block read commands.
Up to 2GB of density (byte access mode):
READ_BL_PARTIAL=3D0 means that only the 512B and the READ_BL_LEN block =
size
can be used for
block oriented data transfers.
READ_BL_PARTIAL=3D1 means that smaller blocks can be used as well. The
minimum block size will be
equal to minimum addressable unit (one byte).
Higher than 2GB of density (sector access mode):
READ_BL_PARTIAL=3D0 means that only the 512B and the READ_BL_LEN block =
sizes
can be used for
block oriented data transfers.
READ_BL_PARTIAL=3D1 means that smaller blocks than indicated in =
READ_BL_LEN
can be used as
well. The minimum block size will be equal to minimum addressable unit, =
one
sector (512B).

* WRITE_BL_LEN
Block length for write operations. See READ_BL_LEN for field coding.
Note that the support for 512B write access is mandatory for all cards. =
And
that the cards has to be in 512B
block length mode by default after power-on, or software reset. The =
purpose
of this register is to indicate the
supported maximum write data block length.
Defines whether partial block sizes can be used in block write commands.
Up to 2GB of density (byte access mode):
WRITE_BL_PARTIAL=3D=A1=AF0=A1=AF means that only the 512B and the =
WRITE_BL_LEN block
size can be used
for block oriented data write.
WRITE_BL_PARTIAL=3D=A1=AF1=A1=AF means that smaller blocks can be used =
as well. The
minimum block size is one
byte.
Higher than 2GB of density (sector access mode):
WRITE_BL_PARTIAL=3D=A1=AF0=A1=AF means that only the 512B and the =
WRITE_BL_LEN block
size can be used
for block oriented data write.
WRITE_BL_PARTIAL=3D=A1=AF1=A1=AF means that smaller blocks can be used =
as well. The
minimum block size will
be equal to minimum addressable unit, one sector (512B).

4.2.3 Access Mode Validation (Higher than 2GB of Densities)
The SEND_OP_COND (CMD1) command and the OCR register are also including =
two
bits for the indication of the supported access mode of the memory. The
specifically set bits in the CMD1 command argument are indicating to a
memory that the host is capable of handling sector type of addressing. =
The
correspondingly set bits in the OCR register are indicating that the =
card
is requiring usage of sector type of addressing. These specific
bits of the OCR register are valid only in the last response from the =
card
for CMD1 (card entering Ready state). This kind of two way handshaking =
is
needed so that
* If there is no indication by a host to a memory that the host is =
capable
of handling sector type of addressing
the higher than 2GB of density of memory will change its state to =
Inactive
(similarly to a situation in which there is no common voltage range to =
work
with)
* From the indication of the sector type of addressing requirement in =
the
OCR register the host is able to separate
the card from the byte access mode cards and prepare itself
It needs to be taken into account that in a multi card system a byte =
access
mode card (<=3D2GB) is blocking the
OCR response in such way that a sector access mode card (>2GB) is not
necessarily recognized as a sector
access mode card during the initialization. Thus this needs to be
reconfirmed by reading the SEC_COUNT
information from the EXT_CSD register.=20

Regards,
Kyungmin Park

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Pierre Ossman
> Sent: Wednesday, June 07, 2006 6:40 AM
> To: Khasim, Syed
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: Plea for MMC spec owners
>=20
> Khasim, Syed wrote:
> >
> > Pierre, this is clearly defined in spec. It's mandatory for=20
> a MMC (of=20
> > any size) to start with a 512M block on a soft reset / power on.
> >  =20
>=20
> Then I guess the spec would be self-contradictory as the=20
> section you quoted earlier clearly stated that only=20
> READ_BL_LEN/WRITE_BL_LEN was valid if *_BL_PARTIAL wasn't set.
>=20
> Rgds
> Pierre
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
>=20
