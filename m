From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] camera: c99 style structure
Date: Tue, 22 Nov 2005 21:39:30 -0800 (PST)
Message-ID: <20051123053930.43841.qmail@web32904.mail.mud.yahoo.com>
References: <304D2A85A9643F4A991BDDF8D297BBA60181A903@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA60181A903@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--- "Zhang, Jian" <jzhang@ti.com> wrote:

> I think it is as simple as a bunch of board files in the same
> directory
> (drivers/media/video/omap2420). They don't need to go to
> arch/arm/mach/
> directory. I believe OMAP1 frame buffer driver takes this
> approach.

No, Imre has added OMAP2 fb support without creating new omap2
directory under drivers/video directory. But I was thinking to create
files under drivers/media/video/omap directory like
sensor_power_h2/h4/<custom board name> to export powerup/down function
related to sensors based on board interface.

Also while porting omap24xx camera interface, I want to keep the same
camera_core and sensor interface as you had suggested earlier.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
