From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 14:59:08 +0530
Message-ID: <455C2F64.9060901@gmail.com>
References: <EA12F909C0431D458B9D18A176BEE4A50899CB80@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50899CB80@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Richard,
> For quicker time to functionality and isolation between release streams
> we created 2 separate versions, one for 2420 and one for 2430/3430
> versions.  A merged version is possible but would take a bit more time.
> 
I dont know if we want that to happen, the 16xx-2420 where pretty
similar compared to hiend 2430-3430 variant. mebbe it is high time we
have i2c and other ip drivers based on IP versions instead of omap
versions.. will save a hell lot of confusions. dma3.3 vs dma4, gpmc
variants, i2c variants... all of them require optimization in some
perspective, the new i2c has FIFO which the old 2420 does not have, the
code is entirely different for optimization reason.

Rest i leave to list discretion :)
Regards,
NM
