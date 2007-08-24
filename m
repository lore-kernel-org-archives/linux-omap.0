From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: CSST's load to ram feature
Date: Fri, 24 Aug 2007 15:08:01 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901B8CD78@dlee13.ent.ti.com>
References: <46CF3A16.5060106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <46CF3A16.5060106@gmail.com>
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


> One possible condition is clock configurations. x-loader and=20
> u-boot might expect a 19.2 Mhz sys clock, and configures=20
> accordingly while possibly the uboot expects something like=20
> 26Meg or something.. am just guessing here.. in theory, if=20
> every single configuration is being done by the u-boot +=20
> x-loader combination and if the image is raw, all the execute=20
> option does is to hand over control to the image, and this=20
> should allow it to work.  As Richard mentioned, Lauterbach=20
> etc might give you a better controlled environment for uboot=20
> and x-loader to work in.

100% correct ;)

For our x-loader buids we even have soft-links from xloader into u-boot
to try and get around some of this.  They as currently implemented must
be matched.

Regards,
Richard W.
