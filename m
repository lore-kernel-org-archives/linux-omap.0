From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: omap flash programming
Date: Tue, 4 Dec 2007 08:20:07 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302BC66AE@dlee12.ent.ti.com>
References: <851794.82307.qm@web7711.mail.in.yahoo.com>
	<4754E57E.5090306@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <4754E57E.5090306@css-design.us>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Steve Poulsen <spoulsen@css-design.us>, kathirvel nachimuthu <use.kathir@yahoo.co.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> If you don't have u-boot working yet, then I recommend the u-boot.out
> file that comes on the CD.  If you load it and run it, it should flash
> u-boot into the system. =20

Actually, if you have CCS and a JTAG emulator, then instead of using the
u-boot.out file that comes with the CD, you can just use CCS to download
the "u-boot" file that gets built when build u-boot. CCS has the ability
to load COFF and ELF formated files. The u-boot builds 3 files, namely
u-boot.srec, u-boot.bin and u-boot. The last file is an ELF file.=20

So to summarise:

1). Load the u-boot file with CCS and run it=20
2). Use u-boot to download the u-boot.bin with tftp or kermit=20
3). Use u-boot to program the u-boot.bin into flash.=20

Cheers
Jon
