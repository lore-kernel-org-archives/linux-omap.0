From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: RE: change cpu_freq
Date: Thu, 15 Jun 2006 12:19:15 -0600
Message-ID: <1A1CA1A4CD7D304485214EBCCAEE0A010A53F4@BBSC-EX01.bbsconnect.ca>
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
To: Martin Margraf <m_margraf@web.de>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Martin,

You can select userspace governor for cpu_freq and change
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed value
to change the cpu frequency.

Regards,

Minjie
=20

-----Original Message-----
From:
linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@linux.omap.=
c
om
[mailto:linux-omap-open-source-bounces+mlin=3Dempowertechnologies.com@lin=
u
x.omap.com] On Behalf Of Martin Margraf
Sent: June 14, 2006 5:34 AM
To: linux-omap-open-source@linux.omap.com
Subject: change cpu_freq

hi,

how can i change the cpu frequency of my osk5912 using the
scale_cpu_freq feature of the 2.6.16 kernel? how is the syntax of this?=20
is there a documentation available (except the ones in the documentation
folder of my linux directory)?

my next question is, how can i read/write to the regs of the omap5912?=20
during using 2.4 kernel i was able to access the regs directly with a
module. but now with 2.6 kernel i get a segmentation fault. maybe
someone can help me?

regards

martin
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
