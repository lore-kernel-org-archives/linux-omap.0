From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 19 Aug 2010 09:53:29 +0300
Message-ID: <20100819095329.3c39a8a9.jhnikula@gmail.com>
References: <1282147013-508-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45966 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab0HSGxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 02:53:11 -0400
Received: by ewy23 with SMTP id 23so979926ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Aug 2010 23:53:09 -0700 (PDT)
In-Reply-To: <1282147013-508-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Wed, 18 Aug 2010 10:56:51 -0500
Robert Nelson <robertcnelson@gmail.com> wrote:

> +	ret = gpio_request(171, "rev_id_0");
> +	if (ret < 0)
> +		goto fail0;
> +
> +	ret = gpio_request(172, "rev_id_1");
> +	if (ret < 0)
> +		goto fail1;
> +
> +	ret = gpio_request(173, "rev_id_2");
> +	if (ret < 0)
> +		goto fail2;
...
> +fail2:
> +	gpio_free(173);
> +fail1:
> +	gpio_free(172);
> +fail0:
> +	gpio_free(171);

This must be:

+fail2:
+	gpio_free(172);
+fail1:
+	gpio_free(171);
+fail0:

Otherwise the set looks good to me.


-- 
Jarkko
