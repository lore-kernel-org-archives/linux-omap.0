From: Louis Jung <lhsj81@gmail.com>
Subject: Re: DSP specification task_test2 compilation error
Date: Tue, 3 Jan 2006 14:46:08 +1100
Message-ID: <cb6819fd0601021946j15d134d0i57a83543077aa7e6@mail.gmail.com>
References: <cb6819fd0512290335td92ffadqccff67be0385dd14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <cb6819fd0512290335td92ffadqccff67be0385dd14@mail.gmail.com>
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

Hi, everyone,

I am currently using DPSgateway 3.2. I made dspctl and the ex_task.out. I
placed the ex_task.out under /root in the OMAP. Placed dspctl binary under
/sbin. Manually mounted sys directory using
mkdir /sys
mount -t sysfs sysfs /sys

and created the dsptask nodes.

When I type
/sbin/dspctl start ex_task.out
I get
.
.
.
.
.
dspgw_version   : adr =3D 0x000000, size=3D    8  ... ignored.
ipbuf           : adr =3D 0x018800, size=3D 1136  ... initialized.
dbgbuf          : adr =3D 0x00c7f0, size=3D  512  ... initialized.
And right at the end, I get this error.

warning: found zero-sized cinit entry at 0xbde
.cinit          : adr =3D 0x010000, size=3D 3040   ... .bss variables are
initialized.

And the system freezes.
Does anyone know how to get around this problem?
Thank you very much.
Louis
