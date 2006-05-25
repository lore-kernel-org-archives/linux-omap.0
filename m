From: Krzysztof Kaczmar <arroyo@o2.pl>
Subject: Re: Problem with DSP/BIOS Link and Linux Dsp Tools
Date: Thu, 25 May 2006 20:52:29 +0200
Message-ID: <20060525185229.GA3660@flo.t16.ds.pwr.wroc.pl>
References: <20060525162656.51C602334F9@poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060525162656.51C602334F9@poczta.interia.pl>
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

On Thu, May 25, 2006 at 06:26:56PM +0200, Micha=B3 Szabat wrote:
>=20
> Hello.
> I succesfuly build DSP/BIOS Link with Linux Dsp Tools and toolchain 3.4=
.1.
> I'm using kernel 2.6.11. Rootfs is mounted by nfs. I copied file dsplin=
kk.o and pmr_drv.o in the shared area for nfs, by the modules cannot inse=
rt:=20
>=20
> # ls
> dsplinkk.o  load4rta    pmr_drv.o
> # ./load4rta
> mknod: /dev/dsp: File exists
> Using dsplinkk.o
> No module found in object
> insmod: cannot insert `dsplinkk.o': Invalid module format (-1): Exec fo=
rmat error
> mknod: /dev/dsplink: File exists
> Using pmr_drv.o
> No module found in object
> insmod: cannot insert `pmr_drv.o': Invalid module format (-1): Exec for=
mat error
> mknod: /dev/bios_pmr: File exists
> # insmod dsplinkk.o
> Using dsplinkk.o
> No module found in object
> insmod: cannot insert `dsplinkk.o': Invalid module format (-1): Exec fo=
rmat error
> # insmod pmr_drv.o
> Using pmr_drv.o
> No module found in object
> insmod: cannot insert `pmr_drv.o': Invalid module format (-1): Exec for=
mat error

DSP/BIOS Link (ver. 1.12.01) in LinuxDSPTools doesn't support kernels 2.6
AFAIK, consider using DSPGateway [http://dspgateway.sourceforge.net/] or
download dsplink 1.30 from ti.com and be prepared for ,,documentation
mayhem''.

There is no linux-omap-open-source FAQ that I'm aware of, but I guess que=
stions
about commercial solutions don't belong to this list, am I right?

--=20
Krzysztof Kaczmar <arroyo@o2.pl>
