From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: Make ISA ports optional
Date: Thu, 08 Jan 2015 11:11:51 -0500
Message-ID: <54AEAC47.1040403@hurleysoftware.com>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com> <20150108131008.16c9a31c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:57755 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbbAHQL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 11:11:57 -0500
Received: by mail-qg0-f53.google.com with SMTP id l89so2864809qgf.12
        for <linux-omap@vger.kernel.org>; Thu, 08 Jan 2015 08:11:56 -0800 (PST)
In-Reply-To: <20150108131008.16c9a31c@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>

On 01/08/2015 08:10 AM, One Thousand Gnomes wrote:
> On Mon,  5 Jan 2015 22:09:45 -0500
> Peter Hurley <peter@hurleysoftware.com> wrote:
> 
>> Some arches have no need to create unprobed 8250 ports; these phantom
>> ports are primarily required for ISA ports which have no probe
>> mechanism or to provide non-operational ports for userspace to
>> configure (via TIOCSSERIAL and TIOCSERCONFIG ioctls).
>>
>> Provide CONFIG_SERIAL_8250_PHANTOM_UARTS knob to disable phantom port
>> registration; ie., CONFIG_SERIAL_8250_PHANTOM_UARTS=N only registers
>> probed ports (ACPI/PNP, "serial8250" platform devices, PCI, etc).
> 
> Just #define serial8250_isa_devs to 0 on such platforms. gcc should then
> be bright enough to do the rest for you.

Well, this patch has the "advantage" of allowing the user to override
the config and create blank ports anyway.

That said, I'm exploring a completely different approach: I've split the
driver from the port operations. The idea being that the existing
"universal" driver supports everything it does now, while allowing for
a new driver(s) to only support a subset.

At this point, I've only done the actual split. So the "universal" driver
module has:
 * ISA/"serial8250" platform driver
 * PNP init
 * uart driver and console definitions
 * all the existing module parameters
 * all the globals (except the const uart_config[] table)
 * RSA port handling
 * Chained interrupt handling
 * port i/o by timer handling
 * early_serial_setup()
 * sun ttyS shared registration
 * serial8250_ports[] table and how it re-uses existing ports

The "universal" driver also has the sub-driver interface, which is:
 * serial8250_register_8250_port
 * serial8250_unregister_port
 * serial8250_suspend/resume_port
 * serial8250_find_port (hack for 8250_early)
 * serial8250_get_port (hack for runtime pm)

This interface is just storage and minor allocation, since the
port-reuse behavior will be limited to the "universal" driver.
>From a sub-driver perspective, the shared storage is actually
a hindrance, so that reduces the requirement to minor allocation.

And that's where I'm stuck at the moment -- how to share ttyS
minor allocation. ttyS console is a related problem.

Regards,
Peter Hurley
