From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
Date: Mon, 2 Aug 2010 18:51:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641D502@dbde02.ent.ti.com>
References: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
 <20100802131246.GM12293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49278 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab0HBNV6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 09:21:58 -0400
In-Reply-To: <20100802131246.GM12293@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, August 02, 2010 6:43 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100731 20:38]:
> > The machine_kexec() calls outer_disable which can crash on OMAP4
> > becasue of trustzone restrictions.
> >
> > This patch overrides the default l2x0_disable with a OMAP4
> > specific implementation taking care of trustzone
> 
> Do you need different handling on GP omaps compared to HS omaps?
> 
No. Same API works for both

Regards,
Santosh
