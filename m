From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: board-generic: Add missing omap3_init_late
Date: Mon, 4 Mar 2013 10:00:38 -0800
Message-ID: <20130304180036.GM11806@atomide.com>
References: <1361278711-17672-1-git-send-email-rnayak@ti.com>
 <51237B84.7060105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24811 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932153Ab3CDSAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:00:42 -0500
Content-Disposition: inline
In-Reply-To: <51237B84.7060105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130219 05:20]:
> On Tuesday 19 February 2013 06:28 PM, Rajendra Nayak wrote:
> >The .init_late callback for OMAP3 has been missing for DT
> >builds, which causes a lot of late PM initializations to
> >be missed in turn.
> >
> >Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks applying into omap-for-v3.9-rc1/fixes.

Regards,

Tony
