From: Anil Kumar <anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] ARM: dts: omap3-devkit8000: Enable audio support
Date: Wed, 27 Feb 2013 08:12:52 +0530
Message-ID: <CABYxbz5izBpc96EG++Qa2dZM3XCFeygQ-d8TOdEVw0DCeT6Qsg@mail.gmail.com>
References: <1361000036-18121-1-git-send-email-anilk4.v@gmail.com>
 <51220E78.5000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51220E78.5000409-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Alsa Devel List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas-xePHB1Atl/Dsq35pWSNszA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Feb 18, 2013 at 4:50 PM, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> wro=
te:
> On 02/16/2013 08:33 AM, Anil Kumar wrote:
>> Add the needed sections to enable audio support on
>> Devkit8000 when booted with DT blob.
>>
>> Signed-off-by: Anil Kumar <anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Looks good:
> Acked-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Gentle Ping. As there are no review comments on this patch,
Could you please pull this patch ?

Thanks,
Anil
>
>> ---
>> This patch is based on top of kernel 3.8-rc5 and
>> the following patches.
>>
>> Peter Ujfalusi:-
>> ASoC: twl4030: Correct the support for Voice port
>> ASoC: twl4030: Convert MICBIAS to SUPPLY widget
>> ASoC: omap-twl4030: Add support for routing, voice port and jack detect
>>
>> Anil Kumar:-
>> ARM: dts: add minimal DT support for DevKit8000
>> https://patchwork.kernel.org/patch/2122461/
>>
>> -Tested for playback and capture on Devkit8000.
>>
>>  Test process:-
>>
>>  #amixer set 'PredriveR Mixer AudioR2' on
>>  #amixer set 'PredriveL Mixer AudioL2' on
>>  #amixer set PreDriv 100 unmute
>>  #amixer set 'DAC2 Digital Fine' 100
>>  #amixer cset numid=3D27 1
>>  #arecord | aplay
>>
>> For V2:
>>  - Remove pin mux as done at device boot time by default.
>>
>> :100644 100644 6338993... c70116f... M        arch/arm/boot/dts/omap3-de=
vkit8000.dts
>>  arch/arm/boot/dts/omap3-devkit8000.dts |   23 +++++++++++++++++++----
>>  1 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/=
omap3-devkit8000.dts
>> index 6338993..c70116f 100644
>> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
>> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
>> @@ -42,6 +42,19 @@
>>                  };
>>
>>       };
>> +
>> +     sound {
>> +             compatible =3D "ti,omap-twl4030";
>> +             ti,model =3D "devkit8000";
>> +
>> +             ti,mcbsp =3D <&mcbsp2>;
>> +             ti,codec =3D <&twl_audio>;
>> +             ti,audio-routing =3D
>> +                     "Ext Spk", "PREDRIVEL",
>> +                     "Ext Spk", "PREDRIVER",
>> +                     "MAINMIC", "Main Mic",
>> +                     "Main Mic", "Mic Bias 1";
>> +     };
>>  };
>>
>>  &i2c1 {
>> @@ -51,6 +64,12 @@
>>               reg =3D <0x48>;
>>               interrupts =3D <7>;       /* SYS_NIRQ cascaded to intc */
>>               interrupt-parent =3D <&intc>;
>> +
>> +             twl_audio: audio {
>> +                     compatible =3D "ti,twl4030-audio";
>> +                     codec {
>> +                     };
>> +             };
>>       };
>>  };
>>
>> @@ -86,10 +105,6 @@
>>       status =3D "disabled";
>>  };
>>
>> -&mcbsp2 {
>> -     status =3D "disabled";
>> -};
>> -
>>  &mcbsp3 {
>>       status =3D "disabled";
>>  };
>>
>
>
> --
> P=E9ter
