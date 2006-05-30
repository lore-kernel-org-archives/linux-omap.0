From: prakhar vig <aquarian_133@yahoo.co.in>
Subject: How to use ISRAM as a framebuffer?
Date: Tue, 30 May 2006 10:02:02 +0100 (BST)
Message-ID: <20060530090202.12715.qmail@web8705.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

I am working on OMAP1610(ARM + C55x DSP)
am trying to access framebuffer to get the input
image data.I have some doubts regarding this manner.
First of all i want to know whether
I have two choices for mapping my frame buffer i.e
1. Map the frame buffer to ISRAM
2. Map the frame buffer to SDRAM.

Which is the optimized way to get the image data from
the frame buffer. Also do i need to use DMA calls to
make this data transfer faster?

If i perform the frame buffer access from ARM
side(using ISRAM), then do i need to make DMA calls??

Thanks and regards,
Prakhar.


Send instant messages to your online friends http://in.messenger.yahoo.com 
