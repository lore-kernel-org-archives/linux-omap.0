From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: OSK5912 Deep Sleep
Date: Sun, 21 May 2006 18:49:38 -0500
Message-ID: <772F5D89C5E0734B8A86D85DFC6A2024035E9DA0@dlee03.ent.ti.com>
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
To: Martin Margraf <m_margraf@web.de>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> is the 2.4 kernel the wrong one and i should use 2.6
> kernel?

 As far as I remember, the MontaVistga's "preview kit" was
sort of evaluation copy based on kernel 2.4, which excludes=20
the power management. You can either

 - Purchase the CEE (Consumer Electronics Edition) package from
 MontaVista, with the professional support service.

 or

 - Upgrade the open-source version of kernel 2.6.

 Regards,
 Ishigami
=20
-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Martin Margraf
Sent: Friday, May 19, 2006 7:35 PM
To: linux-omap-open-source@linux.omap.com
Subject: OSK5912 Deep Sleep

hi matthew,

thanks for your answer.
i tried what you told me, but i got this message from the shell: cannot=20
create /sys/power/state: No such file or directory
so i looked for the sys directory and found it in /usr/include/sys, is=20
this the right one?
may i have to export it to PATH? or is the 2.4 kernel the wrong one and=20
i should use 2.6 kernel?
you have to excuse me, but i am a total newbie to embedded linux. its=20
the first time i use it. ;)

martin
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
