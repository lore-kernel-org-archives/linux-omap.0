From: <aravind.boinpally@wipro.com>
Subject: Reg X-loader  compilation Problem
Date: Fri, 21 Sep 2007 18:44:36 +0530
Message-ID: <19B9278CA74D6D4B889A1687EE639202079559@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi all,
=20
I am facing compilation problem with X-loader.
=20
I have downloaded the X-loader from Linux.omap.com ""x-load_11SEP.tgz"".
=20
Then I have untarred it and changed the ""include/configs/om  file for
ONENAND support.
=20
After this I tried to compile this using cross tool chain
"arm-none-Linux-gnueabi-" ,but after doing this i am getting=20
=20
error like=20
=20
""error: unrecognized command line option "-mapcs-32""".
=20
can some one suggest me what could be the problem.
=20
is it problem with tool chain.???
=20
I compiled this code using make3.80 tool.
=20
but when i compiled with make 3.81 also same problem ..

and also version of gcc is 4.1.1
=20
Please give me some inputs
thanking you.
=20
