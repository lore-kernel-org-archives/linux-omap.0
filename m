From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Microphone gain on N900
Date: Sat, 4 Mar 2017 18:01:21 +0200
Message-ID: <defb507c-0f4b-7dfe-817b-cb488f289aa3@bitmer.com>
References: <20170226202831.GA31405@amd> <201702272053.37882@pali>
 <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
 <20170302142822.GA30427@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302142822.GA30427@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On 03/02/17 16:28, Pavel Machek wrote:
> Hi!
> 
>>>> v4.10 works quite nicely on N900, but I still have problems with
>>>> audio. Even GSM calls would be usable, if I had reasonable volume on
>>>> microphone and speaker... but I don't.
>>>>
>>>> Both speaker and microphone are too quiet. I can get louder output by
>>>> plugging headset -- good. I can hear the other side nicely, but am
>>>> too quiet for them. Unfortunately, even if I plug in wired headset,
>>>> internal microphone is still used.
>>>>
>> For me these settings provide reasonable playback and capture volumes
>> using v4.10.1:
>>
>> amixer -D hw:0 set PCM 100%
>> amixer -D hw:0 set 'Line DAC' 80% on
>> amixer -D hw:0 set 'Line' on
>> amixer -D hw:0 set 'Left Line Mixer DACL1' on
>> amixer -D hw:0 set 'Right Line Mixer DACR1' on
>> amixer -D hw:0 set 'Jack Function' 'Headphone'
>> amixer -D hw:0 set 'TPA6130A2 Headphone' 80%
>>
>> amixer -D hw:0 set 'Jack Function' 'Headset'
>> amixer -D hw:0 set 'AGC' off
>> amixer -D hw:0 set 'Input Select' 'ADC'
>> amixer -D hw:0 set 'Left PGA Mixer Line1L' on
>> amixer -D hw:0 set 'Left Line1L Mux' 'differential'
>> amixer -D hw:0 set 'Right PGA Mixer Line1L' on
>> amixer -D hw:0 set 'Right Line1L Mux' 'differential'
>> amixer -D hw:0 set 'ADC HPF Cut-off' '0.0045xFs' 'disabled'
>> amixer -D hw:0 set PGA 50% on
>> amixer -D hw:0 cset iface=MIXER,name='PGA Capture Switch',index=0 on
> 
> This seems to correspond to volumes I have had before. They are enough
> for phone call in quiet environment, but not really for normal usage.
> 
> Do you have settings where microphone on wired headset works?
> 
Those settings above. They are set after putting all volumes to 0 and
muted. I'm using the Nokia WH-205 headset that came with the phone.

-- 
Jarkko
