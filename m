From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: simple test program for UART on OMAP3430
Date: Wed, 9 Jan 2008 20:48:33 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A001531E10@dbde01.ent.ti.com>
References: <OFB725D007.E7BE2EBD-ON652573CB.005208B9-652573CB.005313D9@aricent.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <OFB725D007.E7BE2EBD-ON652573CB.005208B9-652573CB.005313D9@aricent.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Debadatta.Mishra@aricent.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of
> Debadatta.Mishra@aricent.com
> Sent: Wednesday, January 09, 2008 8:34 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: simple test program for UART on OMAP3430
>=20
> Hi All,
>=20
> I need a simple test program to test UART for OMAP3430.That test =
program
> should run without OS.Can any one help me???
>=20
Do you plan to use u-boot? Minimum you need is a bootloader to =
initialize clocks and do other necessary configurations for board, only =
then you can have any test program working.

I didn't get why you need this? Can you elaborate more?

Regards,
Khasim
