From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Wed, 22 Sep 2010 12:36:54 -0700
Message-ID: <87r5glbmeh.fsf@deeprootsystems.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48929 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0IVTg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 15:36:58 -0400
Received: by iwn5 with SMTP id 5so741993iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 12:36:58 -0700 (PDT)
In-Reply-To: <1285104244-32274-1-git-send-email-x0132446@ti.com> (David
	Anders's message of "Tue, 21 Sep 2010 16:24:00 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

David Anders <x0132446@ti.com> writes:

> PandaBoard machine file related cleanups.
>
> David Anders (4):
>   omap4: pandaboard: remove unused hsmmc definition
>   omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
>   omap4: pandaboard: Adding card detect support for MMC1
>   omap4: pandaboard: enable the ehci port on pandaboard
>
>  arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
>  1 files changed, 69 insertions(+), 7 deletions(-)

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

on an es2.0 panda using MMC rootfs.

