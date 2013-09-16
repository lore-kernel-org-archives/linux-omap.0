From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/7] Documentation: dt bindings: move ..usb/usb-phy.txt
 to ..phy/omap-phy.txt
Date: Mon, 16 Sep 2013 08:34:00 +0530
Message-ID: <52367520.8010909@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com> <1378136591-7463-5-git-send-email-kishon@ti.com> <5231C040.4040609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5231C040.4040609-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 12 September 2013 06:53 PM, Roger Quadros wrote:
> On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
>> Since now we have a separate folder for phy, move the PHY dt binding
>> documentation of OMAP to that folder.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   .../devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt}        |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>   rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt} (96%)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/phy/omap-phy.txt
>> similarity index 96%
>> rename from Documentation/devicetree/bindings/usb/usb-phy.txt
>> rename to Documentation/devicetree/bindings/phy/omap-phy.txt
>> index 36bdb17..2c485ee 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/omap-phy.txt
>
> ti-phy.txt?

maybe wait for that later?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
