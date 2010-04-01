From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 7/8] OMAP2PLUS:GPIO:Move gpio_init from board files to
 init_common_hw
Date: Thu, 1 Apr 2010 16:20:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4C3293E@dbde02.ent.ti.com>
References: <20100401093253.GH31200@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab0DAKuM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:50:12 -0400
In-Reply-To: <20100401093253.GH31200@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, April 01, 2010 3:03 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com
> Subject: Re: [PATCH 7/8] OMAP2PLUS:GPIO:Move gpio_init from board files to
> init_common_hw
> 
> * Charulatha V <charu@ti.com> [100331 05:15]:
> > This is preparation for early platform device implementation
> > for GPIO in OMAP2PLUS. This patch moves initialization of gpio
> > from board files to omap2_init_common_hw API in io.c
> >
> > Init_irq needs to be done before gpio_init, the init_irq
> > is called before omap2_init_common_hw in board files
> 
> Nope. We want to call omap2_init_common_hw as early as
> possible, otherwise the cpu detection won't work.
> 
> What omaps have you tested this series on?

I tested it on 3430SDP, 4430SDP and zoom3 and did not face
any problem. I will keep this point in mind while creating
next version of patches.

> 
> Tony

