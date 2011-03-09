From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 2 15/18] I2C: OMAP2+: add correct functionality flags
 to all omap2plus i2c dev_attr
Date: Wed, 09 Mar 2011 14:04:05 +0000
Message-ID: <4D7788D5.8040603@linaro.org>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <20110308110912.23531.6379.stgit@otae.warmcat.com> <4D778551.5010900@ti.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60986 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab1CIOEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 09:04:10 -0500
Received: by wya21 with SMTP id 21so448242wya.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 06:04:09 -0800 (PST)
In-Reply-To: <4D778551.5010900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Ben Dooks <ben-linux@fluff.org>

On 03/09/2011 01:49 PM, Somebody in the thread at some point said:

Hi -

> I have one minor comment about the OMAP4 dev_attr position in the
> structure. The point here is just to be aligned with the template
> used by the generator.
>
> Acked-by: Benoit Cousson<b-cousson@ti.com>

> The generator is adding a (probably useless...) comment on top of the
> structure. For the comment I'd prefer to stick to the template. I'll
> do a massive cleanup when every OMAP4 drivers will be migrated to
> hwmod. And then OMAP2&  3 at some point will stick to that as well.

> The OMAP4 part should look like the patch below. I've just updated
> the scripts to add the new data you introduced.

I'm fine if you just want to replace that stanza with yours that matches 
the script's member ordering.  Thanks for a rapid review ^^

-Andy
