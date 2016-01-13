From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH v4 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
Date: Wed, 13 Jan 2016 08:00:34 +0200
Message-ID: <5695E802.7050909@compulab.co.il>
References: <1451482533-8624-1-git-send-email-uri.mashiach@compulab.co.il>
 <1451482533-8624-4-git-send-email-uri.mashiach@compulab.co.il>
 <87io35lq2p.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87io35lq2p.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kalle Valo,

On 01/07/16 11:02, Kalle Valo wrote:
> Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> writes:
> 
>> Device tree modifications:
>> - Pinmux for SPI0 and WiFi GPIOs.
>> - SPI0 node with wlcore as a child node.
>>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>> ---

Uri, please document the dependencies next time. Thanks!

>> v1 -> v2: Replace interrupts and interrupt-parent with interrupts-extended.
>> v2 -> v3: Move the pinctrl-0 = <&wifi_pins> to the wlcore node.
>> v3 -> v4: replace interrupts-extended with interrupts and interrupt-parent. (revert v2 modification).
>>           According to Rob Herring and Documentation/devicetree/bindings/interrupt-controller/interrupts.txt,
>> 	  interrupts-extended should only be used when a device has multiple interrupt parents.
>>
>>  arch/arm/boot/dts/am335x-cm-t335.dts | 55 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
> 
> To what tree should this patch go? My wireless-drivers-next tree doesn't
> even have this file.

Right. It will hit the mainline during this merge window through Tony's and
arm-soc trees.

Do you think it will be sensible if you take 1/3 and 2/3 patches and Tony
will take the 3/3 (there is no code dependency between first two and the last one),
or we can just wait till arm-soc hits the mainline, so you will have the
needed code?

> 
> https://patchwork.kernel.org/patch/7933441/
> 

-- 
Regards,
Igor.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
