From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Mon, 16 Feb 2015 21:09:11 +0100
Message-ID: <54E24E67.9060806@cit-ec.uni-bielefeld.de>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <20150216171030.GS2531@atomide.com>
Reply-To: rabel@cit-ec.uni-bielefeld.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150216171030.GS2531@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@deeprootsystems.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 16 Feb 2015 18:10, Tony Lindgren wrote:
> * Robert ABEL <rabel@cit-ec.uni-bielefeld.de> [150216 07:52]:
>> GPMC uses GPMCFCLKDIVIDER during synchronous as well as asynchronous accesses
>> in conjunction with WAITMONITORINGTIME. Thus, it's wrong to only program it for
>> synchronous accesses. Remove the conditional.
> Do you have some test case that gets fixed by this? Or does this
> fix some regression?
>
> The reason why I'm asking is that AFAIK we've had async access
> working all along?
Maybe to clarify: This is only affects asynchronous accesses with 
WAITREADMONITORING and/or WAITWRITEMONITORING enabled. Regular 
asynchronous accesses without WAIT pin monitoring were never affected to 
begin with and are not affected by this change.

I don't have an off-hand test case and seeing as the current 
implementation is faulty, it's probable nobody actively uses this 
feature. Cf. OMAP35xx TRM (SPRUF98X) pp. 1103. Basically, 
WAITMONITORINGTIME extends the number of cycles from the end of WAIT 
asserted to when the data is provided/sampled and the read/write access 
(should) take place. While this behavior is esoteric, it's not a reason 
not to fix this oversight.

Regards,

Robert
