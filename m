From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: Camera Interface on OMSP2430
Date: Thu, 7 Dec 2006 07:15:11 -0600
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F2B1FAA@dlee11.ent.ti.com>
References: <7d8fdf6f0612062311i7ae347bcsef102801cf2b9ed9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7d8fdf6f0612062311i7ae347bcsef102801cf2b9ed9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Raghunandan Dhongadi <dk.raghu@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Raghu,

	The IVA2.1 (DSP Core) does have access to the L4 Interconnect,
to which the Camera Subsystem registers are connected.

Regards,=20

Brandon Azbell=20
Texas Instruments=20
Senior, Group Technical Staff=20
System Applications=20
b-azbell@ti.com  email=20
847.517.4536      voice=20
847.517.4576      fax=20
630.561.9593      mobile=20


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Raghunandan Dhongadi
Sent: Thursday, December 07, 2006 1:12 AM
To: linux-omap-open-source@linux.omap.com
Subject: Camera Interface on OMSP2430

Hi All,

Are the various interfaces on the OMAP2430 shared between the DSP core
and ARM core ?
For example: Is the camera interface Address Range 0x48052000 -
0x48053FFF accessible by both the DSP core and ARM core ?

Warm Regarsd,
Raghu
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
