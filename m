From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 5/6] OMAP: powerdomain: Arch specific funcs for mem
 control
Date: Tue, 16 Nov 2010 17:09:38 +0100
Message-ID: <20101116170938.0d83e1e4@surf>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com>
	<1289921886-5139-2-git-send-email-rnayak@ti.com>
	<1289921886-5139-3-git-send-email-rnayak@ti.com>
	<1289921886-5139-4-git-send-email-rnayak@ti.com>
	<1289921886-5139-5-git-send-email-rnayak@ti.com>
	<1289921886-5139-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:60663 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0KPQJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 11:09:50 -0500
In-Reply-To: <1289921886-5139-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com

Hello,

On Tue, 16 Nov 2010 21:08:05 +0530
Rajendra Nayak <rnayak@ti.com> wrote:

> Define the following architecture specific funtions for omap2/3/4

funtions -> functions.

> +/* Common Internal functions used across OMAP rev's*/
> +int _get_mem_bank_onstate_mask(u8 bank)
> +{
> +	switch (bank) {
> +	case 0:
> +		return OMAP_MEM0_ONSTATE_MASK;
> +	case 1:
> +		return OMAP_MEM1_ONSTATE_MASK;
> +	case 2:
> +		return OMAP_MEM2_ONSTATE_MASK;
> +	case 3:
> +		return OMAP_MEM3_ONSTATE_MASK;
> +	case 4:
> +		return OMAP_MEM4_ONSTATE_MASK;
> +	default:
> +		WARN_ON(1); /* should never happen */
> +		return -EEXIST;

EEXIST is the error code for "File exists", so here I would rather
expect something like ENOENT. But I understand that it was already
-EEXIST in the existing code.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
