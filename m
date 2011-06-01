From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/2] OMAP: gpmc-smsc911x: always set irq flags to IORESOURCE_IRQ_LOWLEVEL
Date: Wed, 01 Jun 2011 14:33:57 +0300
Message-ID: <4DE623A5.3080300@compulab.co.il>
References: <cover.1302992702.git.mike@compulab.co.il> <7cf1c52880f0f32922c8973cb90aadcd2e728be1.1302992702.git.mike@compulab.co.il> <20110531103255.GV11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:59800
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752612Ab1FALeC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 07:34:02 -0400
In-Reply-To: <20110531103255.GV11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

On 05/31/11 13:32, Tony Lindgren wrote:

> * Mike Rapoport <mike@compulab.co.il> [110416 15:20]:
>> SMSC911x devices attached to OMAP GPMC always use low level irqs.
>> Setting the appropriate flag in the irq resourse strucure allows using
>> .flags field in the omap_smsc911x_platform_data for driver specific
>> flags
> Looks like this one needs to be refreshed against v3.0-rc1.

Both patches are already in v3.0-rc1... Working late? ;)


-- 
Regards,
Igor.

