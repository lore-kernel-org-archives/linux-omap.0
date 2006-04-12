From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: Is it possible to use NFS with built-in kernel on 5912 OSK?
Date: Wed, 12 Apr 2006 03:14:40 -0500
Message-ID: <3D54759CE5A8F64BB2078090E91D50A22720E3@dlee08.ent.ti.com>
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
To: Sergey Vointsev <vointsev@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

 Probably you can update the u-boot ver 1.1.2 or later, which=20
allocates the file system from 0x00240000.

 Regards,
 Ishigami

-----Original Message-----
From: Behalf Of Sergey Vointsev
Sent: Wednesday, April 12, 2006 3:30 PM
To: Linux-omap-open-source@linux.omap.com
Subject: Re: Is it possible to use NFS with built-in kernel on 5912 OSK?

> > By the way, why OMAP5912 OSK has 32M of flash onboard, but the size
of
> > default rootfs is only 16M?
> Because the rootfs' address starts from 0x1000000.


Can we somehow use (make fs and mount) previous 16M?
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
