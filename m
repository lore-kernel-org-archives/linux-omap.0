From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 1/1] Regulator: Registering USB internal LDOs for TWL4030
Date: Tue, 2 Mar 2010 11:54:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321B9DE1E@dbde02.ent.ti.com>
References: <1263201918-8185-1-git-send-email-anuj.aggarwal@ti.com>
 <20100111105612.GA20717@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab0CBGZJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 01:25:09 -0500
In-Reply-To: <20100111105612.GA20717@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Monday, January 11, 2010 4:26 PM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
> Subject: Re: [PATCH 1/1] Regulator: Registering USB internal LDOs for
> TWL4030
> 
> On Mon, Jan 11, 2010 at 02:55:18PM +0530, Anuj Aggarwal wrote:
> > Adding member variables for USB internal LDOs in twl4030_platform_data
> > and registering them in twl-core.c if the variables are populated
> > from board-evm file.
> 
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Tony,

Can you pull this patch? I have tried it on for-next tip, it applies
cleanly.
