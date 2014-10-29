From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Wed, 29 Oct 2014 15:33:53 +0200
Message-ID: <5450ECC1.10701@ti.com>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com> <1414420445-9020-1-git-send-email-frans.klaver@xsens.com> <544F6611.1000801@ti.com> <20141029113612.GA2499@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932729AbaJ2NeT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2014 09:34:19 -0400
In-Reply-To: <20141029113612.GA2499@ci00147.xsens-tech.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Brian Norris <computersforpeace@gmail.com>, =?UTF-8?B?RXplcXVpZWwgR2Fy?= =?UTF-8?B?Y8OtYQ==?= <ezequiel@vanguardiasur.com.ar>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On 10/29/2014 01:36 PM, Frans Klaver wrote:
> On Tue, Oct 28, 2014 at 11:46:57AM +0200, Roger Quadros wrote:
>> On 10/27/2014 04:34 PM, Frans Klaver wrote:
>>> Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
>>> omap_elm"), I don't have any mtd devices present on my am335x. This
>>> changes the link order of the omap_elm and omap2 objects, causing them
>>> to probe in the wrong order.
>>>
>>> To fix this, make elm_config defer probing until the omap_elm driver is
>>> actually loaded.
>>>
>>> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
>>
>> Acked-by: Roger Quadros <rogerq@ti.com>
> 
> Thanks. How about Ezequiel's remark about doing both changes?

I don't have any strong feeling for or against it. We shouldn't be depending on module load order anyways.

cheers,
-roger
