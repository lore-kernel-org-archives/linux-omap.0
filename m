From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 19 May 2014 14:22:15 -0500
Message-ID: <CAOCHtYiPWqZyDiS6dAM93tq6jo7fVk262aeYBQ_V5WAoCkcYuA@mail.gmail.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
	<1400490948-11571-2-git-send-email-pekon@ti.com>
	<20140519162532.GF4849@atomide.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
	<20140519181640.GA6957@arch.cereza>
	<CAOCHtYjAJB3xSYrq3P+R2qyLHEbMQ5LMpu=hs4rwjXSqXb-kKw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACE2A5@DBDE04.ent.ti.com>
	<CAOCHtYhDz=6eU7qdpX3Le2XexVvnreJ2fBF+UnbEANbbyez1_w@mail.gmail.com>
	<DAEAC432-DB0E-4C30-9B85-71D8987FBF77@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34753 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbaESTWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 15:22:16 -0400
Received: by mail-yk0-f173.google.com with SMTP id 142so4866742ykq.32
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 12:22:15 -0700 (PDT)
In-Reply-To: <DAEAC432-DB0E-4C30-9B85-71D8987FBF77@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

On Mon, May 19, 2014 at 2:11 PM, Kridner, Jason <jdk@ti.com> wrote:
>
>
> On May 19, 2014, at 11:58 AM, "Robert Nelson" <robertcnelson@gmail.com>
> wrote:
>
> On Mon, May 19, 2014 at 1:51 PM, Gupta, Pekon <pekon@ti.com> wrote:
>
> From: Robert Nelson [mailto:robertcnelson@gmail.com]
>
> [...]
>
> Since the capes are always some way tied with bb.org hardware, why
>
> don't we put them up on https://github.com/beagleboard/ ?
>
>
> am335x-capes.git ?
>
>
> I envision, we should just mirror the base ./arch/arm/boot/dts/
>
> directory (as someday the dts will be external anyways). In that repo,
>
> we will keep these synced with mainline
>
>
> am335x-bone-common.dtsi
>
> am335x-bone.dts
>
> am335x-boneblack.dts
>
>
> and add the capes as:
>
>
> <baseboard>-<cape>.dts
>
>
> as a staging ground till a mainline overlay/etc system appears?
>
>
> Thoughs?
>
>
>
> If you know and can convince 'Gerald Coley' then plz try. I failed :-)
>
>
> Oh, I'll do it... ;)
>
> I just need Jason to create the intial "repo" for me on
> github.com/beagleboard and enable my permission for it.
>
>
> I believe this is the same reason I created
> https://github.com/beagleboard/cape-firmware.  Is something else needed?

Hi Jason,

Same exact idea. But instead of the "overlay" dts's that get installed
in /lib/firmware/ this will be for the main kernel dtb files, that'll
be dumped in /boot/dtbs/*.dtb or /boot/*.dtb.  In theory we should be
able to build these outside kernel.org, so down the road we can add a
package for all the other distro's.

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
