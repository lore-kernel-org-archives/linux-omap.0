From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/2] ARM: OMAP3+: dpll: Configure autoidle mode only if
 its supported
Date: Thu, 19 Jan 2012 11:51:12 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433178C451@DBDE01.ent.ti.com>
References: <1326973598-8209-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39077 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218Ab2ASLvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 06:51:22 -0500
In-Reply-To: <1326973598-8209-1-git-send-email-vaibhav.bedia@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>

On Thu, Jan 19, 2012 at 17:16:38, Bedia, Vaibhav wrote:
> The current DPLL code enables and disables autoidle features
> without checking whether the autoidle register is available.
> Fix this by putting a check for the existence of the autoidle
> register in the DPLL data.
> 
> With such a check in place, for DPLLs which do not support this
> feature, simply skipping the autoidle_reg entry in the DPLL data
> is sufficient.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

There's no PATCH 2/2 here. Sorry about that. If needed, I can resend
this one.
