From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 0/7] Introducing a generic AMP framework
Date: Tue, 06 Dec 2011 14:09:13 -0800
Message-ID: <4EDE9289.8040903@codeaurora.org>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com> <4ECC67B9.4050306@codeaurora.org> <CAK=WgbYyrbZLmDOx8yKWwjhn2MYN8669FDRvsYZSyLj1equcTw@mail.gmail.com> <20111123161012.GA31423@sirena.org.uk> <4ECD5767.90307@codeaurora.org> <CAK=Wgba49eu_MGTWP_SND1=KDPp=MfuDyvxFGA_NND=ydqBmZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=Wgba49eu_MGTWP_SND1=KDPp=MfuDyvxFGA_NND=ydqBmZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/24/2011 12:43 AM, Ohad Ben-Cohen wrote:
> On Wed, Nov 23, 2011 at 10:28 PM, Saravana Kannan
> <skannan@codeaurora.org>  wrote:
>> remoteproc would probably be the best fit since it's already used in the
>> code and people are used to discussing about it.
>
> Guys you realize that 'amp' isn't really being used in the code
> itself; this discussion boils down to the text we have in the patches'
> subject line and the top level Kconfig/folder entry :)
>
> But, sure, I'll just drop those 'amp' text instances, and we'll have
> 'remoteproc' and 'rpmsg' as separate top-level frameworks again.
>
> Thanks,
> Ohad.

Yes, I did realize it's not used in the code. I just wanted to prevent 
what I considered a misuse of "AMP". Thanks for accommodating my request.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
