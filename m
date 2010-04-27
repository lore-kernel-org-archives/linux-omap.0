From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Tue, 27 Apr 2010 10:37:10 +0530
Message-ID: <u2sce9ab5791004262207k84f108abi47793bf90449aca0@mail.gmail.com>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
	<4BCFDC6F.6010801@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com>
	<4BCFF3C1.5070005@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com>
	<4BD00C9A.8050601@compulab.co.il> <20100426181448.GG7225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:44317 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0D0FHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 01:07:31 -0400
Received: by qyk9 with SMTP id 9so18738676qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 22:07:30 -0700 (PDT)
In-Reply-To: <20100426181448.GG7225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Apr 26, 2010 at 11:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Rapoport <mike@compulab.co.il> [100422 01:41]:
>> Ghorai, Sukumar wrote:
>>
>> CM-T35, for instance can be assembled with different NAND flash
>> chips. Besides, boards that use NAND as primary boot device, we
>> anyway depend on proper GPMC configuration in the bootloader chain.
>> Having ability to define GPMC timings in the kernel and keep the
>> settings made by the bootloader adds flexibility level for board
>> designers.
>
> Not implementing the retime function for GPMC will cause issues
> with PM as you cannot scale the L3 frequency without breaking
> your GPMC timings.

BTW, there is a patch from Stanley.Miao already in LO:
https://patchwork.kernel.org/patch/93613/

But it is still advisable to implement the retime function as stated by Tony.

-- 
Regards,
Vimal Singh
