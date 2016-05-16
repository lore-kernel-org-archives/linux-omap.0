From: Nishanth Menon <nm@ti.com>
Subject: Re: Can not play audio with screen off
Date: Mon, 16 May 2016 09:22:46 -0500
Message-ID: <5739D7B6.7060102@ti.com>
References: <20160515193106.GA18685@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160515193106.GA18685@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 05/15/2016 02:31 PM, Pavel Machek wrote:
> Hi!
> 
> I'm playing some more with N900, this time I'd like to use it as a
> alarm clock...
> 
> And now I realized I can not, because system performance is so
> horrible with screen off that mpg123 + pulseaudio skips horribly. This
> is without tweaking serial parameters, so CPU is definitely not going
> into the idle/off modes.
> 
> Loading CPU fixes the issue (I used cat /dev/zero > /dev/null).
> 
> Hmm. And it seems to work better if I ssh in and launch mpg123
> remotely. Weird.
> 
> Kernel 4.5-rc0. Will try on different ones.
> 
> Any ideas? Is there interface to tell kernel that better performance
> is needed for a while?
> 

pm_qos cpu_dma_latency? Drivers will have to be properly instrumented
with appropriate latency values -> this will control the depth in C
states that the system will attempt. NOTE: it is a dual edged sword,
bad configurations can result in none of the C-states being entered.


-- 
Regards,
Nishanth Menon
