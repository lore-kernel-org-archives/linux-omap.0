From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH 9/9] leds: lm3632: Introduce the TI LM3632 driver
Date: Mon, 8 Oct 2018 07:23:13 -0500
Message-ID: <b323e344-f8e5-1a29-9ea3-56499d41ba89@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-10-dmurphy@ti.com> <20181007134630.GA19323@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181007134630.GA19323@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 10/07/2018 08:46 AM, Pavel Machek wrote:
> On Wed 2018-09-26 08:09:21, Dan Murphy wrote:
>> Add the dedicated TI LM3632 LED driver.  This
>> LED device is capable of driving a backlight display.
>>
>> In addition to the backlight the device has control
>> of a strobe and torch output.
> 
> Is this in some way similar to 3639? That also seems to include flash
> and torch.
> 
> drivers/video/backlight/lm3639_bl.c
> 	

NICE!  

Yes this driver looks to be good enough to use for the 3632 as well.

We would have to extend that driver to support the 3632, add firmware support,
convert the led class registration to the flash LED registration and add the regulator support.

I can abandon the dedicated LED driver and update this one for the 3632.
No reason to have duplicate code.

Dan

							Pavel
> 


-- 
------------------
Dan Murphy
