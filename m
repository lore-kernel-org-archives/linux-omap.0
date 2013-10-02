From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Wed, 02 Oct 2013 14:12:04 +0200
Message-ID: <524C0D94.8050100@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com> <1380634797-29541-3-git-send-email-zonque@gmail.com> <20131002104910.GD16680@linutronix.de> <524C001B.8040901@gmail.com> <524C0B0D.3020300@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:40377 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3JBMMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 08:12:14 -0400
In-Reply-To: <524C0B0D.3020300@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 02.10.2013 14:01, Sebastian Andrzej Siewior wrote:
> On 10/02/2013 01:14 PM, Daniel Mack wrote:
>> On 02.10.2013 12:49, Sebastian Andrzej Siewior wrote:

>>> What happens if the device is unplugged while the host is suspended and
>>> not there on resume?
>>
>> That condition is detected and a full teardown of the connected drivers
>> is conducted. Try what happens on your notebook when you do that.
>> Embedded systems should behave just the same.
> 
> I had the feeling that the USB device gets disconnected and
> re-enumerated on resume.

Yes. The device looses its +5V power supply, so it has to be reset and
re-enumerated on resume of course. It's just that USB drivers know about
the state the device has to be put back into after resume, and don't
assume the device was disconnected and reconnected. The latter would
(for usb-storage) also cause paritions to be removed and added.

> But if you say that the ehci-hcd saves the
> state and keeps the device connected if it wasn't disconnected during
> suspend then there is no reason for musb to behave differently.

Which it doesn't with my patches applied. I can mount a USB volume, put
the system into suspend and access the contents after resume. Just the
way it should be :)


Daniel

