From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
Date: Wed, 13 Jun 2012 11:28:53 -0500
Message-ID: <4FD8BFC5.2050007@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com> <4FD78D93.9080906@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E99884F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39459 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab2FMQ2x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 12:28:53 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99884F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/13/2012 01:10 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, Jun 13, 2012 at 00:12:27, Hunter, Jon wrote:
> 
>> I am still wondering if we should warn against multiple devices using
>> the wait pin. I see that if could be valid to have multiple memory
>> devices of the same type using the WP pin spanning multiple CS. However,
>> in that case would/should the memory devices be registered as a single
>> child? If so then we could still impose a policy of only one child
>> device using the WP.
> 
> Presently there are no peripherals in mainline turning on writeprotect,
> initially intention was to just disable writeprotect at the end of probe
> and not provide platforms opportunity to enable writeprotect as none
> need it, still a provision has been provided for platform to enable it.
> 
> Probably these to be taken care when there is a requirement.

Ok, but I am still not happy about this. So I did find that our
omap2420h4 board does route the write protect to both NOR and NAND.
Therefore, it does appear to be a valid use-case that multiple child
devices can share the write-protect. So maybe we do not need to reserve
the write-protect like we are doing for chip-selects, but I think that
devices should indicate if they use the write-protect pin and we should
either have this "enable on boot" as a global setting not specific to a
child device or ensure that multiple devices using the wp have the same
configuration of the wp on boot. In other words, if one device says
enable on boot and the other does not, then warn.

Cheers
Jon
