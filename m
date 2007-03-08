From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: Writing x-loader using u-boot.
Date: Thu, 8 Mar 2007 05:44:40 -0600
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6D3EB04@dlee12.ent.ti.com>
References: <8bf247760703080155x3474688ew85f7a3dbe9d2f477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8bf247760703080155x3474688ew85f7a3dbe9d2f477@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You cannot use u-boot as-is to flash the x-loader.  The ECC algorithms
are different between CSST and u-boot.  The one in CSST forms a 3-byte
ECC that is the same as the boot ROM.  I haven't looked at the one in
u-boot lately, but I suspect it is not a 3-byte ECC that the boot ROM
understands.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Ram
Sent: Thursday, March 08, 2007 3:55 AM
To: linux-omap-open-source@linux.omap.com
Subject: Writing x-loader using u-boot.

Hi,
  Im using OMAP2430. Im trying to write x-loader using u-boot. for
some reason i dont want to use CSST.  I want to use u-boot only to
flash x-loader and u-boot (nand).

   u-boot nand - im able to write/read it back - no issues.

   I am able to write x-loader to nand flash using u-boot, i have
checked the contents of nand flash by reading it back. It is also same
as x-loader as written by CSST.

   But when i boot - it doesnt work?. Does CSST do anything special
other than writing it to nand flash?.

   Has anyone tried writing x-load using u-boot?

Regards,
sriram
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
