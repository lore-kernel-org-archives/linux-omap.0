From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: is the OMAP5912 support boot by NAND flash?
Date: Tue, 29 Nov 2005 08:59:11 +0900
Message-ID: <0IQO00KJ3VYNYG@mmp1.samsung.com>
References: <000601c5f425$61215970$0801a8c0@andy>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <000601c5f425$61215970$0801a8c0@andy>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'andy' <andy.lu@serialsys.com.hk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
