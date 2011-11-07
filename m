From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation break on current mainline
Date: Mon, 7 Nov 2011 15:02:53 +0100
Message-ID: <4EB7E50D.40406@ti.com>
References: <1320669508-32204-1-git-send-email-govindraj.raja@ti.com> <CAMQu2gzTDLi4sj8XcUzJx-mNYZv155+rehH4XDbtCLmyyd7RqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab1KGOC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 09:02:56 -0500
In-Reply-To: <CAMQu2gzTDLi4sj8XcUzJx-mNYZv155+rehH4XDbtCLmyyd7RqQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 11/7/2011 1:59 PM, Shilimkar, Santosh wrote:
> On Mon, Nov 7, 2011 at 6:08 PM, Govindraj.R<govindraj.raja@ti.com>  wrote:
>> I see below errors and warnings on latest mainline commit
>> b32fc0a0629bf5894b35f33554c118aacfd0d1e2 with omap2plus_defconfig.
>>
>> Patch to fix the same.
>>
> Patches are already posted and applied by Tony on linux-omap master.

Except the missing semicolon... This is a similar issue that Ohad 
reported for hwspinlock.
It will build fine until you will try to build the omap_l3_noc as a module.


Govind,
You can maybe repost a fix for that one only.

Regards,
Benoit
