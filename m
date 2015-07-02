From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ARM: DTS: am437x-sk-evm: Switch using
 simple-audio-card for audio support
Date: Thu, 2 Jul 2015 15:52:49 +0300
Message-ID: <55953421.30009@ti.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <1435838286-30491-3-git-send-email-peter.ujfalusi@ti.com>
 <20150702122337.GE5837@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150702122337.GE5837@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/02/2015 03:23 PM, Felipe Balbi wrote:
> On Thu, Jul 02, 2015 at 02:58:06PM +0300, Peter Ujfalusi wrote:
>> The sound support consist only Headset output on the board and can b=
e
>> handled by "simple-audio-card"
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> Still works fine:
>=20
> Tested-by: Felipe Balbi <balbi@ti.com>
>=20
> one question though, should Line In be listed below ?

Does the board have Line-in? I don't have the board, but I know this pa=
tch
works on it ;)
We only had playback path before also.

> Also, unrelated to
> $subject, but if I wait for a few seconds between runs of speaker-tes=
t
> (iow, if I allow mcasp to idle) then I hear a slight chopping sound w=
hen
> starting, perhaps we're unmuting too early ?

Is it only with this patch (via simple-card) or was it the same via the
davinci-evm (ti,da830-evm-audio)?

--=20
P=E9ter

>=20
>> ---
>>  arch/arm/boot/dts/am437x-sk-evm.dts | 30 ++++++++++++++++++++++----=
----
>>  1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts=
/am437x-sk-evm.dts
>> index b5de6b0d622c..e09216cb14df 100644
>> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
>> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
>> @@ -32,14 +32,26 @@
>>  	};
>> =20
>>  	sound {
>> -		compatible =3D "ti,da830-evm-audio";
>> -		ti,model =3D "AM437x-SK-EVM";
>> -		ti,audio-codec =3D <&tlv320aic3106>;
>> -		ti,mcasp-controller =3D <&mcasp1>;
>> -		ti,codec-clock-rate =3D <24000000>;
>> -		ti,audio-routing =3D
>> -			"Headphone Jack",       "HPLOUT",
>> -			"Headphone Jack",       "HPROUT";
>> +		compatible =3D "simple-audio-card";
>> +		simple-audio-card,name =3D "AM437x-SK-EVM";
>> +		simple-audio-card,widgets =3D
>> +			"Headphone", "Headphone Jack";
>> +		simple-audio-card,routing =3D
>> +			"Headphone Jack",	"HPLOUT",
>> +			"Headphone Jack",	"HPROUT";
>> +		simple-audio-card,format =3D "dsp_b";
>> +		simple-audio-card,bitclock-master =3D <&sound_master>;
>> +		simple-audio-card,frame-master =3D <&sound_master>;
>> +		simple-audio-card,bitclock-inversion;
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai =3D <&mcasp1>;
>> +		};
>> +
>> +		sound_master: simple-audio-card,codec {
>> +			sound-dai =3D <&tlv320aic3106>;
>> +			system-clock-frequency =3D <24000000>;
>> +		};
>>  	};
>> =20
>>  	matrix_keypad: matrix_keypad@0 {
>> @@ -489,6 +501,7 @@
>>  	};
>> =20
>>  	tlv320aic3106: tlv320aic3106@1b {
>> +		#sound-dai-cells =3D <0>;
>>  		compatible =3D "ti,tlv320aic3106";
>>  		reg =3D <0x1b>;
>>  		status =3D "okay";
>> @@ -649,6 +662,7 @@
>>  };
>> =20
>>  &mcasp1 {
>> +	#sound-dai-cells =3D <0>;
>>  	pinctrl-names =3D "default", "sleep";
>>  	pinctrl-0 =3D <&mcasp1_pins>;
>>  	pinctrl-1 =3D <&mcasp1_pins_sleep>;
>> --=20
>> 2.4.5
>>
>=20
