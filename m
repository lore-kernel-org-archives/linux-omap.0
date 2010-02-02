From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/2 v2] DSPBRIDGE: remove dependency of mpu freq
Date: Tue, 2 Feb 2010 07:41:51 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012E98E8B9@dlee02.ent.ti.com>
References: <1265095046-25253-1-git-send-email-nm@ti.com>
 <1265095046-25253-2-git-send-email-nm@ti.com>
 <20100202130044.GB4048@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38796 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790Ab0BBNl7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:41:59 -0500
In-Reply-To: <20100202130044.GB4048@annwn.felipec.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Romit Dasgupta <romit@ti.com>


> From: Felipe Contreras [mailto:felipe.contreras@nokia.com]
> Sent: Tuesday, February 02, 2010 3:01 PM


> 
> On Tue, Feb 02, 2010 at 08:17:25AM +0100, Nishanth Menon wrote:
> > Current DSPBridge uses hardcoded logic which is not scalable
> > across OMAP3 silicons. introduce a structure based implementation
> > this allows for dsp frequency table indices to be generated runtime
> > instead of being compile time.
> 
> You forgot to mention the impact of this patch: DVFS is effectively
> disabled until the next patch is applied. Right?

That is the reason why it is a patch series 2/2 is the last of the series ;) I don't mind merging it as part of this patch though..

> 
> > +static int get_opp_table(struct dspbridge_platform_data *pdata)
> > +{
> > +#ifdef CONFIG_BRIDGE_DVFS
> > +	/* Do nothing now  - fill based on PM implementation */
> > +#endif
> > +	return 0;
> > +}
> 
> --
> Felipe Contreras

Regards,
Nishanth Menon

