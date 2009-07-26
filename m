From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM TCM (Tightly-Coupled Memory) support v2
Date: Sun, 26 Jul 2009 21:03:36 +0100
Message-ID: <20090726200335.GA11193@n2100.arm.linux.org.uk>
References: <1246487361-14610-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1246487361-14610-1-git-send-email-linus.walleij@stericsson.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Linus Walleij <linus@df.lth.se>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 02, 2009 at 12:29:21AM +0200, Linus Walleij wrote:
> I use the addresses at 0xffff2000 and 0xffff4000 in the
> U300 architecture for mapping the TCM with a one-to-one
> memory map. This is "reserved" in Russells map, good
> suggestions on where else to put this 0x4000 block is
> welcome.

memory.txt needs to be updated with the usage for ARMv6+ CPUs - the
space from 0xffff4000-0xffffffff is used to handle cache aliasing
on v6 and v7 CPUs.

While 0xffff4000 would be safe on ARM926, it isn't safe on later CPUs.

Not currently sure where-else to put this at present.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
