From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: PROBLEMS WITH DNS
Date: Fri, 8 Jun 2007 21:32:37 +0200
Message-ID: <200706082132.37911.hjk@linutronix.de>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
	<4669A194.8090108@mbdsys.com> <4669A88D.4070008@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4669A88D.4070008@grupopie.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Am Freitag 08 Juni 2007 21:05 schrieb Paulo Marques:

> 
> The only other argument I can see for in-kernel dhcp is that it is 
> easier to configure than it is to setup an initramfs filesystem. As soon 
> as that problem is somehow solved, I don't see the advantage in keeping 
> the in-kernel version.

Please don't forget the people who mount their root file system via NFS.
I'd say this is the main reason for having DHCP in the kernel.

Hans


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
