From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP2430 NAND Boot
Date: Thu, 4 Jan 2007 06:41:49 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A509333EEF@dlee02.ent.ti.com>
References: <7d8fdf6f0701032244h43e68e3fva88745b793d97697@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7d8fdf6f0701032244h43e68e3fva88745b793d97697@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Raghunandan Dhongadi <dk.raghu@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I am trying to do a NAND boot on OMAP2430 SDP Board. The steps are as
> follows...
>=20
> 1. I have built the X-Loader and appended the .ift header.

You mean the .ift TOC was pre-pended to the binary image and the .ift
extension was appended to the end of the file name, right? When IFT
signs an image the TOC header is added at the beginning of the file and
the file name is changed.

This is for NAND not OneNAND is this correct?  It does make a difference
in signing parameters and procedure.

> 2. Dip switch settings for NAND boot
> 3. The internal ROM code shadows X-Loader to SRAM 0x4020.0000 and
> transfers control

Have you enabled printing so you can see the X-Loader banner and know
control has passed successfully to the loader?

> 4. The X-Loader begins to execute and tries to copy the U-Boot from
> the NAND flash.
> 5. I get a bad block error.

How did you write the u-boot.bin image into NAND flash?  If you used
CSST then it likely won't work.  You should use u-boot to burn itself
back into NAND flash.  The OOB-CRC format is different between what the
ROM code needs to get the Xloader and what the xloader needs to fetch
the u-boot.  I suppose it is a bit configurable based on how you build
your u-boot (it can interpret the OOB area differently based on build,
to ignore or not at least).

For NAND, you need to sign/program the xloader with CSST, then use
u-boot to place your other bits (u-boot/kernel/fs) into NAND.  It might
be you can also use the kernel MTD utilities to do the same, but you
need to be booted to do that also.

ROM code uses a simple bad block skip alg and assume the next good one
is logically next in the image sequence.  I think x-loader was doing the
same for u-boot but I don't recall completely right now.

Bad blocks can be an issue if you have too many of them in a row, which
is statistically possible but unlikely.

I would expect more that someone has messed up the bad block info when
playing with the NAND chip or perhaps more likely if it's a fresh board
the GPMC timings are off and its reading them as all bad even though
they are good.

In web downloadable versions, OneNAND boot was a tested shipping default
along with SibleyNOR (and StrataNOR should work).  For 2430 raw NAND was
not a default so some minor changes may or may not be necessary.

Regards,
Richard W.
