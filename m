From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: microphone mixers
Date: Fri, 20 Jan 2017 14:38:30 +0100
Message-ID: <20170120133830.GF32502@pali>
References: <20170112181826.GA28290@amd>
 <201701121934.19810@pali>
 <20170114225614.GA25321@amd>
 <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
 <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
 <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
 <20170120133159.GA5241@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120133159.GA5241@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 20 January 2017 14:31:59 Pavel Machek wrote:
> Hi!
> 
> Do you have any idea how to control the microphone? I'd like the audio
> source to be microphone on headset (not the built in one). So I run
> alsamixer, set everything in "capture" section to zero... and I still
> get the audio from the internal microphone :-(.
> 
> Tested with arecord | aplay.
> 
> Any ideas?

Hi! Try to set Jack Function to Headset or enable b HS Mic.

-- 
Pali Rohár
pali.rohar@gmail.com
