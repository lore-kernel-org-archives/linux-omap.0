From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Bug? - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Fri, 06 Oct 2006 12:43:35 +0200
Message-ID: <45263357.7090700@gmail.com>
References: <CC7B089C59ED6841BAE28F1EA69A854387372B@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A854387372B@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Sideleau, Scott R" <srs@WPI.EDU>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Sideleau, Scott R wrote:
> When trying to build the 2.6.18-omap1 kernel with the frame buffer support
> option for the OSK selected, the build fails while trying to compile
> ".../drivers/video/omap/omapfb_main.c" with numerous errors.
> 
> I selected frame buffer support as shown at the "OSK for Dummies" web site
> (albeit without the "OMAP internal LCD controller support" option checked as
> it apparently no longer exists)...
> 
> http://oskfordummies.hp.infoseek.co.jp/howto/lcd.html
> 
> Has anyone successfully built the 2.6.18-omap1 kernel with frame buffer
> support?

With patch I sent some minutes ago most recent git works for 
me on OSK with frame buffer and Mistral LCD.

Do you use recent git? What are your errors?

I use

CONFIG_OMAP_OSK_MISTRAL=y
CONFIG_VIDEO_V4L2=y
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_OMAP=y
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
CONFIG_FB_OMAP_DMA_TUNE=y

Cheers

Dirk
