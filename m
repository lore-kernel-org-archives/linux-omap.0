From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] cpsw: Fix interrupt storm among other things
Date: Wed, 30 Jan 2013 10:36:07 +0200
Message-ID: <3DE2C638-6AE8-4BC9-AD68-3AAA40CD6233@antoniou-consulting.com>
References: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com> <5107B650.5090901@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:38434 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753754Ab3A3IgM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 03:36:12 -0500
In-Reply-To: <5107B650.5090901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Matt Porter <mporter@ti.com>, Chase Maupin <chase.maupin@ti.com>, Jason Kridner <jdk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mugunthan,

On Jan 29, 2013, at 1:45 PM, Mugunthan V N wrote:

> On 1/28/2013 6:41 PM, Pantelis Antoniou wrote:
>> Fix interrupt storm on bone A4 cause by non-by-the-book interrupt handling.
>> While at it, added a non-NAPI mode (which is easier to debug), plus
>> some general fixes.
>> 
>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> ---
>>  Documentation/devicetree/bindings/net/cpsw.txt |   1 +
>>  drivers/net/ethernet/ti/cpsw.c                 | 222 +++++++++++++++++++++----
>>  drivers/net/ethernet/ti/davinci_cpdma.c        |   4 +-
>>  drivers/net/ethernet/ti/davinci_cpdma.h        |   2 +-
>>  include/linux/platform_data/cpsw.h             |   1 +
>>  5 files changed, 194 insertions(+), 36 deletions(-)
> I have tested CPSW on AM335x EVM 1.5A with flood ping and i am not
> seeing any interrupt storm.
> Can you provide more details on how to reproduce the issue.
> 

A beaglebone prototype with the new silicon version, with the ethernet errata
fixed displays this. You can't trigger it on old silicon.

The TI people on the CC list can confirm.

> Regards
> Mugunthan V N

Regards

-- Pantelis

