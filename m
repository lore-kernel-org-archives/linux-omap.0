From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: RE: Problem with DSP/BIOS LINK for kernel 2.6.8
Date: Mon, 20 Mar 2006 10:32:23 -0700
Message-ID: <6632A2E3A760EA41B6A08F2A8B02C34C93B422@BBSC-EX01.bbsconnect.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: naga rajan <nagubk82@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
Please Add compiling option -D__LINUX_ARM_ARCH__=3D5.

Regards,
=20
Minjie

-----Original Message-----
From:
linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@linux.omap.=
c
om
[mailto:linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@lin=
u
x.omap.com] On Behalf Of naga rajan
Sent: March 17, 2006 8:45 PM
To: linux-omap-open-source@linux.omap.com
Subject: Problem with DSP/BIOS LINK for kernel 2.6.8

Dear Sir,



                        I build the DSP/BIOS link with kernel 2.6.8 by
setting the compiler path and kernel path corresponding to 2.6.8 kernel
and toolchain.While executing "./load4rta",the following message is
displayed "Not configured for old kernel".I think that "load4rta"
utility has been built with montavista 2.4.20 kernel. I want to change
the "load4rta" to
2.6.8 kernel but cant able to find the version number, have u overcome
this problem.



Thanks and regards,

B.Nagarajan,

SANDS INSTRUMENTATION.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
