From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: Bad data CRC problem after i restart the OSK 5912
Date: Mon, 6 Mar 2006 12:01:13 +0530
Message-ID: <26d3a31c0603052231p2654b55eh55d83699012d09ef@mail.gmail.com>
References: <C51F43ABFC95844490F0529B60753BF403CE7CF7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF403CE7CF7@dlee02.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 Hi
i verified both before and after downloading into flash using imi 0x1000000=
0
and imi 0x100000 for before and after the download .in both cases programme=
d
size is same and it is also indicating that the verifying
checksum ........o.k ..... in both cases .but once i boot up using bootm
0x100000
it is giving the same previous error BAD DATA CRC.
then where could be the problem ??
i am doubting the combination i have choosed
i am using mkimage tool present in the u-boot 1.1.1 with gcc-3.4.1 for linu=
x
2.6.11.3 with the same rc3 patch . is this the valid combination ??
is there any conflicts between uboot1.1.1 and linux 2.6.11.3 ??
whether uboot 1.1.1 will support linux2.6.11.3 or not ??




On 3/4/06, Hunter, Jon <jon-hunter@ti.com> wrote:
>
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of Tony Lindgren
> > Sent: Friday, March 03, 2006 1:05 PM
> > To: prafulla chandra vejendla
> > Cc: linux-omap-open-source@linux.omap.com
> > Subject: Re: Bad data CRC problem after i restart the OSK 5912
> >
> > * prafulla chandra vejendla <v.prafulla@gmail.com> [060302 22:53]:
> > > Hi all,
> > > i am using u-boot 1.1.1 with linux2.6.11.3 i made an uimage.cc of
> > 1143783
> > > bytes (nearly 1.1MB) with out any error by following new-bie guide
> for
> > my
> > > osk 5912 board i downloaded that through  the hyperterminal by using
> the
> > > kermit protocol . once i restarted the board or if i use
> > >  bootm 0x100000 it is giving verifying checksum....... Bad Data CRC.
> and
> > > remained in the uboot prompt only.
> > > why i am getting this error .where will be the problem.whether that
> > kernal
> > > and u-boot combination that i have choosen is correct or not.
> > > please clear my doubt
> >
> > Probably bad memory timings set in the bootloader.
> >
> > Tony
>
> I have seen such problems on occasion too. I would try downloading the
> kernel again and before you program it into the flash use the uboot
> "imi" command to validate that the image was downloaded correctly. When
> using the "imi" you need to pass the address where the kernel was
> downloaded to. More info here:
> http://www.denx.de/wiki/view/DULG/UBootCmdGroupInfo#Section_5.9.1.4.
>
> Also once you program the kernel into flash you can use the "imi"
> command again to verify that it was programmed correctly. If you
> accidently programmed a size smaller than the actual image size into
> flash when using the "cp.b" command you may see this issue too.
>
> Jon
>
