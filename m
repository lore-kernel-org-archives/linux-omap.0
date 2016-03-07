From: Lokesh Vutla <a0131933-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dra7: Enable Errata i877
Date: Mon, 7 Mar 2016 15:10:00 +0530
Message-ID: <56DD4C70.7070105@ti.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1603070938170.3437@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1603070938170.3437-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Monday 07 March 2016 03:09 PM, Paul Walmsley wrote:
> On Thu, 3 Mar 2016, Lokesh Vutla wrote:
> 
>> This series enables Errata i877 for all DRA7 platforms. The public errata
>> documentation can be found here[1].
>>
>> [1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
>>
>> Lokesh Vutla (1):
>>   ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
>>
>> Mugunthan V N (1):
>>   ARM: dts: dra7: do not gate cpsw clock due to errata i877
> 
> I've sent these for merging immediately. 
> 
> Have you sent patches for U-boot yet?
Yes, It is already merged into u-boot.
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=f986d9720836433ded29f06c8f5aed462bd20924;hp=65e9d56fb9ce9cfd7ffff7afaa6b7de50e400e06

Thanks and regards,
Lokesh

> 
> 
> - Paul
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
