From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH 1/2] arm/omap3: a driver for on-chip ETM and ETB
Date: Sun, 11 Oct 2009 13:08:32 -0400
Message-ID: <71a0d6ff0910111008pbd6c56eo1127540b915e935a@mail.gmail.com>
References: <1254951365-31807-1-git-send-email-virtuoso@slind.org>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02BB13DB19@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:36117 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZJKRJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Oct 2009 13:09:10 -0400
Received: by ewy4 with SMTP id 4so1908049ewy.37
        for <linux-omap@vger.kernel.org>; Sun, 11 Oct 2009 10:08:32 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB13DB19@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/10/10 Shilimkar, Santosh <santosh.shilimkar@ti.com>:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of virtuoso@slind.org
>> Sent: Thursday, October 08, 2009 3:06 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Alexander Shishkin
>> Subject: [PATCH 1/2] arm/omap3: a driver for on-chip ETM and ETB
>>
>> From: Alexander Shishkin <virtuoso@slind.org>
>>
>> This driver implements /dev/tracebuf and some control files for ETM
>> and ETB in sysfs.
> Looks like a very useful driver for tracing/debug.
> Do you have some README link on the usage of this driver ?

Well, here's a brief intro into how to collect traces and decode them:
http://wiki.github.com/virtuoso/etm2human/quickstart

That's not much, but if you have any questions, just email them to me
and I'll try to update the page.

Regards,
--
Alex
