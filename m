From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 0/5] Input: pixcir_i2c_ts: Add Type-B Multi-touch and
 DT support
Date: Tue, 17 Jun 2014 12:52:14 +0300
Message-ID: <53A00FCE.7050101@ti.com>
References: <1402997507-9736-1-git-send-email-rogerq@ti.com> <20140617095132.GR17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20140617095132.GR17845@atomide.com>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, nsekhar@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/17/2014 12:51 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [140617 02:33]:
>> Hi Dmitry,
>>
>> These are the pending patches that didn't go through in the 3.16 merge window.
>> Please queue them for -next. Thanks.
>>
>> The series does the following
>> - convert to Type-B multi touch protocol
>> - support upto 5 fingers with hardware supplied tracking IDs
>> - device tree support
>>
>> Tony,
>>
>> The last 2 patches fix the touch screen size property in the device tree since
>> we now use the unified touch screen properties.
> 
> OK I acked those two pathes so Dmitry can take them too
> when the driver changes get merged.
> 

Thanks Tony.

cheers,
-roger

