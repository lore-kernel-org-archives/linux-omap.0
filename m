From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: Writing x-loader using u-boot.
Date: Fri, 9 Mar 2007 07:29:03 +0530
Message-ID: <45F366B1BC4F7C4A895F0F34C41E61A5030E1F3C@dbde01.ent.ti.com>
References: <B62D67BD8EC3324C8A3DACEEA1A0D6C6D3EB04@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <B62D67BD8EC3324C8A3DACEEA1A0D6C6D3EB04@dlee12.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>, Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Ram,

I think both u-boot and ROM Code use the same 3-byte ECC; but they may
be storing the ECC in different locations in the spare area (I've seen
this happen in other OS's).

For example, CSST uses the first 1 or 2 bytes (depending on 8-bit or
16-bit NAND) for the "bad block marker", and then immediately stores/
reads the 3 byte ECC. But the Samsung standard is different -> the first
1/2 bytes for BI is still the same, but the ECC is stored at a different
offset (byte offset #9 I believe).

So, when you write Xloader to NAND using u-boot, the ROM code while it
tries to load the Xloader into SRAM, will think the ECC doesn't match -
so bad content. This is why you wouldn't see it to boot.

You can confirm this using CSST - instead of "Download", choose the
"Read" option in CSST, and provide the "number of bytes to read" as 16
(and not any other value). This will dump the spare area content.

Regards,
Sriram.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Kipisz, Steven
> Sent: Thursday, March 08, 2007 8:45 PM
> To: Ram; linux-omap-open-source@linux.omap.com
> Subject: RE: Writing x-loader using u-boot.
>=20
> You cannot use u-boot as-is to flash the x-loader.  The ECC algorithms
> are different between CSST and u-boot.  The one in CSST forms a 3-byte
> ECC that is the same as the boot ROM.  I haven't looked at the one in
> u-boot lately, but I suspect it is not a 3-byte ECC that the boot ROM
> understands.
>=20
> Steve K.
>=20
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Ram
> Sent: Thursday, March 08, 2007 3:55 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Writing x-loader using u-boot.
>=20
> Hi,
>   Im using OMAP2430. Im trying to write x-loader using u-boot. for
> some reason i dont want to use CSST.  I want to use u-boot only to
> flash x-loader and u-boot (nand).
>=20
>    u-boot nand - im able to write/read it back - no issues.
>=20
>    I am able to write x-loader to nand flash using u-boot, i have
> checked the contents of nand flash by reading it back. It is also same
> as x-loader as written by CSST.
>=20
>    But when i boot - it doesnt work?. Does CSST do anything special
> other than writing it to nand flash?.
>=20
>    Has anyone tried writing x-load using u-boot?
>=20
> Regards,
> sriram
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
