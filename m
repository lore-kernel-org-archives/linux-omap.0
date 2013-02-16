From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe fails
Date: Sun, 17 Feb 2013 00:37:58 +0200
Message-ID: <CANOLnOO5ZrwonjrROawkLFpAsxgrJOsan-mjeOyOcYOZU6sizQ@mail.gmail.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
	<1359736726-10193-2-git-send-email-jon-hunter@ti.com>
	<20130201220804.GZ22517@atomide.com>
	<51158293.8010101@ti.com>
	<20130209155547.GA5253@localhost>
	<518397C60809E147AF5323E0420B992E3EA754E2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42668 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab3BPWh7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Feb 2013 17:37:59 -0500
Received: by mail-oa0-f41.google.com with SMTP id i10so4835466oag.28
        for <linux-omap@vger.kernel.org>; Sat, 16 Feb 2013 14:37:59 -0800 (PST)
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA754E2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Philip, Avinash" <avinashphilip@ti.com>

On Thu, Feb 14, 2013 at 2:04 PM, Philip, Avinash <avinashphilip@ti.com>=
 wrote:
> Hi Tony,
>
> On Sat, Feb 09, 2013 at 21:25:49, Ezequiel Garcia wrote:
>> On Fri, Feb 08, 2013 at 04:56:19PM -0600, Jon Hunter wrote:
>> Without this patch, GPMC is currently broken on my igep board setup,
>> if initialized through a device tree.
>>
>> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> Without this patch GPMC is not working in am335x-evm.
>
> Tested-by: Philip Avinash <avinashphilip@ti.com>
>
> See Jon's comments.
>
> JON >> Hi Tony, this one appears to be merged incorrectly. The unrese=
rve ended
> JON >> up in the gpmc_calc_timings() function. Here is a patch to fix=
=2E

Just wasted a hour or a few trying to figure out this problem, can we
get this merged now? Maybe Jon can resend this with all the tested-bys
to catch Tony's attention?

Tested-by: Grazvydas Ignotas <notasas@gmail.com>


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
