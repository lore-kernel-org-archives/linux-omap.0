From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 18:30:58 +0200
Message-ID: <5661BFC2.3060807@ti.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com> <56608B72.1040101@ti.com>
 <20151203213715.GA23396@atomide.com> <56616E74.9000604@ti.com>
 <20151204153504.GF23396@atomide.com> <5661B861.7010203@ti.com>
 <5661BB1A.6020709@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5661BB1A.6020709@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/04/2015 06:11 PM, Sudeep Holla wrote:
> 
> 
> On 04/12/15 15:59, Grygorii Strashko wrote:
>>
>> Sorry, I can't test it right now :(
>> Potential fix below:
> 
> I had posted similar patch a while ago which Tony rejected.
> I might have made a mistake of not putting them together, though they
> were part of the same series[1], patch 12 and 16

True. I've remembered that I saw smth. like this, but I was not able to find it :(


-- 
regards,
-grygorii
