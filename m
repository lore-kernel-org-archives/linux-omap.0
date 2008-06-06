From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH] Fix for the i2c initialiation error on 2430sdp
Date: Fri, 6 Jun 2008 10:57:19 -0400
Message-ID: <a0580c510806060757t63d84b82qa889c52f3adcb70c@mail.gmail.com>
References: <c656a4d20806060612s55b047b2p783056dfac058093@mail.gmail.com>
	 <d2e4e528efc51e918b953d9b77673ea2@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:61037 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbYFFO5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 10:57:21 -0400
Received: by py-out-1112.google.com with SMTP id p76so810332pyb.10
        for <linux-omap@vger.kernel.org>; Fri, 06 Jun 2008 07:57:19 -0700 (PDT)
In-Reply-To: <d2e4e528efc51e918b953d9b77673ea2@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org

Hi,

On Fri, Jun 6, 2008 at 10:46 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Fri, 6 Jun 2008 18:42:56 +0530, "arun c"
> <arunedarath@mistralsolutions.com> wrote:
>>  static int __init omap2430_i2c_init(void)
>>  {
>> -     omap_register_i2c_bus(1, 400, NULL, 0);
>>       omap_register_i2c_bus(2, 2600, NULL, 0);
>> +     omap_register_i2c_bus(1, 400, NULL, 0);
>
> maybe there's a hw restriction that you must initiliaze
> hs bus first?

If that is the reason, it'd be good to add some comment here to avoid
people re-ordering it in the future.

> Could you check on i2c chapter of your trm?


>
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Eduardo Bezerra Valentin
