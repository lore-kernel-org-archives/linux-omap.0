From: "naga rajan" <nagubk82@gmail.com>
Subject: DSP/BIOS LINK problem
Date: Tue, 21 Mar 2006 17:51:33 +0530
Message-ID: <7e6cc7550603210421i6d43d1c9ycaf910d9be22895f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Minjie,

            I built the DSP/BIOS LINK using kernel 2.6.8 by using the same
procedure mentioned in the Linux DSP Tools guide. I made few changes.
Instead of using montavista toolchain i directed to arm toolchain in the
makefile. I mounted and tested two filesystems.

While mounting the montavista filesystem the following error occcured for
./load4rta,


                                                Montavista filesystem using
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



                                    Rootfs2.6 filesystem using kernel2.6.8



# cd rta/

# ls

dsplinkk.o   led.out      load4rta      pmr_drv.o

hello.out    libcd_bl.so  loadandrun    rtaTrace

# ./load4rta

Using dsplinkk.o

No module found in object

insmod: cannot insert `dsplinkk.o': Invalid module format (-1): Exec format
erro

r

Using pmr_drv.o

No module found in object

insmod: cannot insert `pmr_drv.o': Invalid module format (-1): Exec format
error



 Have you faced this problem?
