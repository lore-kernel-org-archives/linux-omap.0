From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Mon, 22 Nov 2010 16:53:15 -0600
Message-ID: <4CEAF45B.5050907@ti.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com> <87oc9hm0zz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39890 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932166Ab0KVWx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 17:53:27 -0500
Received: by mail-yx0-f172.google.com with SMTP id 30so1696498yxk.3
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 14:53:19 -0800 (PST)
In-Reply-To: <87oc9hm0zz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Kevin Hilman wrote, on 11/22/2010 04:45 PM:
>>   static inline int omap3_opp_init(void)
>> >    {
>> >    	return -EINVAL;
>> >    }
>> >  +static inline int omap4_opp_init(void)
>> >  +{
>> >  +	return -EINVAL;
>> >  +}
>> >    #endif
> Now that these are device_initcalls, seems like they can be made static
> and not callable externally.
how do we handle boards that need custom opp table modifications?

-- 
Regards,
Nishanth Menon
