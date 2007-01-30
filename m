From: "Madhava Gauranga" <Madhava.Gauranga@ittiam.com>
Subject: RE: Problem in linking with montavista toolchain for omap2420
Date: Tue, 30 Jan 2007 11:46:11 +0530
Message-ID: <904DEC693BE1AB429622C6F5ABA7E0B801B2253C@is01ex02.ittiam.com>
References: <1169985183.16634.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1169985183.16634.24.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Indraneel <indraneel.m@samsung.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hey indranil,

I reckon u have copied the toolchain already installed somewhere,
instead of installing them. try installing(perhaps from the cd(s)
provided) the toolchain. The problem should be fixed then.

Respect,
Madhava Gauranga
=20
=20
Ittiam Systems | www.ittiam.com
A Red Herring Asia 100 Company, 2005
Forward Concepts' Worlds Most Preferred DSP IP Supplier, 2004, 2005

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Indraneel
Sent: Sunday, January 28, 2007 5:23 PM
To: Linux-omap-open-source@linux.omap.com
Subject: Problem in linking with montavista toolchain for omap2420

Hi,
I'm trying to cross-compile a program using the montavista tool chain
for arm_v5t_le architecture for the omap2420(h4 board). I get the
following error when linking a simple c program:

$ arm_v5t_le-gcc -DPOSIX -DMD=3D2 rz.c
/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.
1/../../../../armv5tl-hardhat-linux/bin/ld: cannot find libc.so.6
collect2: ld returned 1 exit status


Surprisingly i couldn't find any file or link by the name libc.so.6 in
the toolchain, although there was
/opt/montavista/devkit/arm/v5t_le/target/usr/lib/libc.so

Other info
gcc
version 3.3.1 (MontaVista 3.3.1-7.0.15.0500230 2005-02-20)
--with-sysroot=3D/opt/montavista/devkit/arm/v5t_le/target

GNU ld
version 2.14 20030612 (MontaVista 2.14-11.0.7.0500230 2005-02-20)

PATH=3D/opt/montavista/devkit/arm/v5t_le/bin:$PATH


I have searched for the error but couldn't find anything definitive.

Can anyone provide any clues as to what is wrong and how can i solve
this linking issue?

Any pointers will be appreciated.

Regards,
Indraneel




_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
helpdesk@ittiam.com.
**********************************************************************
