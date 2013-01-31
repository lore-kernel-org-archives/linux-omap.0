From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 18:19:59 +0530
Message-ID: <510A6877.9080307@ti.com>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk> <20130131030203.GA8374@quad.lixom.net> <alpine.LFD.2.02.1301302312030.6300@xanadu.home> <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131104044.GO2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab3AaMt3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 07:49:29 -0500
In-Reply-To: <20130131104044.GO2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 31 January 2013 04:10 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 31, 2013 at 09:20:24AM +0000, Russell King - ARM Linux wrote:
>> On Wed, Jan 30, 2013 at 11:19:40PM -0500, Nicolas Pitre wrote:
>>> Better yet (IMHO): just enable the zboot command in U-Boot to let you
>>> boot a zImage binary directly.
>>
>> I wish it were that easy but it isn't.  I've no idea where to get a
>> version of uboot for my boards which supports that; TI have always
>> supplied updates to uboot for me, and with the current state of TI
>> being afaict in chaos.
>>
>> TI have always supplied a replacement X-Loader with each uboot update.
>> I've no idea what X-Loader is or why both get updated together, but...
>>
>> Moreover, I doubt that the 3430LDP, of which there are multiple versions,
>> will ever see a uboot update.  It already suffers from a lack of correct
>> kernel support due to random wiring changes between these versions (the
>> keypad doesn't work correctly) and I've yet to indentify which version
>> it is despite downloading the circuits.  So trying to locate the right
>> uboot will be impossible there.
>>
>> So, I'm _stuck_ with uImages for these platforms.
>
> Right, so I'm now passing LOADADDR= which allows this to work - and the
> latest OMAP4430SDP boot result shows almost the same sad broken story.
>
I just tried latest mainline (commit: 04c2eee5) and default config
just boots fine.

I was looking at your build system output which shows the boot
state "OMAP4430 SDP: fail". Your config seems to be with
CONFIG_ARCH_MULTIPLATFORM=y and indeed this kernel doesn't
boot. Seems to abort very early in boot. Am looking at it.

Regards,
Santosh

P.S Btw, the load address issue with multi-platform build
was highlighted on the list in past by Tony [1]

[1] http://www.spinics.net/lists/linux-omap/msg84146.html

