From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: RE: DSP/BIOS LINK problem
Date: Tue, 21 Mar 2006 10:39:33 -0700
Message-ID: <6632A2E3A760EA41B6A08F2A8B02C34C93B9B1@BBSC-EX01.bbsconnect.ca>
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

Hi Naga,

There is lots of difference between 2.4 and 2.6 kernel. Suchn as the
module name is .ko not .o And old modules utilities doesn't support
modules in kernel 2.6.=20

Regards,
Minjie
=20



-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of naga
rajan
Sent: March 21, 2006 4:22 AM
To: linux-omap-open-source@linux.omap.com
Subject: DSP/BIOS LINK problem

Hi Minjie,

            I built the DSP/BIOS LINK using kernel 2.6.8 by using the
same procedure mentioned in the Linux DSP Tools guide. I made few
changes.
Instead of using montavista toolchain i directed to arm toolchain in the
makefile. I mounted and tested two filesystems.

While mounting the montavista filesystem the following error occcured
for ./load4rta,


                                                Montavista filesystem
using
kernel2.6.8



MontaVista(R) Linux(R) Professional Edition 3.1, Preview Kit



login[175]: root login  on `console'







BusyBox v0.60.2 (2004.04.30-17:44+0000) Built-in shell (ash)

Enter 'help' for a list of built-in commands.



# ls

add

pid

# cd /work/rta/

# ls

dsplinkk.o  load4rta    pmr_drv.o

# ./load4rta

Using dsplinkk.o

insmod: Not configured to support old kernels

Using pmr_drv.o

insmod: Not configured to support old kernels

#



While mounting the 2.6.8 filesystem



                                    Rootfs2.6 filesystem using
kernel2.6.8



# cd rta/

# ls

dsplinkk.o   led.out      load4rta      pmr_drv.o

hello.out    libcd_bl.so  loadandrun    rtaTrace

# ./load4rta

Using dsplinkk.o

No module found in object

insmod: cannot insert `dsplinkk.o': Invalid module format (-1): Exec
format erro

r

Using pmr_drv.o

No module found in object

insmod: cannot insert `pmr_drv.o': Invalid module format (-1): Exec
format error



 Have you faced this problem?
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
