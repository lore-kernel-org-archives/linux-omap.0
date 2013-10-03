From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: AM33XX: add ethernet alias's for am33xx
Date: Thu, 03 Oct 2013 16:37:48 +0200
Message-ID: <524D813C.3070905@baylibre.com>
References: <1380736713-24678-1-git-send-email-dmurphy@ti.com> <524CAEBE.5010305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524CAEBE.5010305-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Dan,

On 03/10/2013 01:39, Mugunthan V N wrote:
> On Wednesday 02 October 2013 12:58 PM, Dan Murphy wrote:
>> Set the alias for ethernet0 and ethernet1 so that uBoot
>> can set the MAC address appropriately.
>>
>> Currently uBoot cannot find the alias and there for does not set the
>> MAC address.
>>
>> Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
>
> Tested this with beagle bone black.
>
> Tested-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
>
> Regards
> Mugunthan V N

Thanks, pulled in my for_3.13/dts branch.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
