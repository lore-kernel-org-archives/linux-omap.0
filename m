From: Abraham Arce <x0066660@ti.com>
Subject: Re: [PATCH v6 7/8] OMAP4: Keyboard board support
Date: Fri, 1 Oct 2010 18:20:46 -0500
Message-ID: <4CA66CCE.4010208@ti.com>
References: <1285824973-25550-1-git-send-email-x0066660@ti.com> <20100930064055.GG5260@core.coreip.homeip.net> <20101001225127.GE3117@atomide.com> <87wrq14ipg.fsf@deeprootsystems.com> <20101001231417.GI3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20101001231417.GI3117@atomide.com>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin, Tony, Charu,

Tony Lindgren wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [101001 15:57]:
>> Dmitry,
>>
>> Can you please drop patch 8 (the pm runtime one.)  As pointed out by
>> Charu,  with the proposed platform changes, this cannot work
>> correctly with runtime PM.
>>
>> Tony, I also propose we don't merge the platform code yet either until
>> Abraham can respond to the platform-specific issues and runtime PM
>> issues.
>>
>> I'm fine with Dmitry merging the rest of the driver changes though.
> 
> OK, I'll drop 1, 6 & 7.
> 
> Merging the rest of the driver changes sounds good to me too,
> that way there's no longer a build dependecy on the plat/omap4-keypad.h ;)
> 
> Tony

I'll take care of the changes in 2 days, out due to a high priority 
activity.

Best Regards
Abraham
