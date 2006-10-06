From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Fri, 6 Oct 2006 16:38:41 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A8543873732@EXCHDB.admin.wpi.edu>
References: <CC7B089C59ED6841BAE28F1EA69A8543873731@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A8543873731@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Thanks again for working with me, Dirk.  :)

I wiped everything and started again, using the memory addresses from =
that
guide (I had been following a different one)... it still hangs.  Output =
is as
follows...

=3D=3D=3D=3D=3D
## Booting image at 00040000 ...
   Image Name:   OE
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1065210 Bytes =3D  1 MB
   Load Address: 10c08000
   Entry Point:  10c08000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...
=3D=3D=3D=3D=3D

The Load Address and Entry Point have remained the same, though.  The =
rest of
the flash is empty as I manually erased it all.

Any ideas?
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
=20

-----Original Message-----
From: Dirk Behme [mailto:dirk.behme@googlemail.com]=20
Sent: Friday, October 06, 2006 3:31 PM
To: Sideleau, Scott R
Cc: OMAP
Subject: Re: Can't Boot - OSK Frame Buffer Support in Kernel =
2.6.18-omap1

Sideleau, Scott R wrote:
> ## Booting image at 00100000 ...
>    Image Name:   OE
>    Image Type:   ARM Linux Kernel Image (gzip compressed)
>    Data Size:    1065210 Bytes =3D  1 MB
>    Load Address: 10c08000
>    Entry Point:  10c08000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK

I wonder about the adresses used here. Do you followed

http://oskfordummies.hp.infoseek.co.jp/howto/flash_kernel.html

?

I would assume kernel at 0x40000 and start address/entry
point at 0x10008000. E.g.:

## Checking image at 00040000 ...
      Image Name:   Linux-2.6.11-omap1
      Image Type:   ARM Linux Kernel Image (umcompressed)
      Data Size:    1159328 Bytes =3D 1.1 MB
      Load Address: 10008000
      Entry Point:  10008000
      Veryfying Checksum ... OK

> Any ideas?  Any and all help/direction is appreciated.

For debugging, enable

Kernel hacking -> Kernel debugging -> Kernel low-level
debugging functions

(and temporarily apply patch in attachment, seems to be
necessary to work low level debugging properly).

Dirk
