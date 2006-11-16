From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 08:58:58 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
References: <455C2F64.9060901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <455C2F64.9060901@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > For quicker time to functionality and isolation between release=20
> > streams we created 2 separate versions, one for 2420 and one for=20
> > 2430/3430 versions.  A merged version is possible but would=20
> take a bit more time.
> >=20
> I don't know if we want that to happen, the 16xx-2420 where=20
> pretty similar compared to hiend 2430-3430 variant. mebbe it=20
> is high time we have i2c and other ip drivers based on IP=20
> versions instead of omap versions.. will save a hell lot of=20
> confusions. dma3.3 vs dma4, gpmc variants, i2c variants...=20
> all of them require optimization in some perspective, the new=20
> i2c has FIFO which the old 2420 does not have, the code is=20
> entirely different for optimization reason.

IP version would clarify some aspects around differences and errata.
You would still end up with both (chip & IP) as the integration of the
IP into a chip is an area where things are different also.  I find USB
client to be one which can be confusing.  From 1510-2420 there are many
bug fixes and many are not apparent by register differences.  This can
result in older ones being broke or newer ones not running to their
potential when sharing.

By adding enough layers of indirection/functional pointer tables you can
usually merge things.  However, this can make the code harder to follow.
If people wanted to take the time to merge I suspect that making the HS
driver work in a backward compatible manner might be easier than
upgrading the FS one.  Given what you know today would you agree with
that?  Getting any code into the I2C tree might take a bit of effort.
Tony floated an interesting idea about creating an embedded I2C using
Daivd's frame work.  This might allow faster integration of performance
related changes and the like with out fighting with SMB people.

Regards,
Richard W.
