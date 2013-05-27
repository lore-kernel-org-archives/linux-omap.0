From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2 2/2] ARM: dts: omap3-igep0030: Add NAND flash support
Date: Mon, 27 May 2013 10:50:30 +0200
Message-ID: <51A31E56.4020101@collabora.co.uk>
References: <1368214859-23558-1-git-send-email-javier.martinez@collabora.co.uk> <51A31BFE.7090908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:48067 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab3E0Iun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 May 2013 04:50:43 -0400
In-Reply-To: <51A31BFE.7090908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 05/27/2013 10:40 AM, Benoit Cousson wrote:
> Hi Javier,
>

Hi Benoit,

> On 05/10/2013 09:40 PM, Javier Martinez Canillas wrote:
>> The IGEP COM Module has an 512MB NAND flash memory.
>> 
>> Add a device node for this NAND and its parition layout.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> 
>> Changes since v1:
>>  - I just realized that sent a wrong version of the patch, sorry for the noise
> 
> And what about the first one? For igep0020?
> 
> Thanks,
> Benoit
> 

For the igep0020 the first one was already correct. I just sent the wrong one
for the igep0030 and that's why I had to send a v2 for this patch. Sorry for the
confusion.

Best regards,
Javier
