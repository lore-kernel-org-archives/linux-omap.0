From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFT/PATCH 6/7] arm: omap: smartreflex: fix IRQ handling bug
Date: Tue, 11 Oct 2011 15:23:52 +0400
Message-ID: <4E942748.80901@ru.mvista.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com> <1318249579-4089-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52183 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752266Ab1JKLYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 07:24:43 -0400
In-Reply-To: <1318249579-4089-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hello.

On 10-10-2011 16:26, Felipe Balbi wrote:

> fix a bug which has been on this driver since
> it was added by the original commit 984aa6db

    Please also specify that commit's summary in parens.

> which would never clear IRQSTATUS bits.

> Signed-off-by: Felipe Balbi <balbi@ti.com>

WBR, Sergei

