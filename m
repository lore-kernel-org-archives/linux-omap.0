From: gg@slimlogic.co.uk
Subject: Re: [RFC v1] MFD: Change TWL6025 references to TWL6032
Date: Fri, 07 Jun 2013 15:44:00 +0100
Message-ID: <c73c260b90be6e1640a430e8cbba6cac@slimlogic.co.uk>
References: <1370602390-12306-1-git-send-email-oleksandr.kozaruk@ti.com>
 <20130607143649.GS31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130607143649.GS31367@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, lgirdwood@gmail.com, balbi@ti.com, peter.ujfalusi@ti.com, t-kristo@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 2013-06-07 15:36, Mark Brown wrote:
> On Fri, Jun 07, 2013 at 01:53:10PM +0300, Oleksandr Kozaruk wrote:
>> From: Graeme Gregory <gg@slimlogic.co.uk>
>> 
>> The TWL6025 was never released beyond sample form and was replaced by
>> the PhoenixLite range of chips - TWL6032. Change the references to
>> reference the TWL6032 class and name the registers to twl6032 in line 
>> with
>> an actual released chip name to avoid confusion.
>> 
>> Currently there is no users of TWL6025 in the code.
> 
> Given that the chip exists even if not widely distributed it seems as
> well to keep the twl6025 references in there at least in the device ID
> table - it won't do any harm to people using the twl6032 name and might
> help someone who happens to pick up an old board for whatever reason.

I do not think any "old boards" exist, it really was a limited run!

Graeme
