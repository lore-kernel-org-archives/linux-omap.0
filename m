From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
Date: Thu, 17 Nov 2016 21:44:44 -0600
Message-ID: <CAOCHtYiUz1cjYw9nNa4YZGtzNVgSgjEa=4Lqiktz07rszsSksw@mail.gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com> <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e69a797c-bec3-2243-5c19-9d7633092369-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 17, 2016 at 8:56 PM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
> On 11/17/2016 08:44 PM, Robert Nelson wrote:
> again.. a short commit message at least please? :)

yeah, i'll fix all those. ;)

>
>> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> CC: Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> CC: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> index 6df7829..3bc47be 100644
>> --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> @@ -97,6 +97,12 @@
>>                 #cooling-cells = <2>;
>>         };
>>
>> +       gpu-subsystem {
>
> A) do we want to make things clear that this is gpu subsystem for gc320?
> B) How about other platforms that could equally reuse?

so the 'gpu-subsystem' comes from etnaviv:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt?id=refs/tags/v4.9-rc5

For a generic name, it's currently only tied to the etnaviv driver:

gpu-subsystem {
 compatible = "fsl,imx-gpu-subsystem";
 cores = <&gpu_2d>, <&gpu_3d>;
};

it would make sense to make that more generic, so you could tie a 2d
vivante and a imgtec/sgx 3d core..  <sad laugh> but that would require
adding a imgtec/sgx driver/bindings to the kernel mainline... </sad
laugh>

>
>> +               compatible = "ti,gc320-gpu-subsystem";
>> +               cores = <&bb2d>;
>> +               status = "okay";
>> +       };
>> +
>>         hdmi0: connector {
>>                 compatible = "hdmi-connector";
>>                 label = "hdmi";
>> @@ -190,6 +196,11 @@
>>                 >;
>>         };
>>  };
>> +
>> +&bb2d {
>> +       status = "okay";
>> +};
>> +
>>  &i2c1 {
>>         status = "okay";
>>         clock-frequency = <400000>;
>>

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
