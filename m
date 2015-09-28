From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] ASoC: simple-card: Update clocks binding for
 simple-card DAI subnodes
Date: Mon, 28 Sep 2015 21:49:35 +0300
Message-ID: <56098BBF.2010700@ti.com>
References: <1441977482-29215-1-git-send-email-jsarha@ti.com>
 <20150919184225.GR30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150919184225.GR30445-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/19/15 21:42, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 04:18:02PM +0300, Jyri Sarha wrote:
>
>> The updated binding provides a way to set clock-ID and direction
>> parameters for DAI drivers set_sysclk() call back.
>
>> I proposed something similar about a year ago, but Mark rejected that
>> at the time. This RFC is to start that discussion again. This time
>> before I do any code changes.
>
> What's the use case again?  Can we address this by converting the
> relevant drivers to the clock API (or improving their clock API
> support)?
>

Sorry, I forgot to reply this earlier. The reason why we need this is 
the way McASP driver uses and provides clocks for different purposes. 
The most pressing need is to be able to select if we want to use some 
external clock pin as an input for McASP clock divider that produces the 
i2s bit-clock or if we want to use McASP's internal clock source.

There are several other things this binding would allow us, and others 
with flexible i2s HW, to do. Some TI codecs would also benefit from a 
flexible way of describing the used clock configuration, but Peter know 
that part better.

I tried to make the binding as flexible and generic as possible. But I 
do not currently see any immediate need for more than one set_sysclk() 
call per dai. I just did not see any reason to not allow it either.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
