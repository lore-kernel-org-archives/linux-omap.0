From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver implementation
Date: Mon, 10 Mar 2014 15:25:41 +0200
Message-ID: <531DBD55.6030008@ti.com>
References: <cover.1394440470.git.jsarha@ti.com> <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com> <20140310125848.GI28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140310125848.GI28112-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/10/2014 02:58 PM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 10:52:21AM +0200, Jyri Sarha wrote:
>
>> >+- ai31xx-micbias-vg - MicBias Voltage setting
>> >+        0 or MICBIAS_OFF - MICBIAS output it not powered
> So, on every other version of this patch set I've suggested removing
> this as there's no reason why the bias would be wired up but disabled.
> Each time you seem to agree that the option should be removed yet here
> it is again...
>

I agreed on not to have it as the default. I can still imagine couple of 
reason to have this option around. For instance, if the board designer 
decides to pull the bias voltage from outside of the chip completely, or 
like in my test setup when I feed the mic input from a headset output of 
another device, because I do not have a microphone around ATM.

But if you want it removed, I'll do it.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
