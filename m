From: wangpeng <wangpengnorman@gmail.com>
Subject: why i can't set the RTC_CTRL_REG.SPLIT_POWER bit to 1
Date: Fri, 19 May 2006 17:39:11 +0800
Message-ID: <29bc648b0605190239g40315127vdde5b9bdc7658aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

i am using osk5912. i want to test the split power function of omap5912.
so i use ccs3.1 view->memory window option to set the
RTC_CTRL_REG.SPLIT_POWER bit to 1,
which is at addr 0xfffb4840.
but the  RTC_CTRL_REG.SPLIT_POWER bit is always read as 0.
why?
