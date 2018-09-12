From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Wed, 12 Sep 2018 20:35:44 +0200
Message-ID: <7bb0462c-e641-0c58-1f68-bd02d38edab2@gmail.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911200530.GA28290@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/11/2018 10:05 PM, Pavel Machek wrote:
> On Tue 2018-09-11 12:08:20, Dan Murphy wrote:
>> Remove support for the LM3697 LED device
>> from the ti-lmu.  The LM3697 will be supported
>> via a stand alone LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> I'd really like to see better explanation here.
> 
> We have existing binding, for lm3697 and similar devices. With this
> series, different binding is introduced, without documented reason.
> 
> That's bad.
> 
> Now, maybe you are right and the hardware should be handled by
> drivers/leds, not drivers/mfd. But we should have solution for all the
> similar chips, and that still does not mean we have to modify the
> binding. (But maybe we want to move it to different
> directory). Bindings are supposed to describe hardware, not mirror
> structure of our drivers.
> 
> Unless there's something fatally wrong with the binding... but in such
> case we'd like to know what is wrong.

Dangling references ?

> [And yes, I recognize current situation is ... not ideal and I'm
> willing to help. But I'm not sure this is step in right direction.]
> 
> Thanks,


-- 
Best regards,
Jacek Anaszewski
