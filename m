From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 1/9] regulator: tps65217: Enable suspend configuration
Date: Wed, 22 Jun 2016 15:56:33 +0530
Message-ID: <576A67D9.6080707@ti.com>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
 <20160621190848.GF28202@sirena.org.uk> <576A64EA.4000607@ti.com>
 <20160622101611.GI28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160622101611.GI28202@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org



On Wednesday 22 June 2016 03:46 PM, Mark Brown wrote:
> On Wed, Jun 22, 2016 at 03:44:02PM +0530, Keerthy wrote:
>
>> Hence saving it in a static array and using it later in the ops functions to
>> disable or enable regulator during suspend.
>
> Why a static array and not part of the dynamically allocated driver
> data?

Okay. That can be done.
I can introduce another integer pointer to struct tps65217 which 
currently holds the driver data.

I will allocate memory for TPS65217_NUM_REGULATOR strobes during 
regulator probe. Is this approach okay?

>
