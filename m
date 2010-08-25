From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Wed, 25 Aug 2010 12:21:07 +0300
Message-ID: <AANLkTik=kZEfdwP1kvtm=f0egwcAEm4WjXMeSCG_4_8+@mail.gmail.com>
References: <1281962906.1888.25.camel@chotu>
	<4C72192A.9050801@compulab.co.il>
	<4C721DFA.9010009@compulab.co.il>
	<1282723542.9299.87.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59268 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab0HYJVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 05:21:08 -0400
Received: by qwh6 with SMTP id 6so291018qwh.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 02:21:07 -0700 (PDT)
In-Reply-To: <1282723542.9299.87.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Mike Rapoport <mike@compulab.co.il>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Let's CC Russell for this one.

On Wed, Aug 25, 2010 at 11:05 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Mon, 2010-08-23 at 09:06 +0200, ext Mike Rapoport wrote:
>> Mike Rapoport wrote:
>
>> =A0From 81e9278ad27bc91be42105321e0e26d0be9e883b Mon Sep 17 00:00:00=
 2001
>> From: Mike Rapoport <mike@compulab.co.il>
>> Date: Mon, 23 Aug 2010 09:40:09 +0300
>> Subject: [PATCH] OMAP: DSS2: OMAPFB: use phys_to_virt for RAM mappin=
gs
>>
>> After commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8 (ARM: Prohibit
>> ioremap() on kernel managed RAM) it is impossible to ioremap SDRAM f=
or
>> the framebuffer. Use phys_to_virt for kernel managed RAM mapping and
>> ioremap for other memory types
>
> Hmm. omapfb reserves/allocates the ram using memblock, and obviously
> memory from memblock is "kernel managed RAM". What does it mean? The =
RAM
> is already mapped? I guess so, if phys_to_virt() works. (I guess the
> whole RAM is mapped automatically). With what caching? How can we get
> writecombining for this memory?
>
> Looking at the description of "ARM: Prohibit ioremap() on kernel mana=
ged
> RAM" it sounds to me that we cannot have writecombining for framebuff=
er
> memory, if it's "kernel managed RAM".
>
> =A0Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
