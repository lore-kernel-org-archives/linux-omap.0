From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 7/9] ARM: OMAP: omap_device: Add APIs to enable and
 idle hwmods
Date: Thu, 8 Aug 2013 10:26:12 -0400
Message-ID: <5203AA84.4080404@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37606 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965190Ab3HHO0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 10:26:36 -0400
In-Reply-To: <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Needed to let the AM335x PM handle the IPs which need forced
> standby transition during every suspend-resume cycle when
> the corresponding driver is not compiled into the kernel.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/omap_device.c |    8 ++++++++
>  arch/arm/mach-omap2/omap_device.h |    2 ++
>  2 files changed, 10 insertions(+)
> 
The interface might be sane but the need of force standby
is just non-sense. Why can't we take care of this in
firmware itself. Linux doesn't need to know about it.
More comments on this in other patch where it is being used.

Regards,
Santosh

