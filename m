From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Accessing Mailbox register on OMAP SDP2430
Date: Fri, 16 Feb 2007 09:41:31 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C474535B6@dlee13.ent.ti.com>
References: <1169480869.S.3614.7806.webmail19.rediffmail.com.old.replied.1171637341.28201@webmail.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1169480869.S.3614.7806.webmail19.rediffmail.com.old.replied.1171637341.28201@webmail.rediffmail.com>
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

Did you try __raw_readl?=20

The size of the register might also matter, make sure you are accessing
a 32bit register otherwise switch to __raw_readw or __raw_readb

Regards,
Khasim

> -----Original Message-----
> From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com
> =
[mailto:linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com]
On
> Behalf Of rajeev s
> Sent: Friday, February 16, 2007 8:49 AM
> To: linux_omap_open_source
> Subject: Accessing Mailbox register on OMAP SDP2430
>=20
> Hi ,We are in the process of porting DSP/LINK to OMAP2430 (SDP2430).We
are
> programming the mail boxes for the interprocess communication, In the
> process we are&nbsp;using the address 0x48094000.We did the ioremap of
the
> Address range (0x48094000) and could see that it returns an virtual
> address, but the moment i access that virtual address&nbsp;the kernel
> crashes.Please find the sample code below:Code
> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static unsigned int
>
*arm_addr2=3DNULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_addr=
2
=3D
> (unsigned int *)ioremap(0x48094000,0xFFF
> );&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk ( \" 0x48094000
Virt
> Addr =3D 0x%p\\n\", arm_addr2 );
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_var =3D readl(arm_addr2);Can
> anyone let me know is there anything wrong in the way these registers
are
> accessed ?ThanksRajeev
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
