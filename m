From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: fix build errors for OMAP2_L4_IO_ADDRESS
Date: Mon, 23 Apr 2012 17:49:11 +0300
Message-ID: <CAMP44s0GDu91B5v90NKnOOiz0-N7iGp-q8MX_uBWEWLp8dSAng@mail.gmail.com>
References: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
	<20120423143917.GD24299@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64490 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2DWOtN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 10:49:13 -0400
Received: by eekc41 with SMTP id c41so3274032eek.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 07:49:12 -0700 (PDT)
In-Reply-To: <20120423143917.GD24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

On Mon, Apr 23, 2012 at 5:39 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Apr 23, 2012 at 05:34:14PM +0300, Felipe Contreras wrote:
>> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_b=
rd_start':
>> drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit d=
eclaration of function 'OMAP2_L4_IO_ADDRESS'
>> drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
>> drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declarati=
on of function 'OMAP2_L4_IO_ADDRESS'
>>
>> The proper fix will come later.
>
> Hmm. =C2=A0Given that this is staging stuff, which hasn't been making=
 much
> progress out of staging, I'd suggest not doing the quick fix on it, b=
ut
> spending the time to implement the proper fix now and move the code
> closer to the point where it can move out of staging.

Omar is already on that.

> You might get a gold star from Greg for moving this forward...

In my experience gold stars from Greg mean nothing.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
