From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH] pwm: pwm-tipwmss: Remove all pm_runtime gets and puts
 from the driver
Date: Mon, 5 Sep 2016 19:13:59 +0530
Message-ID: <780acbff-615f-d6c4-eb6b-1d78fba74e28@ti.com>
References: <20160808100915.30149-1-vigneshr@ti.com>
 <20160905065109.GE3532@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20160905065109.GE3532@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Sarha, Jyri" <jsarha@ti.com>, "Gerlach, Dave" <d-gerlach@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 9/5/2016 12:21 PM, Thierry Reding wrote:
> On Mon, Aug 08, 2016 at 03:39:15PM +0530, Vignesh R wrote:
>> From: Jyri Sarha <jsarha@ti.com>
>>
>> Remove all pm_runtime gets and puts, and dummy pm_ops, from the
>> pwm-tipwmss driver as there is no direct hardware access. The runtime PM
>> needs to be enabled, so that the runtime PM framework takes care of
>> enabling/disabling of PWMSS clock when submodules of PWMSS (ECAP or
>> EHRPWM) call pm_runtime APIs. With this change PWMSS clock goes to
>> idle when none of the submodules are in use.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/pwm/pwm-tipwmss.c | 19 -------------------
>>  1 file changed, 19 deletions(-)
> 
> Applied, with a slightly modified commit message.
> 

Thanks!
