From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 0/5 v2] Serial HWMOD updation and uart4  support for 3630
Date: Fri, 18 Jun 2010 11:23:18 -0700
Message-ID: <8739wk6vzd.fsf@deeprootsystems.com>
References: <2134.10.24.255.18.1276697618.squirrel@dbdmail.itg.ti.com>
	<87d3vpciim.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43495 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab0FRSXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 14:23:21 -0400
Received: by pvg6 with SMTP id 6so558097pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 11:23:20 -0700 (PDT)
In-Reply-To: <87d3vpciim.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 17 Jun 2010 17\:05\:21 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Changes from v1:
>> * Incorporated : OMAP clock: Add uart4_ick/fck definitions for 3630
>> * using omap_mux_request_signal to retreive padconf offset
>>   as per Tony's comments.
>>   http://marc.info/?l=linux-omap&m=127609369220618&w=2
>>   This patch series as a dependecy on the patch
>>   for "omap_mux_request_signal" posted earlier
>>   https://patchwork.kernel.org/patch/105962/
>> * Clean up certain comments.
>>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30348.html
>>
>> Patch series is based on remotes/origin/pm-wip/uart
>> branch from Kevin's PM tree.
>>
>> 1.) Add support for UART4 for 3630.
>> 2.) Modify Serial hwmod to avoid hwmod lookup using name string.
>>
>> Govindraj.R (5):
>>   OMAP clock: Add uart4_ick/fck definitions for 3630
>>   OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>>   OMAP3: serial: Fix uart4 handling for 3630
>>   OMAP3: PM: Add prepare idle and resume idle call for uart4
>>   Serial: Avoid using hwmod lookup using name string.
>
> Govindraj,
>
> Can you add this one to your series and test it on your boards?
>

Actually, my patch doesn't really work either, so it needs some more digging.

Basically, there's a problem during static suspend on boards like Zoom3
that don't ever add/register any OMAP UARTs and just use the ones
on the debug board.

Somehow, we have to keep from adding UARTs to the uart_list unless
they are actually registered to board files.

Kevin
