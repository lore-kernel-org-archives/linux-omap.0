From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation error on current mainline
Date: Tue, 8 Nov 2011 16:25:34 +0100
Message-ID: <4EB949EE.7030109@ti.com>
References: <4EB7E50D.40406@ti.com> <1320733698-23411-1-git-send-email-govindraj.raja@ti.com> <4EB908A1.40404@ti.com> <4EB90A62.7010206@ti.com> <CAAL8m4w4Zr-P4ywOYwZ7VwOtTNp5Yz=Zsw0y_SrkcY4yN6n49A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50380 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab1KHPZj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Nov 2011 10:25:39 -0500
In-Reply-To: <CAAL8m4w4Zr-P4ywOYwZ7VwOtTNp5Yz=Zsw0y_SrkcY4yN6n49A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 11/8/2011 12:59 PM, Govindraj wrote:
> On Tue, Nov 8, 2011 at 4:24 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:

[...]

>> Opps. I missed that one while acking the patch.
>> Indeed the semi-colon one was agreed to be the left over
>> in the last patch discussion.
>
> Sorry, my bad sent the wrong patch here's the right one.[1]
>
> --
> Thanks,
> Govindraj.R
>
> [1]:
>
>  From 9d244c0dea4de10ab9052fc1fe7bde8846ad389e Mon Sep 17 00:00:00 2001
> From: Govindraj.R<govindraj.raja@ti.com>
> Date: Tue, 8 Nov 2011 16:57:22 +0530
> Subject: [PATCH] OMAP2+: Fix Compilation error on current mainline
>
> Fix below compilation failure on mainline kernel commit id
> 1ea6b8f48918282bdca0b32a34095504ee65bab5
>
> arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';'
> before 'MODULE_DEVICE_TABLE'

The issue is that 3.2-rc1 does not have that build error anymore...
It should appear only with this driver built as a module, and that's not 
possible yet for the l3_noc.

The fix is still good to have, but the changelog should probably be updated.

Regards,
Benoit
