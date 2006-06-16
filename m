From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: RE: change cpu_freq
Date: Fri, 16 Jun 2006 17:35:50 -0600
Message-ID: <1A1CA1A4CD7D304485214EBCCAEE0A010A53F5@BBSC-EX01.bbsconnect.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Martin Margraf <m_margraf@web.de>, Minjie Lin <MLin@EmpowerTechnologies.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 Hi Martin,

 just use "echo value > /sys/devices..../scaling_setspeed"

 Minjie


-----Original Message-----
From: Martin Margraf [mailto:m_margraf@web.de]=20
Sent: June 15, 2006 11:41 PM
To: Minjie Lin
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: change cpu_freq

hi minjie,

thanks for the answer.
how is the syntax of this? like "echo scaling_setspeed=3Dvalue > =
/sys/devices...." ?

martin

> -----Urspr=FCngliche Nachricht-----
> Von: "Minjie Lin" <MLin@EmpowerTechnologies.com>
> Gesendet: 15.06.06 20:19:01
> An:  <linux-omap-open-source@linux.omap.com>
> Betreff: RE: change cpu_freq


> Hi Martin,
>=20
> You can select userspace governor for cpu_freq and change=20
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed value to change=20
> the cpu frequency.
>=20
> Regards,
>=20
> Minjie
> =20
>=20
> -----Original Message-----
> From:
> =
linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@linux.omap
> linux-omap-open-source-bounces+.c
> om
> =
[mailto:linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@li
> nu x.omap.com] On Behalf Of Martin Margraf
> Sent: June 14, 2006 5:34 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: change cpu_freq
>=20
> hi,
>=20
> how can i change the cpu frequency of my osk5912 using the=20
> scale_cpu_freq feature of the 2.6.16 kernel? how is the syntax of =
this?
> is there a documentation available (except the ones in the=20
> documentation folder of my linux directory)?
>=20
> my next question is, how can i read/write to the regs of the omap5912? =

> during using 2.4 kernel i was able to access the regs directly with a=20
> module. but now with 2.6 kernel i get a segmentation fault. maybe=20
> someone can help me?
>=20
> regards
>=20
> martin
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source


_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=3D100071&distributionid=3D000000000071
