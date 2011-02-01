From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 08/13] OMAP2+: McBSP: hwmod adaptation
 for McBSP
Date: Tue, 1 Feb 2011 19:44:36 +0200
Message-ID: <20110201194436.74826dd0.jhnikula@gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-9-git-send-email-kishon@ti.com>
	<4D47FB19.9040901@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54034 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab1BARom (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 12:44:42 -0500
Received: by fxm20 with SMTP id 20so7061401fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 09:44:41 -0800 (PST)
In-Reply-To: <4D47FB19.9040901@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Kishon Vijay Abraham I <kishon@ti.com>, alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com

On Tue, 01 Feb 2011 14:22:49 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Looks good, but...
> > +	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
> > +		if (id == 2)
> > +			pdata->buffer_size = 0x500; /*FIFO size is 1024 + 256*/
> > +		else
> > +			pdata->buffer_size = 0x80;  /*FIFO size is 128*/
> > +	}
> 
> I would add spaces around these comments (after /* and before */).
> 
Actually this part of code doesn't compile for CONFIG_ARCH_OMAP2 if
CONFIG_ARCH_OMAP3 is not set. Reason is that the buffer_size in under
CONFIG_ARCH_OMAP3 compilation in struct omap_mcbsp_platform_data
definition.

I think it's easiest if this patch just removes that conditional
compilation from struct omap_mcbsp_platform_data as it really doesn't
save that much from non !OMAP3 builds.

-- 
Jarkko
