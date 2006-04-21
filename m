From: "Li Weichen" <iaadoa@gmail.com>
Subject: OSK RAM damage?
Date: Fri, 21 Apr 2006 10:52:55 +0800
Message-ID: <4448491c.45fa3ac3.3d8f.ffff86aa@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi guys,

I guess the RAM my OSK is damaged!

I have tried mtest command in U-boot for four or five times, after that the
OSK died off, even I pressed reset key it has no reply.  Only the D9 diode
was turned on.

Before this, I was trying the kernel 2.6.16.9 but always met "Unable to
handle kernel paging request at virtual address" error.  And when I used the
former kernels (2.6.14-omap1 is most recently), it had sometimes came up
with segmentation errors.

And further more, when I use the mtest command in U-boot, it shows the
message that "writing..." but without any other information or response.
Does it means that the ram is damaged?

p.s. My OSK is rev.D, and the ram is from ELPIDA.

Regards,


Li Weichen
