From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: McBSP in ARM side
Date: Sat, 24 Feb 2007 09:26:47 -0600
Message-ID: <45E05937.5020209@gmail.com>
References: <ae36f8040702240431r1c912e0av72cba3314ae95b03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040702240431r1c912e0av72cba3314ae95b03@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?windows-1252?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Luis
Lu=EDs Vit=F3rio Cargnini stated on 2/24/2007 6:31 AM:
> someone knows how to access an specific McBSP in ARM side ?
> according the sources i could load the McBSP driver and use some
> specific f
> unctions as omap_mcbsp_start() for example.
> Or what device of /dev i must open ???
> or for what /dev entries the McBSP are mapped
There are drivers and driver libraries. Drivers provide interfaces to
the userspace.. and libraries are not designed to expose anything to the
external world, and are meant to be used by other drivers to perform
some operation... to my knowledge, McBSP falls in that world of "driver
libraries" just like DMA. if you would like to do something with it, you
should be in kernel space.. Now, if your usecase insists on having a
userspace access... you could write your own wrapper to the driver
library just like what i2c-dev does for I2C driver library.
Regards,
Nishanth Menon
