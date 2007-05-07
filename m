From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Unable to compile Linux 2.6.21 from source.mvista.com
Date: Mon, 7 May 2007 19:29:39 +0530
Message-ID: <61445c750705070659v1d2fd55akbd8ed2d1108459f9@mail.gmail.com>
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

Hi

I am latest 2.6.21 source from source.mvista.com. I am trying to compile the
kernel for my omap 850 based board.

I am getting following error:

1. make ARCH=arm omap_perseus2_730_defconfig => works well

2. make ARCH=arm

CC      drivers/video/omap/lcd_p2.o
drivers/video/omap/lcd_p2.c:151:39: ../drivers/ssi/omap-uwire.h: No such
file or directory
drivers/video/omap/lcd_p2.c: In function `p2_panel_enable':
drivers/video/omap/lcd_p2.c:185: warning: implicit declaration of function
`omap_uwire_configure_mode'
drivers/video/omap/lcd_p2.c:187: warning: implicit declaration of function
`omap_uwire_data_transfer


There is no file like ../drivers/ssi/omap-uwire.h, I have checked. Please
enlighten.
