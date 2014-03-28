From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: L2 cache: use macro instead of const
 number
Date: Fri, 28 Mar 2014 16:29:51 +0530
Message-ID: <53355627.5010609@ti.com>
References: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com> <20140328104954.GC27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52804 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaC1LA1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 07:00:27 -0400
In-Reply-To: <20140328104954.GC27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On Friday 28 March 2014 04:19 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 28, 2014 at 02:05:28PM +0530, Sekhar Nori wrote:
>> From: Afzal Mohammed <afzal@ti.com>
>>
>> Its better to use the available macro than 0x1.
>> No functional change.
>>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> This series applies to latest of linux-next/master
> 
> NAK.  See my L2 cache series posted on LAKML which completely removes
> this code.

Okay. Will look at your series now.

Thanks,
Sekhar
