From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
Date: Sun, 15 Jan 2017 21:08:12 +0200
Message-ID: <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170115100533.GA15816@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/15/2017 12:05 PM, Pavel Machek wrote:
>>> So regression seems to be between v4.9 and v4.10. Any ideas?
>>
>> Interesting... seems there are no sound relevant changes after v4.9.
>>
>> Looks like there are only three commits after v4.9 for sound/soc which 
>> are built for Nokia N900:
>>
>> e411b0b5eb9b65257a050eac333d181d6e00e2c6
>> e7aa450fe17890e59db7d3c2d8eff5b6b41fc531
>> 63c3194b82530bd71fd49db84eb7ab656b8d404a
>>
>> Maybe something not related to sound/soc could broke it?
> 
> Lets see.
> 
> a9042defa29a01cc538b742eab047848e9b5ae14 -- works ok.
> ce38207f161513ee3d2bd3860489f07ebe65bc78 --
> 
> alsactl: set_control:1328: failed to obtain info for control #229 (No
> such file or directory)
> 
I'm unable to test older kernels at the moment since modules don't load
by some reason (bluetooth: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err
0)). Probably some recent regression in my debian/testing installation
since the same configs were working before.

However v4.9.4 works and with it I can see there is an issue with these
aic3x controls:

amixer: Unable to find simple control 'Left DAC_L1 Mixer Line',0



amixer: Unable to find simple control 'Right DAC_R1 Mixer Line',0


At quick look I don't see why above commits could cause it. Maybe
regression happened earlier between v4.6 and v4.9?

-- 
Jarkko
