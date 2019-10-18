From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: fix max fclk divider for omap36xx
Date: Fri, 18 Oct 2019 10:18:28 +0300
Message-ID: <406842b9-18f0-ddf7-5317-4ace265d0ac2@ti.com>
References: <20191002122542.8449-1-tomi.valkeinen@ti.com>
 <CAHCN7xLjGkLHMWejEk-3vJ-OwzjB+BXtnPWoonh4mAVxbkzMWQ@mail.gmail.com>
 <CAHCN7xKN7CePgajQLH61dBaoLWZ4VMxo39_xJOWHyvM3x_0i=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xKN7CePgajQLH61dBaoLWZ4VMxo39_xJOWHyvM3x_0i=A@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 17/10/2019 21:05, Adam Ford wrote:

>> Is there any way you can do a patch for the FB version for the older
>> 4.9 and 4.14 kernels?  I think they are still defaulting to the omapfb
>> instead of DRM, so the underflow issue still appears by default and
>> the patch only impacts the DRM version of the driver.  If not, do you
>> have any objections if I submit a patch to stable for those two LTS
>> branches?
> 
> Gentle nudge on this question.  I can do the work, but I just
> permission so don't overstep.

Sure, go ahead.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
