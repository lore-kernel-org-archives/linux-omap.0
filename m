From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ASoC: Fix the power update function for
	snd_soc_dapm_value_mux
Date: Fri, 16 Jan 2009 11:33:36 +0200
Message-ID: <20090116093334.GU4128@atomide.com>
References: <1232092086-30074-1-git-send-email-peter.ujfalusi@nokia.com> <1232092086-30074-2-git-send-email-peter.ujfalusi@nokia.com> <s5hmydrfw6y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64227 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbZAPJdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 04:33:37 -0500
Content-Disposition: inline
In-Reply-To: <s5hmydrfw6y.wl%tiwai@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

* Takashi Iwai <tiwai@suse.de> [090116 11:16]:
> At Fri, 16 Jan 2009 09:48:06 +0200,
> Peter Ujfalusi wrote:
> > 
> > Modify the check for the mux type to also handle the
> > snd_soc_dapm_value_mux type in a same way as the snd_soc_dapm_mux.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> FYI, it's already in Linus tree.

Thanks, will get it on the next merge then.

Tony

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/soc/soc-dapm.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> > index 493a4e8..a2f1da8 100644
> > --- a/sound/soc/soc-dapm.c
> > +++ b/sound/soc/soc-dapm.c
> > @@ -720,7 +720,8 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
> >  	struct snd_soc_dapm_path *path;
> >  	int found = 0;
> >  
> > -	if (widget->id != snd_soc_dapm_mux)
> > +	if (widget->id != snd_soc_dapm_mux &&
> > +	    widget->id != snd_soc_dapm_value_mux)
> >  		return -ENODEV;
> >  
> >  	if (!snd_soc_test_bits(widget->codec, e->reg, mask, val))
> > -- 
> > 1.6.1
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
