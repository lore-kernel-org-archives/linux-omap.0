From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation error on current mainline
Date: Wed, 9 Nov 2011 17:48:43 +0530
Message-ID: <CAAL8m4wW8BPsZoQh59J7RRyLJnpq5SnaJo1q==X84ZjTwW+cXQ@mail.gmail.com>
References: <4EB7E50D.40406@ti.com> <1320733698-23411-1-git-send-email-govindraj.raja@ti.com>
 <4EB908A1.40404@ti.com> <4EB90A62.7010206@ti.com> <CAAL8m4w4Zr-P4ywOYwZ7VwOtTNp5Yz=Zsw0y_SrkcY4yN6n49A@mail.gmail.com>
 <4EB949EE.7030109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53249 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1KIMTH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 07:19:07 -0500
Received: by bke11 with SMTP id 11so1278245bke.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Nov 2011 04:19:05 -0800 (PST)
In-Reply-To: <4EB949EE.7030109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Nov 8, 2011 at 8:55 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> On 11/8/2011 12:59 PM, Govindraj wrote:
>>
>> On Tue, Nov 8, 2011 at 4:24 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> =A0wrote:
>
> [...]
>
>>> Opps. I missed that one while acking the patch.
>>> Indeed the semi-colon one was agreed to be the left over
>>> in the last patch discussion.
>>
>> Sorry, my bad sent the wrong patch here's the right one.[1]
>>
>> --
>> Thanks,
>> Govindraj.R
>>
>> [1]:
>>
>> =A0From 9d244c0dea4de10ab9052fc1fe7bde8846ad389e Mon Sep 17 00:00:00=
 2001
>> From: Govindraj.R<govindraj.raja@ti.com>
>> Date: Tue, 8 Nov 2011 16:57:22 +0530
>> Subject: [PATCH] OMAP2+: Fix Compilation error on current mainline
>>
>> Fix below compilation failure on mainline kernel commit id
>> 1ea6b8f48918282bdca0b32a34095504ee65bab5
>>
>> arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';'
>> before 'MODULE_DEVICE_TABLE'
>
> The issue is that 3.2-rc1 does not have that build error anymore...
> It should appear only with this driver built as a module, and that's =
not
> possible yet for the l3_noc.
>
> The fix is still good to have, but the changelog should probably be u=
pdated.
>

Have posted a updated patch.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58415.html

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
