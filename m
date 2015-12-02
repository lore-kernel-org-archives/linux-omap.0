From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH v2 1/6] ARM: OMAP2+: dts: cm-t335: add initial support
Date: Wed, 2 Dec 2015 12:44:01 +0200
Message-ID: <565ECB71.4090205@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-2-git-send-email-uri.mashiach@compulab.co.il>
 <20151130195123.GP2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151130195123.GP2517-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 11/30/2015 09:51 PM, Tony Lindgren wrote:
> * Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> [151124 06:03]:
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> ...
>
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pins>;
>> +
>> +	status = "okay";
>> +};
>> +
>
> FYI, the extra line break at the end of the file causes whitespace
> warnings when applying. And fixing that causes extra hassles with
> applying the other patches in the series as the patches won't apply..
> So for the next time, you may want to check that ;)

Yes, I will definitely do that.

>
> Also, the subject line should be "ARM: dts: ..." for the dts changes
> so the git log loooks unified for all the ARM SoCs.

Got it. Thanks!

>
> Anyways, I've fixed up those locally and applying into omap-for-v4.5/dt.
>

Thank you Tony!

-- 
Regards,
Uri.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
