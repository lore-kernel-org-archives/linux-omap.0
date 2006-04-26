From: "Ola Helm" <ola.hel@gmail.com>
Subject: H4-2420 Serial port handling
Date: Wed, 26 Apr 2006 17:04:13 +0300
Message-ID: <3d3153f60604260704t4593697eia9a7fa3d6415e3c0@mail.gmail.com>
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

Does anybody has got an ideas how do the mapping / handling of serial ports
with 2420 goes when compared the Gitversion and the one in omap/pub? The
Gittree version seems to handle all ports similar way (all are ST16654
ports) but omap/pub kernel treats the ttyS0 different way than others (ttyS=
0
is ST16654, others ST16650V2). The main cause of this seems to be in static
int size_fifo. TtyS0 gets value 64 from there (basically count value is 64)=
,
others get 0.

/O
