From: <aravind.boinpally@wipro.com>
Subject: *** No rule to make target `omap_2430sdp_deconfig'.  Stop.
Date: Fri, 12 Oct 2007 12:38:23 +0530
Message-ID: <FBD03D6DFE9D7C4893187AAE6DD77F0C1079C8@BLR-SGM-MSG01.wipro.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi...
=20
I am trying to compile the 2.6 kernel.I followed the following steps for
compilation.
=20
First i have made clean by using=20
=20
 make ARCH=3Darm
CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
clean
=20
then i configured the board for OMAP2430 using
=20
 make ARCH=3Darm
CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
omap_2430sdp_deconfig
=20
But after doing this i am getting error like=20
=20
=20
make[1]: *** No rule to make target `omap_2430sdp_deconfig'.  Stop.
make: *** [omap_2430sdp_deconfig] Error 2
=20
=20
can u please suggest me what went wrong???
=20
Thanking you.
=20
