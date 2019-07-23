From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Backlight in motorola Droid 4
Date: Tue, 23 Jul 2019 10:53:16 -0500
Message-ID: <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722205921.GA24787@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 7/22/19 3:59 PM, Pavel Machek wrote:
> Hi!
>
> So now the backlight LED can be controlled. Good. (And thanks!)
>
> But I seem to remember that backlight had range from "is it really on?"
> to "very bright"; now it seems to have range from "bright" to "very
> bright".
>
> Any ideas what goes on there?

In the LM3552 driver we are changing the Full scale brightness registers 
for the

specific control bank.

#define LM3532_REG_CTRL_A_BRT    0x17
#define LM3532_REG_CTRL_B_BRT    0x19
#define LM3532_REG_CTRL_C_BRT    0x1b

In the ti-lmu code the ALS zones were being modified not the control 
bank brightness.

#define LM3532_REG_BRT_A            0x70    /* zone 0 */
#define LM3532_REG_BRT_B            0x76    /* zone 1 */
#define LM3532_REG_BRT_C            0x7C    /* zone 2 */

Not sure how the ALS is attached in the system if it reports to the host 
and the host manages

the back light or if the the ALS is connected directly to the LM3532.

Maybe the ALS zone targets need to be updated to allow a fuller range.  
The LM3532 may be stuck

in a certain zone.

Probably should set up the ALS properties in the device tree.

Dan

> Thanks,
> 									Pavel
>
