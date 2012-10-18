From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: PRM/CM cleanup series for 3.8
Date: Thu, 18 Oct 2012 17:59:54 +0530
Message-ID: <507FF642.2010502@ti.com>
References: <20121015224455.18306.89030.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51234 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab2JRMaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 08:30:06 -0400
In-Reply-To: <20121015224455.18306.89030.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 16 October 2012 04:35 AM, Paul Walmsley wrote:
> Consolidate and remove some PRM/CM code in preparation for a future move
> into drivers/:
>
> - Remove some obsolete weak functions that allowed old OMAP4 code to
>    reference OMAP2/3 PRM functions
>
> - Split many of the functions in prm2xxx_3xxx.c and cm2xxx_3xxx.c into
>    2xxx- and 3xxx-specific PRM/CM C files
>
> - Move low-level powerdomain and clockdomain register access into the
>    appropriate 2xxx- and 3xxx-specific PRM/CM files, and remove
>    {power,clock}domainXXXX.c
>
> This series shouldn't have any functional impact.
>
>
Nice work Paul !!
This series and part2 both looks good to me.
Sorry for not being able to help in some of these clean-ups
because of other work priorities as talked at LPC.
Feel free to add my ack for the whole series if you need one.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

