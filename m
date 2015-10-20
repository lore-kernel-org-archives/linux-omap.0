From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Date: Tue, 20 Oct 2015 18:48:00 +0200
Message-ID: <A872C46B-C0CF-4C67-9615-0A46EDAE9A57@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com> <05c57453151c9e2cbd3f15145f1e15223410cd87.1445000017.git.hns@goldelico.com> <20151020162425.GH3078@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151020162425.GH3078-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 20.10.2015 um 18:24 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:

> Hi,
> 
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [151016 05:58]:
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> arch/arm/boot/dts/omap5-uevm.dts | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index 0e8128b..63f81bb 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -342,6 +342,16 @@
>> 
>> 			ti,ldo6-vibrator;
>> 
>> +			gpadc {
>> +				compatible = "ti,palmas-gpadc";
>> +				interrupts = <18 0
>> +					      16 0
>> +					      17 0>;
>> +				#io-channel-cells = <1>;
>> +				ti,channel0-current-microamp = <5>;
>> +				ti,channel3-current-microamp = <10>;
>> +			};
>> +
>> 			regulators {
>> 				smps123_reg: smps123 {
>> 					/* VDD_OPP_MPU */
> 
> FYI, please send this one separately once the binding and driver is
> merged.
> 
> This need to be updated arch/arm/boot/dts/omap5-board-common.dts, so
> this will cause merge conflicts if applied with the driver.

Ok!

We have our own OMAP5 board in the pipeline and there it will help
as well to rebase it using arch/arm/boot/dts/omap5-board-common.dts

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
