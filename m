From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 2/3] DT: EVM: add LEDs
Date: Tue, 27 Sep 2016 22:10:35 +0200
Message-ID: <21B97601-328A-41DC-84EE-AA15A6977E98@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com> <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com> <20160927194904.4im7ukktg5afjmki@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160927194904.4im7ukktg5afjmki-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 27.09.2016 um 21:49 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> 
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160926 22:27]:
>> +		led@6 {
>> +			label = "omap5:green:led3";
>> +			gpios = <&gpio9 4 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +			default-state = "off";
>> +		};
>> +
>> +		led@7 {
>> +			label = "omap5:green:led4";
>> +			gpios = <&gpio9 5 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +			default-state = "off";
>> +		};
>> +
>> +		led@8 {
>> +			label = "omap5:green:led5";
>> +			gpios = <&gpio9 6 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +			default-state = "off";
>> +		};
> 
> How about this for defaults:
> 
> - heartbeat for led3
> - cpu0 for led4
> - cpu1 for led5

Good idea. Will try.

What I don't exactly know is if these gpios based on an I2C-expander
can handle cpu activity triggers or if they are locked up if this i2c
processing triggers another cpu activity...

> 
> Or something along those lines that by default shows the
> active CPUs. Don't have a omap5-uevm near by right now so
> not sure about the ordering of the LEDs for displaying
> cpu0 and cpu1.

Will test tomorrow and if it works I can submit a v2.

BR and thanks,
Nikolaus
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
