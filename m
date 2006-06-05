From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: Plea for MMC spec owners
Date: Mon, 5 Jun 2006 17:19:41 -0500
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE41CF48@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Pierre,

Regarding 2GB, the MMC specification doesn't state any thing clearly as
the SD spec does.

As per my understanding, MMC (of all sizes) by default should be set to
operate in 512B (mandatory). This is true for both read and write. With
this default setup, I feel MMC card (<=3D2GB) should work as is with =
BLEN
set to 512.

However, if the size of MMC is greater than 2GB then it switches to
sector access mode (<=3D2GB operates in byte access) and we are supposed
to read from EXT_CSD register for getting the density of card. I was
wondering if for some reason on some of the cards it's switching to this
mode and therefore it's not consistent across all the 2GB MMCs.

Regards,
Khasim

-----Original Message-----
From: Pierre Ossman [mailto:drzeus-list@drzeus.cx]=20
Sent: Monday, June 05, 2006 10:57 AM
To: Khasim, Syed
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: Plea for MMC spec owners

Khasim, Syed wrote:
> Hi Pierre,
>
> A quick search to write_bl_partial and read_bl_partial in MMC spec
gave
> the following lines.
>  =20

Thanks. Unfortunately, it wasn't the response I was hoping for as it
isn't consistent with what we've been seeing with other MMC and SD
readers.

> I think you already have this pointer to SD spec, might be helpful to
> others.
>
>
http://www.sdcard.org/sd_memorycard/Simplified%20Physical%20Layer%20Spec
> ification.PDF
>
>  =20

I have to admit, I hadn't looked that closely at that spec as it didn't
cover the protocol properly. But it actually said something about this
issue:

4.3.2 2GByte Card
To make 2GByte card, the Maximum Block Length =
(READ_BL_LEN=3DWRITE_BL_LEN)
shall be set to
1024 bytes. But Block Length set by CMD16 shall be up to 512 bytes to
keep consistency with 512
bytes Maximum Block Length cards (Less than and equal 2GByte cards).

Could you have a second look in the MMC spec and see if there are
similar provisions?

Rgds
Pierre
