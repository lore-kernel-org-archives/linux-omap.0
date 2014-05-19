From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 19 May 2014 15:11:42 -0500
Message-ID: <CAOCHtYgqQpgVw1Wo0SrYux0LHjnQ5aiyPD9nRbrU90iGxxD-Kg@mail.gmail.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
	<1400490948-11571-2-git-send-email-pekon@ti.com>
	<20140519162532.GF4849@atomide.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
	<20140519181640.GA6957@arch.cereza>
	<CAOCHtYjAJB3xSYrq3P+R2qyLHEbMQ5LMpu=hs4rwjXSqXb-kKw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACE2A5@DBDE04.ent.ti.com>
	<CAOCHtYhDz=6eU7qdpX3Le2XexVvnreJ2fBF+UnbEANbbyez1_w@mail.gmail.com>
	<DAEAC432-DB0E-4C30-9B85-71D8987FBF77@ti.com>
	<CAOCHtYiPWqZyDiS6dAM93tq6jo7fVk262aeYBQ_V5WAoCkcYuA@mail.gmail.com>
	<50A3219B-8418-4CCA-8500-72119594BA97@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:63195 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaESULn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 16:11:43 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so4039798igq.1
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 13:11:43 -0700 (PDT)
In-Reply-To: <50A3219B-8418-4CCA-8500-72119594BA97@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

>>>
>>> I believe this is the same reason I created
>>> https://github.com/beagleboard/cape-firmware.  Is something else needed?
>>
>> Hi Jason,
>>
>> Same exact idea. But instead of the "overlay" dts's that get installed
>> in /lib/firmware/ this will be for the main kernel dtb files, that'll
>> be dumped in /boot/dtbs/*.dtb or /boot/*.dtb.  In theory we should be
>> able to build these outside kernel.org, so down the road we can add a
>> package for all the other distro's.
>
> Why not reuse the same repo since the capes would be in there too? Does it need renaming?

Okay, i'll work with that repo and get something for v3.15.x/v3.16.x cleaned up.

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
