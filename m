From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: PROBLEMS WITH DNS
Date: Mon, 11 Jun 2007 12:35:29 +0100
Message-ID: <466D3381.1070304@grupopie.com>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
	<4669A194.8090108@mbdsys.com> <4669A88D.4070008@grupopie.com>
	<200706082132.37911.hjk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200706082132.37911.hjk@linutronix.de>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hans-Jürgen Koch wrote:
> Am Freitag 08 Juni 2007 21:05 schrieb Paulo Marques:
> 
>> The only other argument I can see for in-kernel dhcp is that it is 
>> easier to configure than it is to setup an initramfs filesystem. As soon 
>> as that problem is somehow solved, I don't see the advantage in keeping 
>> the in-kernel version.
> 
> Please don't forget the people who mount their root file system via NFS.
> I'd say this is the main reason for having DHCP in the kernel.

I can't forget about them, since I'm one of them ;)

initramfs is built _into_ the kernel image, so it is as available as the 
kernel image itself.

The great thing about having initramfs mounting your root filesystem is 
that it is much more flexible than the kernel can ever be. You can, for 
instance, setup an ssh tunnel into the nfs server and mount your root 
file system through there.

There is no ending to the options you have with user space. The problem 
is that the really simple setups that are today handled internally by 
the kernel would require more work to setup :(

-- 
Paulo Marques - www.grupopie.com

"As far as we know, our computer has never had an undetected error."
Weisert

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
