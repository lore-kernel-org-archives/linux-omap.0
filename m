From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: Add support for OMAP4 Variscite OM44 family
Date: Fri, 18 Apr 2014 18:17:57 +0200
Message-ID: <CAGhQ9VysdxGMd99CiVVh8YJt7KDAyy3Pe9YA2VM-G4mzn_6+0g@mail.gmail.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
	<1397833849-22396-2-git-send-email-manabian@gmail.com>
	<20140418155721.GC5354@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:43035 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaDRQR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 12:17:58 -0400
Received: by mail-la0-f44.google.com with SMTP id c6so1504424lan.17
        for <linux-omap@vger.kernel.org>; Fri, 18 Apr 2014 09:17:57 -0700 (PDT)
In-Reply-To: <20140418155721.GC5354@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On 18 April 2014 17:57, Tony Lindgren <tony@atomide.com> wrote:
> * Joachim Eastwood <manabian@gmail.com> [140418 08:11]:
>> Add support for VAR-SOM-OM44[1] SODIMM system on module from Variscite. SoM
>> features a OMAP4460, 1GB RAM, Gigabit Ethernet (LAN7500) and optional WLAN/BT.
>>
>> Also add support for VAR-STK-OM44 development board from Variscite. This kit
>> features a VAR-SOM-OM44 and the carrier board VAR-OM44CustomBoard[2]. The
>> VAR-STK-OM44 is the same as VAR-DVK-OM44 but without the LCD display.
>>
>> omap4-var-stk-om44.dts replace the old and very limited omap4-var-som.dts.
>>
>> [1] http://www.variscite.com/products/system-on-module-som/cortex-a9/var-som-om44-cpu-ti-omap-4-omap4460
>> [2] http://www.variscite.com/products/single-board-computers/var-om44customboard
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  arch/arm/boot/dts/Makefile                         |   2 +-
>>  arch/arm/boot/dts/omap4-var-om44customboard.dtsi   | 235 ++++++++++++++
>>  arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 343 +++++++++++++++++++++
>>  arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
>>  arch/arm/boot/dts/omap4-var-stk-om44.dts           |  16 +
>>  7 files changed, 599 insertions(+), 97 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
>>  create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
>>  delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
>>  create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts
>
> Hmm don't you still need to keep omap4-var-som.dts to build just the
> core SoC module without any add-on boards?

Since VAR-SOM-OM44 is a SODIMM module it is not possible to use
without a carrier board. Variscite's carrier board is called
OM44CustomBoard and I am in process of creating my own application
specific one so the omap4-var-som-om44 should be a dtsi-file.

> Also, you might want to use the OMAP4_CORE_IOPAD and OMAP4_WKUP_IOPAD
> macros in include/dt-bindings/pinctrl/omap.h to be able to check the
> registers against the TRM easier as you can use the physical register
> offset listed in the TRM.

I don't see any other OMAP4 using these macros. Is there a plan for a
mass conversion?
It's really a job for an automated script. But the macro are indeed
nice. That offset has bothered me more than once.

regards
Joachim Eastwood
