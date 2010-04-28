From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: Bug in omap2_nand_gpmc_retime?
Date: Wed, 28 Apr 2010 18:40:18 +0300
Message-ID: <4BD856E2.7070507@compulab.co.il>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il> 	<4BCFDC6F.6010801@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com> 	<4BCFF3C1.5070005@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com> 	<4BD00C9A.8050601@compulab.co.il> <20100426181448.GG7225@atomide.com> 	<4BD695BC.3080109@compulab.co.il> <20100427144734.GX7225@atomide.com> 	<4BD84EAF.7010104@compulab.co.il> <s2hce9ab5791004280826y69ec56d1od0950eadf7cd60e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48043 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404Ab0D1Plg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 11:41:36 -0400
In-Reply-To: <s2hce9ab5791004280826y69ec56d1od0950eadf7cd60e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vimal Singh wrote:
> On Wed, Apr 28, 2010 at 8:35 PM, Mike Rapoport <mike@compulab.co.il> wrote:

>> While working on implementation of gpmc_nand_detect_timings I've seen that
>> omap2_nand_gpmc_retime converts the timings supplied by the platform to
>> ticks and passes it to gpmc_cs_set_timings which in turn converts the
>> timings to ticks. Is it a bug or am I missing something?
> 
> No, 'omap2_nand_gpmc_retime' does not convert timings supplied by the
> platform to tick. Rather it rounds the timings passed by the platform
> to timings in units of 'tick' period.

Thanks for the clarification. I still wonder why is this necessary. 
Anyway gpmc_set_cs_timings will do the conversion?



-- 
Sincerely yours,
Mike.
