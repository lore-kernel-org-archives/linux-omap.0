From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: RE: Changing Clock to 182MHz (14 x 13MHz) on OMAP5912...
Date: Tue, 15 Aug 2006 16:57:49 -0300
Message-ID: <9268368b0608151257x1563a5d8q864efe3ea86fccc6@mail.gmail.com>
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
To: danilo.caravana@gmail.com
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Danilo,

It seems that there is this option vailable in the <make menuconfig>,
once there is this clock speed in the arch/arm/mach-omap1/clock.h
file:

#if defined(CONFIG_OMAP_ARM_182MHZ)
 { 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
#endif

Take a look at OSK configuration in it.

Regards,

Daniel


> Hi all,
>
> I have an OMAP 5912, and I need a 14 x 13MHz (182MHz) instead of 16
> x 12MHz (192MHz) kernel... What can i do to add this option when i
> build the Kernel???

> Tkanks...

> Danilo
