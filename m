From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 4/8] ti814evm: Add support for musb interface
Date: Tue, 11 Oct 2011 20:11:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECCE562F@dbde02.ent.ti.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
 <1318332369-9732-5-git-send-email-ajay.gupta@ti.com>
 <4E942EB4.6030004@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33861 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab1JKOlN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 10:41:13 -0400
In-Reply-To: <4E942EB4.6030004@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "B, Ravi" <ravibabu@ti.com>

Hi Igor,
> 
> On 10/11/11 13:26, Ajay Kumar Gupta wrote:
> > From: Ravi Babu <ravibabu@ti.com>
> >
> > Adding musb support in ti814 EVM board file.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Ravi Babu <ravibabu@ti.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-ti8148evm.c |    9 +++++++++
> 
> This file does not exist and probably will not exist in the future,
> see [1] and [2].
> So this patch can be dropped.
> Your 3/8 patch provides the support for both boards.

Thanks for this.

Felipe/Tony, Please drop this 4/8 patch.

Ajay
> 
> [1] - http://www.spinics.net/lists/linux-omap/msg58348.html
> [2] - http://www.spinics.net/lists/arm-kernel/msg143915.html
> 
> --
> Regards,
> Igor.
