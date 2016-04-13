From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for dra72-evm rev C (ES2.0)
Date: Wed, 13 Apr 2016 16:54:14 -0500
Message-ID: <570EC006.7050900@ti.com>
References: <1458859969-14298-1-git-send-email-nm@ti.com>
 <1458859969-14298-2-git-send-email-nm@ti.com>
 <20160412211322.GE5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160412211322.GE5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/12/2016 04:13 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160324 15:53]:
>> DRA72-EVM now has an upgrade to Rev C with ES2.0 silicon. As part of
>> this change, a few updates were factored in that were software
>> incompatible with previous board in few areas:
>> - We now use DP83867 ethernet phy instead of older DP838865 which fails
>>   in certain usecases.
>> - Two ethernet ports now instead of the single one in rev B.
>> - polarities changed for certain pcf gpios
>> - Due to SoC phy current requirements, VDDA supplies are split between
>>  ldo5 and ldo2 (ldo2 was previously unused). NOTE: DSS (VDDA_VIDEO) is
>>  still supplied by ldo5.
>>
>> NOTE: It does not make much sense to spin off a new board compatible
>> flag since there is no real benefit for the same.
> 
> I guess that can always be added later on if needed.
> 
> Can you please repost this against current omap-for-v4.7/dt as it
> no longer applies?

Will do. thanks.
-- 
Regards,
Nishanth Menon

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
