Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAF37F735
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675781; cv=none; b=O2UKrh9TLIYIOx7SCpcEtoG9esJBETn3OCH/gotZB/VmcK1090lGzEEt2wNwMZpjeKGEJOqUslsoPny/c4QXrOTP+K8jsy5WphEtXukmtStM8NuLAlMyf0XYfWnB/RinAEsJWc3lkHlbu8oCpZ51Vs5VCPK3mqlCgqe23AT4nyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675781; c=relaxed/simple;
	bh=hjS4wGqHJxTE/IUU65IzABH7Wj1y99FvGUsSSQMBrFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP9B3LoyjOoxsxbshcQXP9xnSYpUnhC0XLbAljzBBz++IxuZxH3QQPZ/2hskhFULrW9Jy1X8LP7kbvRD1cEr9IZU0GwtITddfL3Es+m2/yfQakbhW8CKRgc3rQqAvAT0e7CqUEDXT9GbvdgehFhr6AV5AJO+M67ivbnrZSO6z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKBj7h7/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zqMvb+Z7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tb6BMQk9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=49pcOwHJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKBj7h7/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zqMvb+Z7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tb6BMQk9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="49pcOwHJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D98355BCDC;
	Thu, 29 Jan 2026 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769675768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQAc5T7zApr4eCsZOkLI7RX6tGsSY1oM0/JdDUvrtdQ=;
	b=CKBj7h7/hDPTUCxJGlPCl2+C5MyeZAUssqOt+zDUjH9WqToSjetMNtm+uPYKQGYeA1eMpX
	S416khMDeh3e8LDivYqH+pVpCJ/m6inub3gPXAgzHnh61ChpyVuzKnJQLt1SGwrsstKqiW
	nObP2GzSxY/FinviN1if6N59uGFLIXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769675768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQAc5T7zApr4eCsZOkLI7RX6tGsSY1oM0/JdDUvrtdQ=;
	b=zqMvb+Z7p05Zy9EdbQV1yftYyrDt/VeVZ/bn6kdPR/VfbkRSZme0oRgR/Ok14JAEy7Wnxp
	grI5wzf4fqCqoyCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tb6BMQk9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=49pcOwHJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769675767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQAc5T7zApr4eCsZOkLI7RX6tGsSY1oM0/JdDUvrtdQ=;
	b=Tb6BMQk9rD6tUH0WSy5kEIr6e0tquG5xkFxSkBmWDgSeoni+DJZ1PylNkIec8eGf+b8Hvx
	Y8ln+Il6EX4bI8j4WbdPZKlexh454D4DI8I275XwhAq0STIR8mGpRCfwRzwPJsBQyT3fyM
	CVSbEYtVprqPQRye9qC2dSlD1GkEQmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769675767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQAc5T7zApr4eCsZOkLI7RX6tGsSY1oM0/JdDUvrtdQ=;
	b=49pcOwHJeGqVt6cd2huJXtsU1P4b96MZeA1gcuQut66+Re8AkX0nU8oYN3OR3PcrgpZoxG
	gcjGI9Ym78x8xuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84E093EA61;
	Thu, 29 Jan 2026 08:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G83rHvcbe2nkaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 29 Jan 2026 08:36:07 +0000
Message-ID: <bfc6a338-de9e-404e-839f-245ff21b2968@suse.de>
Date: Thu, 29 Jan 2026 09:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] staging: fbtft: Fix build failure when
 CONFIG_FB_DEVICE=n
To: Chintan Patel <chintanlike@gmail.com>, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 andy@kernel.org, deller@gmx.de, gregkh@linuxfoundation.org,
 kernel test robot <lkp@intel.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260122031635.11414-1-chintanlike@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260122031635.11414-1-chintanlike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,kernel.org,gmx.de,linuxfoundation.org,intel.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email,suse.com:url,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: D98355BCDC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Hi,

we've seen reports about this bug from linux-next.

Did anyone merge this series?

Best regards
Thomas

Am 22.01.26 um 04:16 schrieb Chintan Patel:
> When CONFIG_FB_DEVICE is disabled, struct fb_info does
> not provide a valid dev pointer. Direct dereferences of
> fb_info->dev therefore result in build failures.
>
> Fix this by avoiding direct accesses to fb_info->dev and
> switching the affected debug logging to framebuffer helpers
> that do not rely on a device pointer.
>
> This fixes the following build failure reported by the
> kernel test robot.
>
> Fixes: a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601110740.Y9XK5HtN-lkp@intel.com
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>
> ---
> Changes in v8:
> - Add Reviewed-by tag from Andy Shevchenko.
>
> Changes in v7:
> - Split logging cleanups into a separate patch
> - Limit this patch to the CONFIG_FB_DEVICE=n build fix only
>
> Changes in v6:
> - Switch debug/info logging to fb_dbg() and fb_info()(suggested by Thomas Zimmermann)
> - Drop dev_of_fbinfo() usage in favor of framebuffer helpers that implicitly
>    handle the debug/info context.
> - Drop __func__ usage per review feedback(suggested by greg k-h)
> - Add Fixes tag for a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
>    (suggested by Andy Shevchenko)
>
> Changes in v5:
> - Initial attempt to replace info->dev accesses using
>    dev_of_fbinfo() helper
>
>   drivers/staging/fbtft/fbtft-core.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 8a5ccc8ae0a1..1b3b62950205 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -365,9 +365,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
>   	unsigned int val;
>   	int ret = 1;
>   
> -	dev_dbg(info->dev,
> -		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
> -		__func__, regno, red, green, blue, transp);
> +	fb_dbg(info,
> +	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
> +	       regno, red, green, blue, transp);
>   
>   	switch (info->fix.visual) {
>   	case FB_VISUAL_TRUECOLOR:
> @@ -391,8 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
>   	struct fbtft_par *par = info->par;
>   	int ret = -EINVAL;
>   
> -	dev_dbg(info->dev, "%s(blank=%d)\n",
> -		__func__, blank);
> +	fb_dbg(info, "blank=%d\n", blank);
>   
>   	if (!par->fbtftops.blank)
>   		return ret;
> @@ -793,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
>   	if (spi)
>   		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
>   			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
> -	dev_info(fb_info->dev,
> -		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
> -		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
> -		 fb_info->fix.smem_len >> 10, text1,
> -		 HZ / fb_info->fbdefio->delay, text2);
> +	fb_info(fb_info,
> +		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
> +		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
> +		fb_info->fix.smem_len >> 10, text1,
> +		HZ / fb_info->fbdefio->delay, text2);
>   
>   	/* Turn on backlight if available */
>   	if (fb_info->bl_dev) {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


