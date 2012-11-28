From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 28 Nov 2012 17:59:47 +0100
Message-ID: <50B64303.2020100@gmail.com>
References: <1354113509-7972-1-git-send-email-zonque@gmail.com> <1354113509-7972-5-git-send-email-zonque@gmail.com> <20121128164606.GD5312@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64082 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2K1Q7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 11:59:52 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5831039bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Nov 2012 08:59:51 -0800 (PST)
In-Reply-To: <20121128164606.GD5312@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk

On 28.11.2012 17:46, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [121128 06:40]:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instantiated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
> 
> Please resend this with devicetree-discuss@lists.ozlabs.org and
> the people listed in MAINTAINERS in the cc:
> 
> Grant Likely <grant.likely@secretlab.ca>
> Rob Herring <rob.herring@calxeda.com>

Sorry - I picked the wrong entry from my history when sending. Resent now.


Daniel

