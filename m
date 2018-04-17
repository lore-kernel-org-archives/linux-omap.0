From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] regulator: Fix return type of of_map_mode()
Date: Tue, 17 Apr 2018 19:48:22 +0200
Message-ID: <CABxcv=n6HFXB+sAW_8qwMJWwWXDgspFgNs9Kk37hMO53EimWCg@mail.gmail.com>
References: <20180417171204.259146-1-dianders@chromium.org> <20180417172229.GK8973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417172229.GK8973@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, David Collins <collinsd@codeaurora.org>, evgreen@chromium.org, swboyd@chromium.org, Linux Kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 17, 2018 at 7:22 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Apr 17, 2018 at 10:12:04AM -0700, Douglas Anderson wrote:
>> In of_get_regulation_constraints() it can clearly be seen that the
>> return value of of_map_mode() is assigned to a signed integer.  This
>> is important because the first thing the regulator core does with this
>> value is to compare it to -EINVAL.
>>

Sorry about that, as Mark mentioned both the regulator device specific
and standard modes are a bitmap, and that's why I used an unsigned int
as return type.

IIRC, at some point in the review someone mentioned error handling and
I just blindly added a check for -EINVAL assuming the drivers would
return that, but forgot about the return type :(

>> Let's fix the return type of all of the current of_map_mode()
>> functions.  While we're at it, we'll remove one pointless "inline".
>
> Ah, I see...  the thing here is that the mode is always an unsigned int
> since it's a bitmask - this goes out beying the use in of_map_mode() and
> into all the other APIs.  We only actually use 4 bits currently so I
> think there's no problem switching to int but it seems we should
> probably do that consistently throughout the API so that things don't
> get missed later on.

Maybe another option could be to add a REGULATOR_MODE_INVALID with
value 0x0, and fix the drivers that are returning -EINVAL to return
that instead?

In of_get_regulation_constraints() we could check for that and
propagate -EINVAL.

Best regards,
Javier
