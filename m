From: "Ola Helm" <ola.hel@gmail.com>
Subject: V4L2 back to V4L1
Date: Wed, 19 Apr 2006 16:09:01 +0300
Message-ID: <3d3153f60604190609k7d218c10mfcbc64cf930c75ac@mail.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

May be - sort to say a bit out of the scope - but has anybody done anything
related to backward compatibility of V4L2 (v4l1-compat.c). To me, it seems
to be compiled, but application using video 4 linux version 1, does not see=
m
to work. V4L2 application works nicely. In practise it stops to first
VIDIOCGCAP capability call since it does not find it or related parameters.

/Ola
