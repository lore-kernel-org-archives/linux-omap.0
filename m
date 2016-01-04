From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Mon, 4 Jan 2016 15:04:17 +0200
Message-ID: <568A6DD1.5050700@gmail.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali> <568A5970.2000201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568A5970.2000201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On  4.01.2016 13:37, Tomi Valkeinen wrote:
>
> We probably need exactly the same for omapdrm, as omapfb is on the way
> to being deprecated. And sounds to me that we probably need similar for
> other devices which try to do large allocations (camera? video decoders?).
>

Re omapdrm - I guess it wouldn't be hard for omapdrm to use the same 
preallocated memory, when/if it is needed. Though I know nothing about 
omapdrm, so can't really tell.

If not mistaken, camera driver uses sg lists. DSP needs such a memory, 
but anyway it(driver) was removed from mainline, with no signs/hope to 
be returned anytime soon.

> So I really think this should be somehow be a general option for any device.
>

Then maybe add the relevant people in CC, so we to start some kind of 
discussion. But until such a general option exists, I think it makes 
sense to apply the $subject patch, we can easily fix it to use whatever 
general purpose API might the discussion come up with. As it is now, 
omapfb simply cannot be used to play any video with sane resolution 
(without preallocated memory that is), unless this is the only thing the 
device does. And even then it is not assured.

> I also wonder if CMA can be improved to not need anything like this? If
> you just increase the CMA area, won't that increase the chances CMA will
> work?
>

The short answer is no, at least not with the CMA code currently 
upstream. A kind of a long answer could be found on 
http://marc.info/?l=linux-mm&m=141571797202006&w=2

Regards,
Ivo
