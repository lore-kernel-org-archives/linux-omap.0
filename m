From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Mon, 29 Oct 2012 16:58:48 +0530
Message-ID: <508E6870.7000807@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <20121024232717.GD11928@atomide.com> <50887A6B.3050108@gmail.com> <508E3A0F.3040309@ti.com> <508E654B.5010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758715Ab2J2L3D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 07:29:03 -0400
In-Reply-To: <508E654B.5010404@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, paul@pwsan.com, nsekhar@ti.com

Hi Daniel,

On Monday 29 October 2012 04:45 PM, Daniel Mack wrote:
> On 29.10.2012 09:10, Afzal Mohammed wrote:

>> Also perhaps memory size (and offset if
>> needed) to be mapped for peripherals can go with reg
>> property of child.

> Which detail are you referring to here? The only "size" property that is
> effective is the one of the generic GPMC block, and there it's in the
> "reg"-property.

I was referring to that of child, now in gpmc_nand_init(),
gpmc_cs_request() is being done, later on if we want to
make it generic and remove gpmc_nand_init(), additional
information that would be required from DT at least is the
memory size to be reserved in gpmc address space for
the connected peripheral (assuming gpmc_cs_request()
would be done by gpmc driver generically later)

What I had in mind was example for external bus in [1],
but I had not looked deep into this aspect yet.

Regards
Afzal

[1] http://devicetree.org/Device_Tree_Usage#Memory_Mapped_Devices
