From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: omap5912 and regular DDR
Date: Tue, 20 Dec 2005 10:37:20 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402EC21A6@dlee02.ent.ti.com>
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
To: Olav Kongas <ok@artecdesign.ee>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Olav,

> We have developed a board on which we use regular DDR=20
> MT46V16M16TG, attached to omap5912. Last Friday I got the DDR=20
> working and till now the u-boot's alternative (more
> thorough) memory test has been running flawlessly for about
> 72 hours. Though I don't think anyone is stupid enough to=20
> knowingly design for unsupported memory type, it seems at=20
> least until now that it can be done with the above memory.
>=20
> Jon, I would most appreciate if you could find out and reveal=20
> the reason, why rDDR is not officially supported on omap5912.=20


I doubled checked on this as it had been sometime since I had looked at
this. However, the official statement still is that we do not support
ddr1. The problem is that the internal i/o buffer on the 5912 will not
meet the JEDEC spec for ddr1. It could be possible that it may work,
however, we cannot guarantee across all devices produced that it will
work as there will be some variation in the silicon between parts.=20

Regards,
Jon
=20
