From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 10:51:52 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98DEEA@DBDE01.ent.ti.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
 <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
 <CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
 <CAMQu2gz9SGDwE3p1oREb8h+1RUpd1h6yOEJCRJ52PCSY1w0=yQ@mail.gmail.com>
 <CACVXFVOA=EDJR6HqBRRegr13nTnNdjGSvQUwek2jbu41C5euWA@mail.gmail.com>
 <CAMQu2gwzZ7dGW9xMNvTXqB8k3cfJuVF+a2cCVXLn4q92+W3aGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47475 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab2ERKwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 06:52:08 -0400
In-Reply-To: <CAMQu2gwzZ7dGW9xMNvTXqB8k3cfJuVF+a2cCVXLn4q92+W3aGQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Hi Santosh,

On Fri, May 18, 2012 at 15:43:31, Shilimkar, Santosh wrote:

> On the side note, looks like GMPC too needs to be converted
> to sparse IRQ since it seems to be creating a dummy irqchip
> and dispatching secondary handlers based on chip selects.

GPMC dummy chip is being modified to so that irq descriptors are created
dynamically [1], with a final goal of reaching something similar to [2],
please let me know if any comments on those.

Hi Ming,

Requesting irq is called by driver of IP, while whether it is shared or
not depends on SoC where IP lives, so ideally it seems platform should
inform the driver whether it is shared & driver should do what platform
tells. Or else to be safe, it should be made shared always ?

This may not make much sense now w.r.t gpmc, but would be applicable
once gpmc becomes a driver (undergoing conversion), but may not be that
important as there are no SoCs presently sharing gpmc interrupt (afaik)

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68745.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67496.html

