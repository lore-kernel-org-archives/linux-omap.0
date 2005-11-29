From: "andy" <andy.lu@serialsys.com.hk>
Subject: RE: is the OMAP5912 support boot by NAND flash?
Date: Tue, 29 Nov 2005 08:25:45 +0800
Message-ID: <002901c5f47b$73bb32d0$0801a8c0@andy>
References: <0IQO00KJ3VYNYG@mmp1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <0IQO00KJ3VYNYG@mmp1.samsung.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear Kyungmin,

Did you mean that I can use NOR interface and configure to NAND =
protocol?

Best Regards
Andy Lu

-----Original Message-----
From: Kyungmin Park [mailto:kyungmin.park@samsung.com]=20
Sent: Tuesday, November 29, 2005 7:59 AM
To: 'andy'; linux-omap-open-source@linux.omap.com
Subject: RE: is the OMAP5912 support boot by NAND flash?

Hi

> Is the OMAP5912 support boot by NAND flash , Please =A3=BF
>=20

Since OMAP5912 don't have a NAND or OneNAND flash, we need some daughter
board,

First check the following URL.

http://source.mvista.com/git/gitweb.cgi?p=3Dxloader.git;a=3Dlog

Now OMAP5912 can boot with OneNAND instead of NAND

But IMHO It can also boot with NAND.

Regards

Kyungmin Park
