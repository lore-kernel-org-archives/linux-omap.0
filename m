From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/3] OMAP: McBSP: Use textual values in DMA operating
 mode sysfs files
Date: Mon, 24 Aug 2009 10:35:03 +0300
Message-ID: <20090824103503.2ce92c16.jhnikula@gmail.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
	<1251019467-11677-2-git-send-email-jhnikula@gmail.com>
	<20090824064941.GA24398@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:37695 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZHXHdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 03:33:23 -0400
Received: by ewy3 with SMTP id 3so2118413ewy.18
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 00:33:24 -0700 (PDT)
In-Reply-To: <20090824064941.GA24398@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Mon, 24 Aug 2009 09:49:41 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> > +			len += sprintf(buf + len, "[%s] ", *s);
> > +		else
> > +			len += sprintf(buf + len, "%s ", *s);
> > +	}
> > +	len += sprintf(len+buf, "\n");
> 
> Just a tiny thing, add spaces before and after + operator:
> +	len += sprintf(len + buf, "\n");
> 
> > +	p = memchr(buf, '\n', size);
> > +	len = p ? p - buf : size;
> 
> I guess here we have two better options, please use one of these:
> * strstrip
> * sysfs_streq
> 
Thanks Eduardo. I'll fix the first the one and use the sysfs_streq as
it's much cleaner to use.

> >  
> > -	spin_lock_irq(&mcbsp->lock);
> > +	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++)
> > +		if (*s && len == strlen(*s) && !strncmp(buf, *s, len))
> 
> how about using strnicmp ??
> 
Are there need for case insensitive check? The sysfs_streq is not.

I'll send a new version later this day.


-- 
Jarkko
