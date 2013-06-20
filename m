From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 2/6] mfd: omap-usb-host: Put pins in IDLE state on
 suspend
Date: Thu, 20 Jun 2013 15:30:18 +0300
Message-ID: <51C2F5DA.1010904@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com> <1371650753-11452-3-git-send-email-rogerq@ti.com> <878v26815g.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878v26815g.fsf@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: stern@rowland.harvard.edu, tony@atomide.com, balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 06/19/2013 08:23 PM, Kevin Hilman wrote:
> Hi Roger,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
>> In order to support wake up from suspend use the pinctrl
>> framework to put the USB host pins in IDLE state during suspend.
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> You should use helpers for this now in the pinctrl core:
> 
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html
>

Right. thanks.

cheers,
-roger
