From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
Date: Wed, 3 Oct 2018 07:24:23 -0500
Message-ID: <fef2c612-ac35-126e-669e-335fb3075f64@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com> <20181002072827.GA19677@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002072827.GA19677@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello

On 10/02/2018 02:28 AM, Pavel Machek wrote:
> On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
>> Remove support for the LM3697 LED device
>> from the ti-lmu.  The LM3697 will be supported
>> via a stand alone LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> NAK, for reasons I explained before. Please add it to the patch so
> that it does not get applied by mistake. Ouch and AFAICT Rob was not
> happy with this either.
> 
> Yes, you are creating new drivers, ok; but that does _not_ mean you
> should create new binding.

I am copying my comment here on the review of this original binding for
records

I found the review or at least the reference for the ti-lmu.txt binding.

https://lore.kernel.org/patchwork/patch/764180/

Does not appear that the binding was sent to the device tree mail list.
(Maybe that email list did not exist in Feb 2017).

Especially with the amount of change that is being submitted in the
newer patchsets.

<new content>
Having found this submission and no comments on the review I would think
we need to take an exception on these bindings.

Dan


> 									Pavel
> 


-- 
------------------
Dan Murphy
