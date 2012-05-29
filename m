From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 05/11] mfd: omap: control: core system
	control driver
Date: Tue, 29 May 2012 15:31:43 +0200
Message-ID: <4FC4CFBF.7070702@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
	<CAMQu2gy_rgLidHWy7xxZBiVD4wfFuTvA+wC7joogrcFptwsx8w@mail.gmail.com>
	<20120528114225.GH3923@besouro>
	<CAMQu2gzmPqiq5Aj8Fu6Jctdzkzeq6nXVCJcVvXHn4DRB3ZqNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMQu2gzmPqiq5Aj8Fu6Jctdzkzeq6nXVCJcVvXHn4DRB3ZqNhw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, J Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 5/28/2012 3:15 PM, Shilimkar, Santosh wrote:
> On Mon, May 28, 2012 at 5:12 PM, Eduardo Valentin

[...]

>>>> +/**
>>>> + * omap_control_readl: Read a single omap control module register.
>>>> + *
>>>> + * @dev: device to read from.
>>>> + * @reg: register to read.
>>>> + * @val: output with register value.
>>>> + *
>>>> + * returns 0 on success or -EINVAL in case struct device is invalid.
>>>> + */
>>>> +int omap_control_readl(struct device *dev, u32 reg, u32 *val)
>>>> +{
>>>> +       struct omap_control *omap_control = dev_get_drvdata(dev);
>>>> +
>>>> +       if (!omap_control)
>>>> +               return -EINVAL;
>>>> +
>>>> +       *val = readl(omap_control->base + reg);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(omap_control_readl);
>>>> +
>>> I might have missed in the last scan, but can you let
>>> function return the register value.
>>
>> Why?
>>
> Because thats how typical read 1 value kind of functions
> look like..

Yeah, I tend to agree with Santosh here as well. I'm expecting such API 
to return the value.
Moreover the error handling in that case is really an exception and thus 
a WARM is enough since it should never ever happen except if there is a 
bug during the probe. And in that case, it should already fail at probe 
time.

>>> I am guessing, you did this for error case handling. You might
>>> want to stick to read API semantic and just have WARN_ON()
>>> to take care of error case.
>>
>> Yeah, that was for error handling and to do not confuse register
>> values with error values.
>>
> No strong opinion if you like it that way but it just appeared odd to
> me from a caller perspective.

Yep, I do agree.

Benoit
