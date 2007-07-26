From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC 1/2] MMC/SD Controller driver for OMAP2430
Date: Thu, 26 Jul 2007 15:49:39 +0530
Message-ID: <002e01c7cf6e$7bbf5f40$9f8818ac@ent.ti.com>
References: <20070726095717.GC27453@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20070726095717.GC27453@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, "'Syed Mohammed, Khasim'" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, 'Pierre Ossman' <drzeus@drzeus.cx>
List-Id: linux-omap@vger.kernel.org

OMAP2430 has a new MMC controller. The MMC controller register sets between
2430 and 2420/16xx doesn't match. 

So I guess modifying the existing omap driver to support a new controller is
not be a good idea, and will make the code messy.

Regards,
Madhu

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Russell
King - ARM Linux
Sent: Thursday, July 26, 2007 3:27 PM
To: Syed Mohammed, Khasim
Cc: linux-omap-open-source@linux.omap.com;
linux-arm-kernel@lists.arm.linux.org.uk; Pierre Ossman
Subject: Re: [RFC 1/2] MMC/SD Controller driver for OMAP2430

On Wed, Jul 25, 2007 at 07:17:06PM -0500, Syed Mohammed, Khasim wrote:
> I am hereby presenting MMC/SD controller driver for OMAP 2430. It has
> been validated for SD/MMC (3v) cards on 2430 (ES 2.1) SDP V4.0.

Also, please explain how this is different to the existing omap driver,
and why the existing omap driver can not support this.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
