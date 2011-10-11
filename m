From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/8] ti814evm: Add support for musb interface
Date: Tue, 11 Oct 2011 13:55:32 +0200
Message-ID: <4E942EB4.6030004@compulab.co.il>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com> <1318332369-9732-5-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:53449
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751918Ab1JKLzk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 07:55:40 -0400
In-Reply-To: <1318332369-9732-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Ravi Babu <ravibabu@ti.com>

Hi Ajay,

On 10/11/11 13:26, Ajay Kumar Gupta wrote:
> From: Ravi Babu <ravibabu@ti.com>
> 
> Adding musb support in ti814 EVM board file.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/board-ti8148evm.c |    9 +++++++++

This file does not exist and probably will not exist in the future,
see [1] and [2].
So this patch can be dropped.
Your 3/8 patch provides the support for both boards.

[1] - http://www.spinics.net/lists/linux-omap/msg58348.html
[2] - http://www.spinics.net/lists/arm-kernel/msg143915.html

-- 
Regards,
Igor.
