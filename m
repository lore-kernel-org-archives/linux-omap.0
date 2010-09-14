From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [v4 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Tue, 14 Sep 2010 11:06:03 -0700
Message-ID: <87tylsnqt0.fsf@deeprootsystems.com>
References: <1284390809-11519-1-git-send-email-charu@ti.com>
	<1284390809-11519-5-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38604 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab0INSGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 14:06:05 -0400
In-Reply-To: <1284390809-11519-5-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Mon, 13 Sep 2010 20:43:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> From: Benoit Cousson <b-cousson@ti.com>
>
> Add watchdog timer hwmod data for OMAP4 chip
>
> This patch is extracted from the below patch sent by Benoit
> OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0
> https://patchwork.kernel.org/patch/99052/

Minor nit: the above paragraph is better to put after the '---' as it is
useful for the reviewers/maintainers, but doesn't need to go in the
final commit log.

Kevin

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 ++++++++++++++++++++++++++++
>  1 files changed, 68 insertions(+), 0 deletions(-)
>
