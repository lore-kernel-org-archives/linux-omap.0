From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 0/5] Beaglebone-Black HDMI audio
Date: Wed, 17 Sep 2014 10:51:26 +0300
Message-ID: <54193D7E.5050900@ti.com>
References: <cover.1410898073.git.jsarha@ti.com> <CAPM=9txRReSdcB5j+0dKmrDNM94zANu-q7ZfWHtP2iA54Dieig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPM=9txRReSdcB5j+0dKmrDNM94zANu-q7ZfWHtP2iA54Dieig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, peter.ujfalusi-l0cyMroinI0@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, t-kristo-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tomi >> Valkeinen, Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/17/2014 04:06 AM, Dave Airlie wrote:
> On 17 September 2014 06:40, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:
>> Changes since v2:
>> - Change compatible property from "ti,gpio-clock" to "ti,gpio-gate-clock"
>> - Some minor cleanups
>>
>> The code has a functional dependency to:
>> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg109264.html
>>
>> Without the above patch the audio card does not probe.
>>
>> The code has been rebased on top of Linux 3.17-rc5. The patches
>> bellow, the above dependency, and couple of commits to add BBB HDMI audio
>> support to omap2plus_defconfig can be pulled from:
>>
>> https://github.com/jsarha/linux.git linux-master-bbb-hdmi-audio
>
> How do you intend to get this merge, sending patchsets like this without
> indication to maintainers on a merge strategy is kinda messy.
>
> I'm not sure how maintained tilcdc is.
>

Well, it is used but AFAIK the people who have been working with it the 
most have left TI. I think eventually someone at TI needs to take it 
over, but I do not know anything about that.

I was hoping that because the change to tilcdc is quite minimal it could 
go in via you. I am sure I could get a reviewed-by and tested-by from 
from Darren how has bit more experience with tilcdc and maybe from Tomi 
too if that helps. (Adding Tomi to cc).

The "drm/tilcdc: Add I2S HDMI audio config for tda998x"-patch itself 
just adds the audio configuration to pda998x pdata and fills the swap, 
and mirr parameters with default values (they are usually coming in hard 
coded at the beginning of tda998x_create()).

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
