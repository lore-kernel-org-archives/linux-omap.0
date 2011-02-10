From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Thu, 10 Feb 2011 21:56:06 +0530
Message-ID: <c91b2ffa73132a815908f0c85888e140@mail.gmail.com>
References: <20110125125656.GG13300@n2100.arm.linux.org.uk>
 <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk>
 <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk>
 <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk>
 <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com> <20110207101829.GA32431@n2100.arm.linux.org.uk>
 <06aa531b67f240da586a7b56238d56b2@mail.gmail.com> <20110210161350.GA9350@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37858 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab1BJQ0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 11:26:13 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so1515405wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 08:26:08 -0800 (PST)
In-Reply-To: <20110210161350.GA9350@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, February 10, 2011 9:44 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> ccross@android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Thu, Feb 10, 2011 at 08:19:19PM +0530, Santosh Shilimkar wrote:
> > This patch will need below update so that the smp_scu.h
> > header can be included from assembly files. Will you
> > fold this into your patch or you want me to
> > send below as separate patch ?
>
> Folded.

Thanks.

Regards,
Santosh
