From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] regulator: Don't return or expect -errno from of_map_mode()
Date: Wed, 18 Apr 2018 08:56:22 -0700
Message-ID: <CAD=FV=U2_G=6yPndd0Fdd=e0zoM6x+h0Zqqyt6qcWx3TDohSdg@mail.gmail.com>
References: <20180418033143.208986-1-dianders@chromium.org> <CABxcv=kx9KVJYPyRFBR5mzGgezoSmjrXpGa214E2v85YJYd1+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=kx9KVJYPyRFBR5mzGgezoSmjrXpGa214E2v85YJYd1+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>, Evan Green <evgreen@chromium.org>, swboyd@chromium.org, linux-omap <linux-omap@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Apr 18, 2018 at 12:15 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>> @@ -124,11 +124,12 @@ static void of_get_regulation_constraints(struct device_node *np,
>>
>>         if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
>>                 if (desc && desc->of_map_mode) {
>> -                       ret = desc->of_map_mode(pval);
>> -                       if (ret == -EINVAL)
>> +                       unsigned int mode = desc->of_map_mode(pval);
>
> I think the convention is to always declare local variables at the
> start of the function? Although I couldn't find anything in the coding
> style document...

I haven't seen this as a consistent kernel convention.  It seems a bit
up to the subsystem and/or driver maintainer.  However, I'm happy to
put it up at the top if it makes people happy.


>> @@ -163,12 +164,14 @@ static void of_get_regulation_constraints(struct device_node *np,
>>                 if (!of_property_read_u32(suspend_np, "regulator-mode",
>>                                           &pval)) {
>>                         if (desc && desc->of_map_mode) {
>> -                               ret = desc->of_map_mode(pval);
>> -                               if (ret == -EINVAL)
>> +                               unsigned int mode = desc->of_map_mode(pval);
>> +
>> +                               mode = desc->of_map_mode(pval);
>
> You are calling .of_map_mode and assigning the return value twice here.

Dang it, thanks for catching.


-Doug
