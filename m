From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode
Date: Wed, 10 Oct 2012 12:19:11 +0530
Message-ID: <50751A67.2000800@ti.com>
References: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab2JJGt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 02:49:27 -0400
In-Reply-To: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Afzal Mohammed <afzal@ti.com>, Tony Lindgren <tony@atomide.com>


On Tuesday 09 October 2012 02:27 PM, Vaibhav Hiremath wrote:

> This patch adds of_have_populated_dt() check before creating

> Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>
> Cc: Afzal Mohammed<afzal@ti.com>

Reviewed-by: Afzal Mohammed <afzal@ti.com>
