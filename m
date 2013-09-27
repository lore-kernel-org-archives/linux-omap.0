From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: move fixed regulator to board
 level
Date: Fri, 27 Sep 2013 20:07:48 +0530
Message-ID: <5245983C.8090408@ti.com>
References: <1379610764-758-1-git-send-email-nm@ti.com> <20130920162154.GB18721@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130920162154.GB18721@radagast>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 20 September 2013 09:51 PM, Felipe Balbi wrote:
> On Thu, Sep 19, 2013 at 12:12:44PM -0500, Nishanth Menon wrote:
>> 3.3V fixed regulator does not belong to TPS node - as a result
>> the fixed regulator is never probed and MMC is continually deferred due
>> to lack of regulator.
>>
>> Move the fixed regulator to be at root of platform.
>>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>
> Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>

Tested-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
