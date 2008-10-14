From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 3/3] Hook into powerdomain code
Date: Tue, 14 Oct 2008 13:55:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810141353580.8581@utopia.booyaka.com>
References: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com> <1223995198-19985-2-git-send-email-peter.de-schrijver@nokia.com> <1223995198-19985-3-git-send-email-peter.de-schrijver@nokia.com>
 <1223995198-19985-4-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57407 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbYJNTzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 15:55:08 -0400
In-Reply-To: <1223995198-19985-4-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, 14 Oct 2008, Peter 'p2' De Schrijver wrote:

> @@ -179,9 +183,12 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
>  {
>  	struct powerdomain **p = NULL;
>  
> -	if (pwrdm_list)
> -		for (p = pwrdm_list; *p; p++)
> +	if (pwrdm_list) {
> +		for (p = pwrdm_list; *p; p++) {
>  			pwrdm_register(*p);
> +			_pwrdm_setup(*p);

perhaps I am going blind - could you point me at where _pwrdm_setup() is 
defined?

> +		}
> +	}
>  }

- Paul
