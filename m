From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
Date: Thu, 21 Aug 2014 17:32:00 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49DF07A2@DFLE09.ent.ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408636935-29515-1-git-send-email-nm@ti.com>
 <1408636935-29515-3-git-send-email-nm@ti.com>
 <00FC9A978A94B7418C33AFAE8A35ED49DF0662@DFLE09.ent.ti.com>
 <53F62A2B.6010208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/21/2014 12:19 PM, Menon, Nishanth wrote:
> On 08/21/2014 11:59 AM, Murphy, Dan wrote:
> [...]
> Ooops.. missed answering one addition statement:
> 
>>> +	of_property_read_u32(np, "ti,palmas-long-press-seconds", &val);
>>
>> Probably should check the return to make sure the value exists and that is is
>> within an expected range.
> It is an optional parameter and may not exist in dt. when it does
> exist, the logic tries to do a best match (this is the for loop in the
> logic just below).
> 

The issue is val might be returned as a negative which will then proceed to
set the config->long_press_time_val to the lowest time value which then overrides
your initial setting of config->long_press_time_val = ARRAY_SIZE(lpk_times) - 1;

Dan

-- 
------------------
Dan Murphy
