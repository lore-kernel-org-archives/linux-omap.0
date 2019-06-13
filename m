From: keerthy <j-keerthy@ti.com>
Subject: Re: [RESEND PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561
 regulator support
Date: Thu, 13 Jun 2019 23:39:55 +0530
Message-ID: <7b500f5d-9ea0-0135-7174-b7a34db23d28@ti.com>
References: <20190612144620.28331-1-j-keerthy@ti.com>
 <20190613154552.GL5316@sirena.org.uk>
 <bfb19336-fbe9-06d8-25d3-f2e0b8ea6c9b@ti.com>
 <20190613173248.GP5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613173248.GP5316@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 6/13/2019 11:02 PM, Mark Brown wrote:
> On Thu, Jun 13, 2019 at 10:32:45PM +0530, keerthy wrote:
>> On 6/13/2019 9:15 PM, Mark Brown wrote:
>>> On Wed, Jun 12, 2019 at 08:16:20PM +0530, Keerthy wrote:
> 
>>>> patches 1/3 2/3 are already applied to linux-next.
> 
>>> This doesn't build without those patches:
> 
>> They are already on next. Do you want me to resend them as well?
> 
> That's no good, it still breaks the build of my tree.  I can't apply
> this until the code is in my tree, either through a shared branch or
> through Lihus' tree.  I see I acked the patch, I'll have been expecting
> the patch to be applied to Lee's tree.  If that's not possible or
> there's no branch then please resend after the merge window.

Lee Jones,

Could you please pull this patch?

- Keerthy
> 
