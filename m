From: <ext-srikar.1.bhavanarayana@nokia.com>
Subject: RE: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Fri, 26 Nov 2010 09:42:55 +0000
Message-ID: <FE7260A13DF09F4ABF54F0E4A700232104A1B1@008-AM1MPN1-001.mgdnok.nokia.com>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>,<20101125161112.GB15099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:37628 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab0KZJpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 04:45:35 -0500
In-Reply-To: <20101125161112.GB15099@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)

The ifdefs here aren't really saving much...
>>> In the same file board-rx51-peripheral.c,Under these  rx51_display_device is
defined  as extern  and also in board-rx51-video.c the under same #defines Complete display functionality is implemented
currently so used  not to break compilation when #defines are not enabled .

>>.dev_name is preferred, though I'm not sure if we'll ever get round to
phasing out plain dev.
>>>>It is difficult to modify currently.

________________________________________
From: ext Mark Brown [broonie@opensource.wolfsonmicro.com]
Sent: Thursday, November 25, 2010 6:11 PM
To: Bhavanarayana Srikar.1 (EXT-Elektrobit/Helsinki)
Cc: tony@atomide.com; linux@arm.linux.org.uk; linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51

On Thu, Nov 25, 2010 at 05:52:23PM +0200, Srikar wrote:

> +static struct regulator_consumer_supply rx51_vdac_supply[] = {
> +     {
> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)

The ifdefs here aren't really saving much...

> +             .supply = "vdda_dac",
> +             .dev    = &rx51_display_device.dev,

dev_name is preferred, though I'm not sure if we'll ever get round to
phasing out plain dev.
