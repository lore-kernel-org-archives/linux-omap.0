From: Martin Margraf <m_margraf@web.de>
Subject: RE: change cpu_freq
Date: Fri, 16 Jun 2006 08:40:34 +0200
Message-ID: <953970285@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Minjie Lin <MLin@EmpowerTechnologies.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

hi minjie,

thanks for the answer.
how is the syntax of this=3F like "echo scaling=5Fsetspeed=3Dvalue > /sys/device=
s...." =3F

martin

> -----Urspr=FCngliche Nachricht-----
> Von: "Minjie Lin" <MLin@EmpowerTechnologies.com>
> Gesendet: 15.06.06 20:19:01
> An:  <linux-omap-open-source@linux.omap.com>
> Betreff: RE: change cpu=5Ffreq


> Hi Martin,
>=20
> You can select userspace governor for cpu=5Ffreq and change
> /sys/devices/system/cpu/cpu0/cpufreq/scaling=5Fsetspeed value
> to change the cpu frequency.
>=20
> Regards,
>=20
> Minjie
> =20
>=20
> -----Original Message-----
> From:
> linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@linux.omap.c=

> om
> [mailto:linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@linu=

> x.omap.com] On Behalf Of Martin Margraf
> Sent: June 14, 2006 5:34 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: change cpu=5Ffreq
>=20
> hi,
>=20
> how can i change the cpu frequency of my osk5912 using the
> scale=5Fcpu=5Ffreq feature of the 2.6.16 kernel=3F how is the syntax of this=3F=20
> is there a documentation available (except the ones in the documentation=

> folder of my linux directory)=3F
>=20
> my next question is, how can i read/write to the regs of the omap5912=3F=20
> during using 2.4 kernel i was able to access the regs directly with a
> module. but now with 2.6 kernel i get a segmentation fault. maybe
> someone can help me=3F
>=20
> regards
>=20
> martin
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/=3Fmc=3D100071&distributionid=3D000000000071
