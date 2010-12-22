From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: rx51: Remove tvout code that plays with gpio 40
Date: Wed, 22 Dec 2010 10:57:55 -0800
Message-ID: <20101222185755.GB7771@atomide.com>
References: <1292953561-22979-1-git-send-email-jhnikula@gmail.com>
 <1293012004.6829.2.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39141 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0LVS57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 13:57:59 -0500
Content-Disposition: inline
In-Reply-To: <1293012004.6829.2.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srikar <ext-srikar.1.bhavanarayana@nokia.com>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [101222 01:59]:
> On Tue, 2010-12-21 at 19:46 +0200, ext Jarkko Nikula wrote:
> > Commit 60d24ee "Added video data to support tvout on rx51" added code that
> > tries to assign gpio 40 as OMAP DSS reset_gpio for tvout. This is wrong
> > since this gpio has nothing to do with OMAP DSS but it is used to control
> > one switch that selects is the audio jack connected to tvout or audio
> > circuitry.
> > 
> > This switch is already supported by the RX51 ASoC driver so there is no need
> > to control it elsewhere. Switch is contolled with ALSA control
> > 'Jack Function' and tvout can be selected with following example:
> > 
> > 	amixer -D hw:0 set 'Jack Function' 'TV-OUT'
> 
> Looks good. platform_enable/disable and reset_gpio fields should anyway
> be removed from the omap_dss_device struct, so this goes into right
> direction.
> 
> Tony, can you take this patch also, as (I guess) it depends on the
> previous rx51 patches from Jarkko?
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Queuing this one too.

Tony
