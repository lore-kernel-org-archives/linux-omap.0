From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Tue, 05 Feb 2013 18:23:15 +0100
Message-ID: <51114003.9070405@epfl.ch>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch> <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch> <CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com> <510F8F49.9020800@epfl.ch> <CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:46923 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752941Ab3BERXZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 12:23:25 -0500
In-Reply-To: <CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Javier,

On 02/04/2013 12:57 PM, Javier Martinez Canillas wrote:

[...]

>
> Yes, I saw on the list that Tony asked you too extend the GPMC DT
> support. Flash support is on my TODO list too but I don't know if I'm
> going to have time to work on this in the next few weeks.
>
> Since you are thinking to change the binding, there is something I
> want to discuss with you.
>
> We have two different version for each IGEP board, one that uses NAND
> memory and another that has OneNAND.
>
> With board files this is easy because the flash memory type is
> hardcoded (in hardware) using sysboot pins [3]. So we check the
> sysboot value and call board_nand_init() or board_onenand_init()
> accordingly and pass the same static struct mtd_partition
> igep_flash_partitions[] in both cases.
>
> But with DT this is a little bit trickier since you have to define
> either a nand@0 or onenand@0 child node for the gpmc device node. So,
> we will have to create lots of dts and dtsi to handle each combination
> (IGEPv2 + NAND, IGEPv2 + OneNAND, IGEP COM + NAND, etc).
>
> I wonder if we could just have a generic gpmc-flash binding and maybe
> use a "gpmc, flash_type" property or something like that to decide if
> gpmc_onenand_init() or gpmc_nand_init() has to be called.
>

This boils down to the problem where you have an "if" statement in
your board file, and I think no general solution exists.

In your suggestion, having a property will force you anyway to write
distinct DT files to account for the two versions, so it won't really
help if I understand correctly. We would need conditional
section inside device trees, at least to test for simple parameters.
Or a way to generate several DT blobs based on a single DT source file.

Another hackish solution would be to write a meta component, whose
probe section would do your test. But this is just a stripped down version
of the board file, far from being generic...

I will think on it during my holidays :)

Regards,

Florian

