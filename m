From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 25 Oct 2012 01:31:55 +0200
Message-ID: <50887A6B.3050108@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <20121024232717.GD11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53061 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab2JXXcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 19:32:03 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so487188bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 16:32:01 -0700 (PDT)
In-Reply-To: <20121024232717.GD11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, x0148406@ti.com, paul@pwsan.com, nsekhar@ti.com

On 25.10.2012 01:27, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [121022 12:57]:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instanciated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
> 
> That's great, looks good to me. Please repost at least the
> binding patch with devicetree-discuss and Rob Herring cc:d
> so hopefully we'll get an ack for the binding.

Thanks for the review. I'll wait for feedback from Afzal next week and
then repost. Wanted to see first if that goes in the right direction at
all before bordering the DT people with binding details :)


Regards,
Daniel


