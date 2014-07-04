From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 1/3] ARM: DRA7: hwmod: Add OCP2SCP3 module
Date: Fri, 4 Jul 2014 12:49:53 +0300
Message-ID: <53B678C1.4000807@ti.com>
References: <1404385274-5093-1-git-send-email-rogerq@ti.com> <1404385274-5093-2-git-send-email-rogerq@ti.com> <alpine.DEB.2.02.1407031948110.1515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1407031948110.1515@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, tony@atomide.com
Cc: rnayak@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul & Tony,

On 07/03/2014 10:48 PM, Paul Walmsley wrote:
> On Thu, 3 Jul 2014, Roger Quadros wrote:
> 
>> This module is needed for the SATA and PCIe PHYs.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
>> Tested-by: Sekhar Nori <nsekhar@ti.com>>
> 
> This looks like adding support for a new device, so, after 
> discussing with Tony, queuing for v3.17.

We should treat it as missing device (bug) rather than new device (feature) as the corresponding device tree node is already present.
Without this patch we get the following message in kernel boot log

[    0.261680] platform 4a090000.ocp2scp: Cannot lookup hwmod 'ocp2scp3'

I would consider this patch as a fix rather than a new feature.

cheers,
-roger
