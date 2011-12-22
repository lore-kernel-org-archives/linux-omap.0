From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 01/10] arm: omap4: fix kconfig warning
Date: Thu, 22 Dec 2011 22:09:27 +0200
Message-ID: <CAMP44s2MfdS-woETebYsTHEPZsBuBpP2dfmfBibC+JWZZ2iLKQ@mail.gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
	<1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
	<20111222182240.GN24444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64773 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab1LVUJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 15:09:33 -0500
In-Reply-To: <20111222182240.GN24444@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 22, 2011 at 8:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
>> warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)
>
> Thanks applying into fixes-non-critical-part3.

Actually, please disregard this one, it should be handled by this:
http://article.gmane.org/gmane.linux.ports.arm.kernel/141942

Cheers.

-- 
Felipe Contreras
