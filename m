From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: Plea for MMC spec owners
Date: Mon, 5 Jun 2006 09:36:25 -0500
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE41C7BA@DLEE09.ent.ti.com>
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
To: Pierre Ossman <drzeus-list@drzeus.cx>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Pierre,

A quick search to write_bl_partial and read_bl_partial in MMC spec gave
the following lines.

WRITE_BL_PARTIAL
----------------
Defines whether partial block sizes can be used in block write commands.

WRITE_BL_PARTIAL=3D'0' means that only the WRITE_BL_LEN block size can =
be
used for block oriented data write.

WRITE_BL_PARTIAL=3D'1' means that smaller blocks can be used as well. =
The
minimum block size is one byte.

READ_BL_PARTIAL
---------------
Defines whether partial block sizes can be used in block read commands

READ_BL_PARTIAL=3D0 means that only the READ_BL_LEN block size can be =
used
for block oriented data transfers.

READ_BL_PARTIAL=3D1 means that smaller blocks can be used as well. The
minimum block size will be equal to minimum addressable unit (one byte)

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com]
On Behalf Of Pierre Ossman
Sent: Monday, June 05, 2006 3:52 AM
To: linux-omap-open-source@linux.omap.com
Subject: Plea for MMC spec owners

Sorry for being a bit off topic, but this was the venue suggested to me
to get in touch with the required people.

Myself and Russell King (the MMC layer maintainer) have been discussing
a way to resolve the issue with 2GB+ cards that more and more users are
reporting.

The issue that is causing us grief is whether or not it's safe to always
use a sector size of 512 bytes. The card specs we have give conflicting
information, so we'd like to find someone who has access to the official
protocol spec and can check the exact wording. I was told that some of
the Nokia folks, who have been helpful in checking the offical spec
before, hang around here.  :)

What is needed is the exact definition of READ_BL_PARTIAL and
WRITE_BL_PARTIAL.

Thanks
Pierre
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
