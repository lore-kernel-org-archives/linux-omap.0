From: "maia grotepass" <maiatoday@gmail.com>
Subject: falsh images disapearing OSK5912 starter kit
Date: Tue, 11 Jul 2006 15:02:23 +0200
Message-ID: <70275cc60607110602v1bac84fcrbd6c148252fd0cc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I have just started playing with OSK5912. It keeps losing the kernel image
and the filesystem. I manage to load the factory default kernel and file
system from the cd over the ethernet using tftpboot. I can see the kernel
and the image in memory. If I call bootm 0x100000 it starts up correctly but
if I cycle the power it boots into U-boot and I can no longer see the kernel
when I do md 0x100000.

I seem to have more success if I unplug the ethernet when I power cycle.

So far i am blaming the hardware. :)

any suggestions, is there something I could try perhaps?

Maia
