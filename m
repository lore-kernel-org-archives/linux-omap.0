From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 7/8] OMAP2PLUS:GPIO:Move gpio_init from board files to init_common_hw
Date: Tue, 06 Apr 2010 15:13:37 -0700
Message-ID: <87eiiskz5a.fsf@deeprootsystems.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
	<1270038239-1090-2-git-send-email-charu@ti.com>
	<1270038239-1090-3-git-send-email-charu@ti.com>
	<1270038239-1090-4-git-send-email-charu@ti.com>
	<1270038239-1090-5-git-send-email-charu@ti.com>
	<1270038239-1090-6-git-send-email-charu@ti.com>
	<1270038239-1090-7-git-send-email-charu@ti.com>
	<1270038239-1090-8-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41339 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062Ab0DFWNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 18:13:49 -0400
Received: by vws13 with SMTP id 13so191097vws.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 15:13:48 -0700 (PDT)
In-Reply-To: <1270038239-1090-8-git-send-email-charu@ti.com> (Charulatha V.'s message of "Wed\, 31 Mar 2010 17\:53\:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> This is preparation for early platform device implementation
> for GPIO in OMAP2PLUS. This patch moves initialization of gpio
> from board files to omap2_init_common_hw API in io.c

Why?

Not a helpful description.

Kevin
