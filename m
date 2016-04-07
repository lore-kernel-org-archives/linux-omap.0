From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 01/20] mfd: Add devm_ apis for mfd_add_devices and mfd_release_devices
Date: Thu, 7 Apr 2016 16:14:34 +0530
Message-ID: <57063A12.4080200@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com> <1459856912-17859-2-git-send-email-ldewangan@nvidia.com> <20160407104403.GZ3323@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160407104403.GZ3323@x1>
Sender: linux-doc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Hi Lee,
Thanks for review.
I will send another patch with incorporating your comments.


On Thursday 07 April 2016 04:14 PM, Lee Jones wrote:
> On Tue, 05 Apr 2016, Laxman Dewangan wrote:
>
> +	if (!ret) {
> +		*ptr = dev;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> Switch these round.  If you encounter a problem, free and return.  If
> not, skip the error handling and add the device outside of the if().

Like below?

if (ret) {
      devres_free(ptr);
      return ret;
}

*ptr = dev;
devres_add(dev, ptr);

return ret;

>> + * Remove all mfd devices added on the device.
> s/mfd/MFD/
>
> 'D' already means devices, so here you are saying "devices devices".
> Please re-word.  Besides, you need to be more specific as to which
> "devices on the devices" you are detailing, since this sentence
> doesn't really make a great deal of sense.
Wanted to say
Remove all devices added by mfd_add_devices()  from parent device.


>> + * Normally this function will not need to be called and the resource
>> + * management code will ensure that the resource is freed.
> Then what is the purpose of providing it?  Do you have a user?

To have pair of release. I have not seen the usage of most of 
devm_*_release() function other than devm_kfree().



