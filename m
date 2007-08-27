From: <sshahrom@micron.com>
Subject: RE: [PATCH 2/3] OMAP: Adding Support for 2K nand page support for
	omap2430
Date: Mon, 27 Aug 2007 09:34:35 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6C1@ntxsjombx02.micron.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AE@ntxsjombx02.micron.com>
	<20070810104326.GX8658@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070810104326.GX8658@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi;
Sorry, I just got back from vacation. The difference between =
omap-nand-flash.c and omap2.c was so much that I thought modify =
omap-nand-flash.c file would cause more confusion. But I am open to any =
suggestion.
Regards,
-Shahrom=20

-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com]=20
Sent: Friday, August 10, 2007 3:43 AM
To: sshahrom
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH 2/3] OMAP: Adding Support for 2K nand page support =
foromap2430

Hi,

* sshahrom@micron.com <sshahrom@micron.com> [070727 10:18]:
> Hi,
> Continuing with rest of the patch series on linux.omap.com.=20
>=20
>=20
> Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>
>=20
>=20
> :000000 100644 0000000... 8ec2004... A	drivers/mtd/nand/omap2.c
> :000000 100644 0000000... 051d7d9... A	=
include/asm-arm/arch-omap/nand.h
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c new=20
> file mode 100644 index 0000000..8ec2004
> --- /dev/null
> +++ b/drivers/mtd/nand/omap2.c

<snip>

Could this be merged with omap-nand-flash.c?

Regards,

Tony
