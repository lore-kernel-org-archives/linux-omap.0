From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Change IOPAD macro's for OMAP4/5
Date: Wed, 14 May 2014 14:58:00 -0700
Message-ID: <20140514215800.GO27426@atomide.com>
References: <1399918587-20170-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16023 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbaENV6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 17:58:04 -0400
Content-Disposition: inline
In-Reply-To: <1399918587-20170-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140512 11:17]:
> The OMAP4/5 TRMs primarily list address offsets from the padconf
> physical address (which is not driver base address) and not
> always the absolute physical address for padconf registers like
> some other OMAP TRMs. So create a new macro to use this offset
> and to avoid confusion between different OMAP parts.

Thanks applying into omap-for-v3.16/dt.

Tony
