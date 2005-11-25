From: Ajaya Babu Anne <anneajaya@gmail.com>
Subject: Worst Case ISR latency around 15ms??
Date: Fri, 25 Nov 2005 12:00:03 +0530
Message-ID: <c43be92d0511242230v4c81fe25w58c66aa4c3fba9e7@mail.gmail.com>
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
To: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

I am seeing worst case IRQ latency in Linux up to 15 milli seconds, I am
using 2.6.13 kernel and using JFFS2 file system on OSK board. I am wonderin=
g
any patch available which ensures interrupt latency with in 1/2 milli
seconds or no way in to ensure interrupt latency in the kernel?

I measured interrupt latency as fallows.

I've level sensitive interrupt which is connected to IRQ14 ( GPIO15 ), As
soon as my isr get triggered I mask Level sensitive interrupt so it goes lo=
w
, I am measuring the pulse width, I see most of the time it is around
20-44micro seconds, However I see some times it goes up to 15 miili seconds=
.

Any comments. Why is this so late?

Thanks and Warm Regards,
Ajaya Babu
