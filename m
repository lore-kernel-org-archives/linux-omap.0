From: "XiangyuGu" <guxy@dspchina.com>
Subject: omap on WinCE
Date: Fri, 17 Mar 2006 16:16:22 +0800
Message-ID: <200603170817.k2H8H9YF002986@brazos.ext.ti.com>
References: <304D2A85A9643F4A991BDDF8D297BBA6029A07FC@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA6029A07FC@dlee05.ent.ti.com>
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

Hi, All,

I want to migrating the OS from Linux to WinCE on my OSK5912 board, does
anyone can tell me where to find a WinCE BSP for this board? Thanks=20


Xiangyu Gu
Wintech Digital System Co.
Beijing, China
Ph: 8610-8278-2828 ext.168
Fax: 8610-8278-0028
http://www.wintechdigtal.com
----------------------------

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of =
Zhang,
Jian
Sent: 2006=C4=EA3=D4=C217=C8=D5 7:41
To: Komal Shah; linux-omap-open-source@linux.omap.com
Subject: Fwd: RE: v4l2 camera test app

Komal,

Thanks for sharing. I am attaching the capture sample test code. It is
available at V4L2 site but has a bug. I have fixed it and all 3 modes =
passed
on my camera driver.

Regards,
Jian=20

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of =
Komal
Shah
Sent: Thursday, March 16, 2006 4:25 AM
To: linux-omap-open-source@linux.omap.com
Subject: v4l2 camera test app

Hi All,

As I had received 2-3 emails in the past for simple v4l2 camera capture =
test
application for OMAP, I have attached the one which I have tested with
OMAP2420 TI EVM.

To compile
#arm-linux-gcc -o vcaputre vcam.c

To execute
#./vcaputre -n 20 -m -C cam.dump=20

Enjoy and fix the bugs you find yourself or send me the patch. There are
quite lot of improvments one can do to this app :)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around =
http://mail.
yahoo.com=20
