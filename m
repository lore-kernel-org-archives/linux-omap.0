From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
Date: Tue, 17 Jan 2017 15:47:19 +0200
Message-ID: <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: alsa-devel@alsa-project.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, broonie@kernel.org, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, lars@metafoo.de, abcloriens@gmail.com, helen.koike@collabora.co.uk, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 01/15/2017 09:08 PM, Jarkko Nikula wrote:
> On 01/15/2017 12:05 PM, Pavel Machek wrote:
>>>> So regression seems to be between v4.9 and v4.10. Any ideas?
>>>
>>> Interesting... seems there are no sound relevant changes after v4.9.
>>>
>>> Looks like there are only three commits after v4.9 for sound/soc which =

>>> are built for Nokia N900:
>>>
>>> e411b0b5eb9b65257a050eac333d181d6e00e2c6
>>> e7aa450fe17890e59db7d3c2d8eff5b6b41fc531
>>> 63c3194b82530bd71fd49db84eb7ab656b8d404a
>>>
>>> Maybe something not related to sound/soc could broke it?
>>
>> Lets see.
>>
>> a9042defa29a01cc538b742eab047848e9b5ae14 -- works ok.
>> ce38207f161513ee3d2bd3860489f07ebe65bc78 --
>>
>> alsactl: set_control:1328: failed to obtain info for control #229 (No
>> such file or directory)
>>
> I'm unable to test older kernels at the moment since modules don't load
> by some reason (bluetooth: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err
> 0)). Probably some recent regression in my debian/testing installation
> since the same configs were working before.
> =

> However v4.9.4 works and with it I can see there is an issue with these
> aic3x controls:
> =

> amixer: Unable to find simple control 'Left DAC_L1 Mixer Line',0
> =

> =

> =

> amixer: Unable to find simple control 'Right DAC_R1 Mixer Line',0

These are certainly not the regression between 4.6 and 4.9, more like
more like regression since 2.6:
'Line Switch' -> 'LineL Switch':
54f01916297bafc18bd7df4e2300a0544a84fce3

'LineL Switch' -> 'DACL1 Switch':
c3b79e05b4d9ab2e7c3ba281261ea87ab5b71a92

> At quick look I don't see why above commits could cause it. Maybe
> regression happened earlier between v4.6 and v4.9?

It might be that there were some work to fix control names for different aic
versions to match with the HW or support for new codec is added and some
control gone missing for 3x?

I would compare the 'amixer controls' for the working and regressed
kernel to see what differs. From there git blame or smthing will for
sure point to the correct commit.

-- =

P=E9ter
