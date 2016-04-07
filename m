From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 01/20] mfd: Add devm_ apis for mfd_add_devices and mfd_release_devices
Date: Thu, 7 Apr 2016 17:12:54 +0530
Message-ID: <570647BE.2020203@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com> <1459856912-17859-2-git-send-email-ldewangan@nvidia.com> <20160407104403.GZ3323@x1> <57063A12.4080200@nvidia.com> <20160407114250.GA3323@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160407114250.GA3323@x1>
Sender: linux-doc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org


On Thursday 07 April 2016 05:12 PM, Lee Jones wrote:
> On Thu, 07 Apr 2016, Laxman Dewangan wrote:
>
> + * Normally this function will not need to be called and the resource
> + * management code will ensure that the resource is freed.
>>> Then what is the purpose of providing it?  Do you have a user?
>> To have pair of release. I have not seen the usage of most of
>> devm_*_release() function other than devm_kfree().
> Unless you have a need or a user, I would omit this for now.
>
OK, I will remove it.

BTW, I have collected all acks and reviewed by which I got from this series.
So I can send this series with all acks/reviewed by.

If you want me to provide the git location for these patchs then I can 
do it also. For this I will need base from where I need to take branch.


