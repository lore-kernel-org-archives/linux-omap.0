From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Wed, 02 Oct 2013 13:14:35 +0200
Message-ID: <524C001B.8040901@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com> <1380634797-29541-3-git-send-email-zonque@gmail.com> <20131002104910.GD16680@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:64944 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab3JBLPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 07:15:15 -0400
In-Reply-To: <20131002104910.GD16680@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 02.10.2013 12:49, Sebastian Andrzej Siewior wrote:
> * Daniel Mack | 2013-10-01 15:39:54 [+0200]:
> 
>> Make musb_port_suspend() externally available, and call it when to host
>> goes into suspend. This allows the core to go into suspend while a
>> device is connected.
> 
> Sorry for asking this stupid question but what is usally happening when
> the host goes to suspend and a device is connected? I think it is
> disconnected & re-enumerated and resume and this not what you want,
> right?

It is usually put into USB suspend and the host preserves its state.
After resume, the usb storage driver, for example, will not register new
partitions but expect things to be as they were before. That is, your
previously mounted devices remain functional.

However, the enumeration process has to be done again, because when the
device looses power, it can't memorize its address.

> What happens if the device is unplugged while the host is suspended and
> not there on resume?

That condition is detected and a full teardown of the connected drivers
is conducted. Try what happens on your notebook when you do that.
Embedded systems should behave just the same.


Daniel
