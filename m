From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: booting process
Date: Thu, 1 Jun 2006 10:33:53 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E134120@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lvcargnini@ieee.org
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Lu=EDs,
=20
> VFS: Mounted root (jffs2 filesystem).
> Freeing init memory: 108K
>=20
> and do  not boot nothing else, i putted the busybox inside the image.
> but i think this is a new subject.
Actually the new EBH/Cleanmarker implementation might take a little time =
to mount up based on ur flash size (some concepts of a garbage collector =
that I don't want to go into).. I got tricked on this some time back too =
:). I suggest to wait atleast 1 hr (more than double the actual time), =
and see if u have a bootup.. If you do have a boot, then from the next =
time, either make ur jffs2 image the same size as the flash size OR boot =
from NFS, do a mount and a umount of the flash partition, etc..
Regards,
Nishanth Menon
