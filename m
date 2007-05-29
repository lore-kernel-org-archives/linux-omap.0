From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: OMAP2430 NAND x-loader + U-Boot
Date: Tue, 29 May 2007 07:22:54 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C601887DBA@dlee12.ent.ti.com>
References: <OFFB78E0C0.A61B419E-ON652572EA.003A069E-652572EA.00399691@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <OFFB78E0C0.A61B419E-ON652572EA.003A069E-652572EA.00399691@lntinfotech.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nagesh.Sonone@lntinfotech.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

How are you flashing u-boot?  You must use u-boot to flash u-boot.  If
you are using a flashing tool, such as CSST, it will be flashed in the
wrong format.

I usually use an emulator (Lauterbach or CCS) to run the ELF version of
u-boot on the SDP and then download the u-boot.bin file.  Flash it with
the 'nand write.j' u-boot command.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Nagesh.Sonone@lntinfotech.com
Sent: Tuesday, May 29, 2007 5:34 AM
To: linux-omap-open-source@linux.omap.com
Subject: OMAP2430 NAND x-loader + U-Boot

Hi All,
   I have compiled NAND x-loader for OMAP2430 and is running
successfully=20
( showing the message "x-loader hangs" eventually, and also showing Bad=20
Blocks sometimes). I have also compiled NAND U-Boot for the same.
       I had assumed that it will work well if I put my NAND U-Boot at=20
NAND offset 0x40000 ( as x-loader looks for this address for U-boot=20
image,I believe), but its not working.
  Please can anybody tell me how to make it work for NAND?=20
( I am also not much cleared with NAND booting , It will be great help
to=20
me if somebody can elobarate some more on this with regard to ROM Code ,

Internal RAM)

Thanks & Regards,
Nagesh R. Sonone,
Software Engineer,
L&T Infotech Ltd.=20


______________________________________________________________________
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
