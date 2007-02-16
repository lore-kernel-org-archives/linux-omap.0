From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: Accessing Mailbox register on OMAP SDP2430
Date: Fri, 16 Feb 2007 20:32:19 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC080029770EA@dbde01.ent.ti.com>
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

Normally if the first access to a peripheral gives a crash, then it is
to do with the turning ON of the interface clock to that peripheral.

-----Original Message-----
From: linux-omap-open-source-bounces+svadivu=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+svadivu=3Dti.com@linux.omap.com] =
On
Behalf Of rajeev s
Sent: Friday, February 16, 2007 8:19 PM
To: linux_omap_open_source
Subject: Accessing Mailbox register on OMAP SDP2430

Hi ,We are in the process of porting DSP/LINK to OMAP2430 (SDP2430).We
are programming the mail boxes for the interprocess communication, In
the process we are&nbsp;using the address 0x48094000.We did the ioremap
of the Address range (0x48094000) and could see that it returns an
virtual address, but the moment i access that virtual address&nbsp;the
kernel crashes.Please find the sample code below:Code
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static unsigned int
*arm_addr2=3DNULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_addr=
2
=3D (unsigned int *)ioremap(0x48094000,0xFFF
);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk ( \" 0x48094000 Virt
Addr =3D 0x%p\\n\", arm_addr2 );
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_var =3D readl(arm_addr2);Can
anyone let me know is there anything wrong in the way these registers
are accessed ?ThanksRajeev
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
