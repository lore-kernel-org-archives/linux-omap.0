From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] wlcore/wl12xx: spi: add power operation function
Date: Mon, 28 Dec 2015 16:16:05 +0200
Message-ID: <56814425.7000601@compulab.co.il>
References: <1450971335-15961-1-git-send-email-uri.mashiach@compulab.co.il>
 <1450971335-15961-2-git-send-email-uri.mashiach@compulab.co.il>
 <567C1E3B.3020404@ti.com> <56801C78.9040102@compulab.co.il>
 <5681241F.1060603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5681241F.1060603-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On 12/28/2015 01:59 PM, Grygorii Strashko wrote:
> On 12/27/2015 07:14 PM, Uri Mashiach wrote:
>> Hello Grygorii,
>>
>> On 12/24/2015 06:32 PM, Grygorii Strashko wrote:
>>> On 12/24/2015 05:35 PM, Uri Mashiach wrote:
>>>> The power function uses a consumer regulator access to update the WiFi
>>>> enable GPIO value.
>>>>
>>>> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>>>> ---
>>>> v1 -> v2: oops fix was removed to a separate fix.
>>>>
>>>>    drivers/net/wireless/ti/wlcore/spi.c | 37
>>>> ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/ti/wlcore/spi.c
>>>> b/drivers/net/wireless/ti/wlcore/spi.c
>>>>
>>>
>>> [...]
>>>
>>>> +
>>>>    static struct wl1271_if_operations spi_ops = {
>>>>        .read        = wl12xx_spi_raw_read,
>>>>        .write        = wl12xx_spi_raw_write,
>>>>        .reset        = wl12xx_spi_reset,
>>>>        .init        = wl12xx_spi_init,
>>>> +    .power        = wl12xx_spi_set_power,
>>>>        .set_block_size = NULL,
>>>>    };
>>>>
>>>> @@ -353,6 +384,12 @@ static int wl1271_probe(struct spi_device *spi)
>>>>         * comes from the board-peripherals file */
>>>>        spi->bits_per_word = 32;
>>>>
>>>> +    glue->reg = devm_regulator_get(&spi->dev, "vwlan");
>>>> +    if (IS_ERR(glue->reg)) {
>>>
>>> It will be more correct to handle -EPROBE_DEFER here also. Like:
>>>            if (PTR_ERR(glue->reg) == -EPROBE_DEFER)
>>>               return PTR_ERR(glue->reg);
>>>
>>
>> It seems that the IS_ERR(glue->reg) condition covers the EPROBE_DEFER case.
>
> True. But this is not an error and it's common practice do not print
> any log messages in this case from driver :)
>

Sorry, already posted v3.
Will be in v4.

>>
>>>> +        dev_err(glue->dev, "can't get regulator\n");
>>>> +        return PTR_ERR(glue->reg);
>>>> +    }
>>>> +
>>>>        ret = spi_setup(spi);
>>>>        if (ret < 0) {
>>>>            dev_err(glue->dev, "spi_setup failed\n");
>>>>
>>>
>>>
>>
>
>

-- 
Thanks,
Uri
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
