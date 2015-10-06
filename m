From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] pwm: tipwmss: enable on TI DRA7x and AM437x
Date: Tue, 6 Oct 2015 11:32:23 +0530
Message-ID: <561363EF.7040207@ti.com>
References: <637af4e1754204dd81677a1290517202eec7f011.1441725097.git.nsekhar@ti.com>
 <20151005152038.GB17612@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20151005152038.GB17612@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 05 October 2015 08:50 PM, Thierry Reding wrote:
> On Tue, Sep 08, 2015 at 08:44:05PM +0530, Sekhar Nori wrote:
>> From: Vignesh R <vigneshr@ti.com>
>>
>> TIPWMSS is present on TI's DRA7x and
>> AM437x SoCs. Enable its usage.
>>
>> Instead of adding each SoC individually,
>> use the more generic ARCH_OMAP2PLUS
>> instead.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  drivers/pwm/Kconfig | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Applied, thanks. In the future, try to make use of the 78 columns. There
> is no need to make lines as short as you did.

Alright.

Thanks,
Sekhar
