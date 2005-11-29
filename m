From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Tue, 29 Nov 2005 09:13:43 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402AF9FD3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Li Weichen <iaadoa@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Li,

>=20
> Thank you Jon, but I cannot follow the steps.
>=20
> At first when I ran the "Setup CC Studio v3.1" I couldn't=20
> choose the factory board osk5912.  If I choose it, there will=20
> be a popup says "One or more resource is invalid. Check that=20
> device drivers actually exist. You may have to remove bad=20
> resource to exit setup."  So I can only choose omap1610 via=20
> xds560 emulator and selected the osk5912.gel in properties. =20
> It seems that CCS has connected to the board.  I loaded the=20
> file restore/uboot/osk5912-uboot-1.1.1.out on the OSK5912=20
> CD-ROM and pressed "Run".  But I got the following errors:
>=20
> FlashWriter Version 1.7a
> Starting Download to NOR Flash
> Image is 89464 bytes long
> Reading Image from: 10010000
> Writing Image to:  0C000000
> No Flash devices have been found
>=20
> I am quite confused why it tried to write image to 0c00000? =20
> Does the flash address start from 00000000?
>=20

The flash device is connected to CS3 on the device which by default is
actually mapped to address 0x0c000000. The internal boot-rom on the
device is mapped to address 0x0. When the device starts up it always
starts running code from the internal boot-rom. However, one of the
first things the boot-rom does is read gpio13. If gpio13 is pulled low
(JP3 in position 2-3) then the boot-rom will jump to CS3 and execute
whatever is in the flash device when the device starts up.=20

Did you have jumper JP3 in position 1-2 when you downloaded u-boot with
CCS?=20

If you do, can you read address 0xfffecc0c on the device using CCS. This
is the address of the EMIFS_CONFIG register. Bit 1 in this register
allows you to swap the physical mapping of CS0 and CS3. If bit 1 is 0
then CS0 is mapped to address 0x0 and CS3 is mapped to address
0x0c000000. Otherwise, if this bit is 1 then, CS0 is mapped to address
0x0c000000 and CS3 is mapped to address 0x0. If this is set to 1 then
you could manually try clearing this bit before you download and run
u-boot.=20

Regards,
Jon
