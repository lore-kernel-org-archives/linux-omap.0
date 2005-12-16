From: RAVI SHANGAR <ravishangar@gmail.com>
Subject: OMAP 1510 - Linux Root file system
Date: Fri, 16 Dec 2005 11:01:53 +0530
Message-ID: <ade4abe50512152131k4c72499dxe366132c515c708b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I use kernel version 2.4.19 with patch-2.4.19-rmk7 and
patch-2.4.19-rmk7-omap1.I use glibc-2.2.3, binutils-2.12.1 and gcc-2.95.3 T=
he
target is OMAP1510. With this build, i dont get a compatible root file
system for the target. Due to the incompatibility, keyboard, touch screen
and mouse are not enabled eventhough the proper drivers are loaded.

How do I build a compatible root file system? Is there any root file system
freely available?
