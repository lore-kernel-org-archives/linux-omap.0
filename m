From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: Plea for MMC spec owners
Date: Tue, 6 Jun 2006 09:44:27 -0500
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE4791EA@DLEE09.ent.ti.com>
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

> As per my understanding, MMC (of all sizes) by default should be set
to
> operate in 512B (mandatory). This is true for both read and write.
With
> this default setup, I feel MMC card (<=3D2GB) should work as is with
BLEN
> set to 512.
>  =20

>>> That is my feeling as well. But it would have been nice to back it
up
>>> with an official spec.

Pierre, this is clearly defined in spec. It's mandatory for a MMC (of
any size) to start with a 512M block on a soft reset / power on.=20

Regards,
Khasim

-----Original Message-----
From: Pierre Ossman [mailto:drzeus-list@drzeus.cx]=20
Sent: Monday, June 05, 2006 5:40 PM
To: Khasim, Syed
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: Plea for MMC spec owners

Khasim, Syed wrote:
> Hi Pierre,
>
> Regarding 2GB, the MMC specification doesn't state any thing clearly
as
> the SD spec does.
>
>  =20

That's too bad as I was hoping we could avoid guesswork. :-/

> As per my understanding, MMC (of all sizes) by default should be set
to
> operate in 512B (mandatory). This is true for both read and write.
With
> this default setup, I feel MMC card (<=3D2GB) should work as is with
BLEN
> set to 512.
>  =20

That is my feeling as well. But it would have been nice to back it up
with an official spec.

> However, if the size of MMC is greater than 2GB then it switches to
> sector access mode (<=3D2GB operates in byte access) and we are =
supposed
> to read from EXT_CSD register for getting the density of card. I was
> wondering if for some reason on some of the cards it's switching to
this
> mode and therefore it's not consistent across all the 2GB MMCs.
>
>  =20

This voodoo you speak of is rather unknown to us since we lack a real
MMC4 spec. ;-)

Rgds
Pierre
