From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Mon, 29 Oct 2012 13:32:39 +0100
Message-ID: <508E7767.40804@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <20121024232717.GD11928@atomide.com> <50887A6B.3050108@gmail.com> <508E3A0F.3040309@ti.com> <508E654B.5010404@gmail.com> <508E6870.7000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56448 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab2J2Mcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 08:32:50 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1939892bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Oct 2012 05:32:49 -0700 (PDT)
In-Reply-To: <508E6870.7000807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <x0148406@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, paul@pwsan.com, nsekhar@ti.com

Hi Afzal,

On 29.10.2012 12:28, Afzal Mohammed wrote:
> On Monday 29 October 2012 04:45 PM, Daniel Mack wrote:
>> On 29.10.2012 09:10, Afzal Mohammed wrote:
> 
>>> Also perhaps memory size (and offset if
>>> needed) to be mapped for peripherals can go with reg
>>> property of child.
> 
>> Which detail are you referring to here? The only "size" property that is
>> effective is the one of the generic GPMC block, and there it's in the
>> "reg"-property.
> 
> I was referring to that of child, now in gpmc_nand_init(),
> gpmc_cs_request() is being done, later on if we want to
> make it generic and remove gpmc_nand_init(), additional
> information that would be required from DT at least is the
> memory size to be reserved in gpmc address space for
> the connected peripheral (assuming gpmc_cs_request()
> would be done by gpmc driver generically later)
> 
> What I had in mind was example for external bus in [1],
> but I had not looked deep into this aspect yet.

Ok, now I see what you mean.

I would say we can use the "reg" property in child node for CS numbers
purely and if we want to get rid of the memory node allocation, we
should use a property in the gpmc top-node for this, something like:

	gpmc: gpmc@50000000 {
		compatible = "ti,gpmc";
		cs-regs = <0x51000000 0x10000000 ...>;
	};

Changing the meaning of the reg property of children from "cs number" to
"memory sub-region" later is something I would like to avoid.



Daniel

