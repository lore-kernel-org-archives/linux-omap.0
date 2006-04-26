From: "RAVI SHANGAR" <ravishangar@gmail.com>
Subject: Delay in loading Qtopia or Qt Applications from jffs ported to OMAP
	1510
Date: Wed, 26 Apr 2006 18:59:33 +0530
Message-ID: <ade4abe50604260629p24df19aco3b53db16127c7674@mail.gmail.com>
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

We made jffs2 along with Qtopia and Qt applications and ported it to OMAP
1510.

When we try to execute the applications from NFS, there is no delay.

But, when executing from the jffs2 filesystem, we get more than 10 min dela=
y
in starting the application fully.

We enabled in kernel menuconfig with I-cache D-cache and Clock as 168 MHz.

Please give a solution to minimize delay by any means.

Regards,
Ravishangar.K
