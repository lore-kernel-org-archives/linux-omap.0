From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation error on current mainline
Date: Tue, 8 Nov 2011 17:29:14 +0530
Message-ID: <CAAL8m4w4Zr-P4ywOYwZ7VwOtTNp5Yz=Zsw0y_SrkcY4yN6n49A@mail.gmail.com>
References: <4EB7E50D.40406@ti.com> <1320733698-23411-1-git-send-email-govindraj.raja@ti.com>
 <4EB908A1.40404@ti.com> <4EB90A62.7010206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64627 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1KHL7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 06:59:38 -0500
Received: by bke11 with SMTP id 11so302587bke.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 03:59:36 -0800 (PST)
In-Reply-To: <4EB90A62.7010206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Nov 8, 2011 at 4:24 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Tuesday 08 November 2011 04:16 PM, Cousson, Benoit wrote:
>> Hi Govind,
>>
>> On 11/8/2011 7:28 AM, Govindraj.R wrote:
>>> Patch to fix below compilation error on latest mainline commit
>>> b32fc0a0629bf5894b35f33554c118aacfd0d1e2 with omap2plus_defconfig.
>>>
>>> arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undecla=
red
>>> here (not in a function)
>>> make[1]: *** [arch/arm/mach-omap2/omap_l3_noc.o] Error 1
>>>
>>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>>> ---
>>> =A0 arch/arm/mach-omap2/omap_l3_noc.c | =A0 =A01 +
>>> =A0 1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_l3_noc.c
>>> b/arch/arm/mach-omap2/omap_l3_noc.c
>>> index c8b1bef..c2cc196 100644
>>> --- a/arch/arm/mach-omap2/omap_l3_noc.c
>>> +++ b/arch/arm/mach-omap2/omap_l3_noc.c
>>> @@ -26,6 +26,7 @@
>>> =A0 #include<linux/interrupt.h>
>>> =A0 #include<linux/kernel.h>
>>> =A0 #include<linux/slab.h>
>>> +#include<linux/module.h>
>>
>> That one is already fixed by Axel Lin, and already pulled by Tony.
>>
>> http://www.spinics.net/lists/linux-omap/msg59847.html
>>
>> This is the missing semi-colon that still need to be fixed.
>>
> Opps. I missed that one while acking the patch.
> Indeed the semi-colon one was agreed to be the left over
> in the last patch discussion.

Sorry, my bad sent the wrong patch here's the right one.[1]

--
Thanks,
Govindraj.R

[1]:

=46rom 9d244c0dea4de10ab9052fc1fe7bde8846ad389e Mon Sep 17 00:00:00 200=
1
=46rom: Govindraj.R <govindraj.raja@ti.com>
Date: Tue, 8 Nov 2011 16:57:22 +0530
Subject: [PATCH] OMAP2+: Fix Compilation error on current mainline

=46ix below compilation failure on mainline kernel commit id
1ea6b8f48918282bdca0b32a34095504ee65bab5

arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';'
before 'MODULE_DEVICE_TABLE'

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c
b/arch/arm/mach-omap2/omap_l3_noc.c
index 6a66aa5..d15225f 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -237,7 +237,7 @@ static int __devexit omap4_l3_remove(struct
platform_device *pdev)
 static const struct of_device_id l3_noc_match[] =3D {
 	{.compatible =3D "ti,omap4-l3-noc", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, l3_noc_match);
 #else
 #define l3_noc_match NULL
--=20
1.7.4.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
