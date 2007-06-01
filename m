From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Question regarding OMAP ALSA framework
Date: Fri, 1 Jun 2007 14:56:45 +0530
Message-ID: <61445c750706010226j6786e3b3oe7cf3772861fc9d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello,

I am referring files omap-alsa.c, omap-alsa-dma.c and omap-alsa-xxxx.c
where xxxx is the name of codec (residing in linux/sound/arm/omap/).
As per my understanding the omap-alsa.c and omap-alsa-dma.c are meant
for comman omap specific handling but after going through I realized
that those files are derived from omap15XX based files since dma
chaining support etc is provided which was peculiar for omap15xx (as
per my understanding again!).

So the question is:

Can I use these files as a template for my omap 730 audio driver? Or
any other omap specific driver? Are the drivers supposed to follow the
same framework? Any other pointers will also be useful.

-pharaoh.
