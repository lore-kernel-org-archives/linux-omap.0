From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: Communication protocol through PCI between host and target
Date: Sat, 3 Jan 2009 15:38:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB67039F@dbde02.ent.ti.com>
References: <c656a4d20901030146t4d894931v91dff04c3eabeb9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46435 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758945AbZACKJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2009 05:09:05 -0500
In-Reply-To: <c656a4d20901030146t4d894931v91dff04c3eabeb9d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>, "linux-pci@vger.kernel.org" <linux-omap@vger.kernel.org>

PCI defines its own communication protocol. Your target firmware should implement the mandatory PCI Config space protocol and what you want to do on accessing the PCI I/O space. At this point of time I think you should ask what type of device is your target going to look like. If your target device falls among one of the standard devices (like network card, sound card etc.) then Linux kernel supports those infrastructure and you do not have to necessarily create /dev nodes (though nothing prevents you to have a non-standard device model for which you can create /dev nodes).

On the other hand, I have seen a non-standard PCI model where a 21555 non-transparent PCI to PCI bridge was used and on top of that a virtual network driver was created. Note that in this case their was no pre-designated master, slave in the bus. You could access the memory of one side from the other through the virtual network interface. You can see this in http://www.kwaak.net/~ard/fotos/epcbin/kernel/celinux-040503.q/Documentation/networking/mvnet.txt though I do not think this type of device is what you have in mind.

Thanks,
-Romit

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of arun c
>Sent: Saturday, January 03, 2009 3:17 PM
>To: linux-pci@vger.kernel.org
>Subject: Communication protocol through PCI between host and target
>
>Hi all,
>
>I am a newbie here please bear with me.
>
>In my custom board the communication between host and target
>should happen through PCI interface.
>
>The target processor runs u-boot, and host processor is running linux.
>
>The target devices will be accessed from the host by /dev nodes.
>
>To reduce the workload on host all the target calls like
>open, read ,write ,ioctl are passed directly to the target.
>
>There will be a common PCI buffer between host
>and target and target will take commands from this buffer
>and execute. The result of executed API also will be put to a shared buffer
>between host and target. [This is what I am planning to implement]
>
>Anybody has come across similar sort of scenario?
>Any ideas or any pointers will be highly appreciated.
>
>Regards,
>Arun C
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

