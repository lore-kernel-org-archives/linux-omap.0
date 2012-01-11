From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after dss_core
Date: Thu, 12 Jan 2012 01:19:52 +0400
Message-ID: <4F0DFCF8.4070008@emcraft.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com> <1325028693-14728-1-git-send-email-yanok@emcraft.com> <4EFD8C36.9000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:46128 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab2AKVTy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 16:19:54 -0500
In-Reply-To: <4EFD8C36.9000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il, sasha_d@emcraft.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Archit.

On 30.12.2011 14:02, Archit Taneja wrote:
> This looks fine, but it should be needed for other OMAP2 and OMAP4 also.
> If you could extend the patch we could test it out for the other OMAPs.

OMAP2 and OMAP4 don't need this as they have single hwmod list, so
correct ordering can be handled just by ordering list items.

Regards, Ilya.
