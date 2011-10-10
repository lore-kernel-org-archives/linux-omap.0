From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 1/5] regulator: twl: Remove hardcoded board constraints
 from driver
Date: Mon, 10 Oct 2011 22:04:23 +0530
Message-ID: <4E931E8F.9030808@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com> <1318263578-7407-2-git-send-email-rnayak@ti.com> <20111010162507.GF3607@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111010162507.GF3607@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 10 October 2011 09:55 PM, Mark Brown wrote:
> On Mon, Oct 10, 2011 at 09:49:34PM +0530, Rajendra Nayak wrote:
>> Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
>> each regulator from the twl driver and let the boards pass it.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Acked-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
>
> Please update this changelog - as I said in reply to your previous
> posting this isn't actually hardcoding anything, it's dropping things
> from the constraints which the hardware doesn't support.

Looks like I completely missed the "&=" and your comment
on the previous posting. Looking at it now, seems to me
this patch is just un-necessary and what the driver seems
to be doing (preventing users from setting flags which the
hardware does not support) seems perfectly fine.
I will just go ahead and drop this patch.
