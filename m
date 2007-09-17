From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: PRCM settings
Date: Mon, 17 Sep 2007 06:47:01 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901EB7912@dlee13.ent.ti.com>
References: <c656a4d20709140331p3150b1f4q5e211ed9bc784930@mail.gmail.com><3B6D69C3A9EBCA4BA5DA60D91302742901E0CDBA@dlee13.ent.ti.com>
	<c656a4d20709170053o680f08b5o46161f897d031bd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20709170053o680f08b5o46161f897d031bd3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> But the problem is that on my board kernel is not booting with PRCM =
#5a
> with
> ramdisk (My board is 2430 sdp with pop memory).
> Board boots fine with nfs. But as its not booting with ramdisk @133
> i fear to use this speed to avoid any run time corruptions.
>=20
> So i reduced core clock freq from 532 to 494(fref=3D13 so my dpll equ =
is
> core_clock=3D(26*266)/(13+1)). With this reduced clock and L3 running =
at
> 123Mhz
> everything is working fine.
>=20
> That's why i asked, for ram grade 133 whether we must use speed (L3 =
clock)
> less than 133?? ... Or it is some other problem like u-boot
> uncompression problem??

My initial answer was still correct.  For memory graded for 133MHz you =
can run at 133MHz.

If it boots with NFS but not a ram disk that is not good.  If that is =
the case you surly will also have failures with NFS.  They may be less =
often but can be equally deadly.

All this likely means is you need to adjust your DDR timings.  This is =
fairly easy to do on OMAPS given the nice match of DDR data sheets to =
the OMAP SDRC controller.

There is some chance you issue would be with the POP memory itself or =
with some electro or mechanical issue. This doesn't so likely.  =
Adjusting drive strength or playing with DCDL settings can help here.  =
Maybe some kind of xray scheme can give confidence.
.=20
> When i boot with L3 @133MHz with ramdisk i see upto this on console
> then nothing.
> (Ramdisk is at 0x81600000 size 4M)
> # bootm
>=20
>                 Booting image at 80000000 ...
>                         Image Name:   Linux-2.6.19-omap1
>                         Image Type:   ARM Linux Kernel Image
> (uncompressed)
>                         Data Size:    1241932 Bytes =3D  1.2 MB
>                         Load Address: 80008000
>                         Entry Point:  80008000
>                         Verifying Checksum ... OK
>                 Starting kernel ...
>=20
>                 Uncompressing
> Linux...........................................................
>                 .....................................................
> done, booting the kernel.

So did you debug inside of this at all to verify your guesses?

Regards,
Richard W.
