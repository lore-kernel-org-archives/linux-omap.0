From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Accessing DSP MMU on OMAP SDP2430
Date: Mon, 22 Jan 2007 07:23:47 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429287F8E@dlee13.ent.ti.com>
References: <20070122095504.11749.qmail@webmail25.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070122095504.11749.qmail@webmail25.rediffmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: rajeev  s <rajeev2174@rediffmail.com>, linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Depending on when you want to access it and how often you will either
chose to create a static map for the device or just ioremap it.

If you don't need to access it much and you don't need it a very early
states of the boot process it is probably just as well to dynamically do
handle it with ioremap.

If you are set on static mapping it you can google up an old mail on
this list where I give a lot of information on a thread about internal
sram.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of rajeev s
> Sent: Monday, January 22, 2007 3:55 AM
> To: linux_omap_open_source
> Subject: Accessing DSP MMU on OMAP SDP2430
>=20
> Hi All,I have an sdp2430 board (OMAP2430 based).I want to access the
DSP
> MMU registers from the ARM side .The Address base of this DSP MMU
Register
> is on the Address range 0x5d000000. To access these registers from ARM
to
> setup the MMU Translation i added the following code in the
> file:include/asm/arch-omap/io.h (Linux source is 2.6-19):#define
> IO_VIRT_DSP_L2_RAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xED000000&nbsp; /*
va
> of&nbsp;DSP MMU&nbsp;*/I arrived at this address using the following
logic
> :0x5d000000&nbsp;+ 0x90000000 =3D 0xED000000.When i access the DSP MMU
> address registers from the Virtual Address base 0xED000000&nbsp;, i
get an
> kernel crash.Also i have created an entry for this address in the io.c
> file as well.Could anybody let me know am i following the correct
> procedure.ThanksRajeev
>=20
> raj
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
