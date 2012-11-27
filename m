From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Tue, 27 Nov 2012 15:00:54 +0100
Message-ID: <50B4C796.4010403@gmail.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com> <1351869956-2787-5-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com> <5097B7EE.3000508@gmail.com> <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com> <509A2E75.5060307@gmail.com> <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com> <509EA360.2050504@gmail.com> <87mwycjmdn.fsf@dell.be.48ers.dk> <50ACA9BB.7090106@gmail.com> <518397C60809E147AF5323E0420B992E3E9EEA09@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58052 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab2K0OA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 09:00:59 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5151999bkw.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Nov 2012 06:00:58 -0800 (PST)
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9EEA09@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Avinash,
Hi Peter,

On 23.11.2012 11:43, Philip, Avinash wrote:
> On Wed, Nov 21, 2012 at 15:45:23, Daniel Mack wrote:
>> On 20.11.2012 16:59, Peter Korsgaard wrote:
>>>>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

> Peter,
> 
> In patch [1], mtd: nand: omap2: Support for hardware BCH
> 
> ecc_layout made compatible with Rom Boot Loader ECC layout for am335x.
> 
> This action is based on is_elm_used flag.
> 
> Requirement of this flag is to identify the whether the platform
> ELM module & based on this configure ELM module if present.
> 
> But ideally BCH8 ecc lay out didn't have a dependency on ELM, it
> can work with software BCH ecc. RBL compatibility is missing
> in software BCH because of addition of constant polynomial to
> ecc vector. If we remove the dependency on erased page handling
> by ecc vector with constant polynomial, software BCH can do the
> job of RBL compatibility.
> 
> Ivan,
> Do you have any suggestions?
> Discussion for RBL compatibility found at [2].
> 
> It is good that software BCH also support RBL compatibility by suppressing
> constant polynomial modification. Then ecc layout can be selected from
> DT entry and error correction can be chosen between software/hardware
> depending on the availability of ELM hardware.
> Currently RBL BCH8 compatibility depends on the availability of ELM
> hardware. Later once software BCH start supporting RBL compatibility,
> we can remove  the check.
> 
>>
>> That is what I experienced, yes. The kernel was unable to parse NAND
>> pages that were written from U-Boot with bch8 hardware mode when the elm
>> module was not active. Maybe someone from TI can explain that? Giving it
>> a dedicated name would also solve the problem with the extra DT property.
> 
> Daniel,
> 
> Currently BCH8 is supported with software ecc error correction in mainline.
> The layout for BCH8 ECC layout is
> 0-1 -> BAD block markers
> 2-11-> oob free area
> 12-63-> BCH8 ECC.
> 
> RBL ECC layout is
> 0-1 -> BAD block markers
> 2-57-> BCH8 ecc layout
> 58-63-> OOB free area
> 
> As u-boot also maintain RBL ecc layout, write from U-boot
> and read from Linux requires compatibility with RBL ecc layout.
> The same is achieved in the patch [1], with by setting is_elm_used
> to true.
> 
> 1. https://lkml.org/lkml/2012/10/31/87
> 2. https://lkml.org/lkml/2012/10/11/20

So, after reading this, I'm still uncertain what's your preferred way of
handling the bindings here. Are you saying we should stick with the
is_elm_used flag, and subsequently care for BCH8 software mode
compatibility?

I would like to submit a new version soon, so it can be queued up for
the next merge window, and that decision is the last blocker currently
for sending out a new series.


Many thanks,
Daniel

