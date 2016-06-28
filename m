From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 5/5] regulator: tps65218: do not disable DCDC3 during
 poweroff on broken PMICs
Date: Tue, 28 Jun 2016 14:58:18 +0530
Message-ID: <57724332.1090704@ti.com>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
 <1466756892-17015-5-git-send-email-j-keerthy@ti.com>
 <20160627165930.GC17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160627165930.GC17217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org



On Monday 27 June 2016 10:29 PM, Mark Brown wrote:
> On Fri, Jun 24, 2016 at 01:58:11PM +0530, Keerthy wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Some versions of tps65218 do not seem to support poweroff modes properly
>> if DCDC3 regulator is shut-down. Thus, keep it enabled even during
>> poweroff if the version info matches the broken silicon revision.
>
> This is fine but depends on the MFD bit so needs to wait for that to be
> reviewed.

Yes. I will wait for Lee Jones to review Patch 4/5 of this series.

Thanks,
Keerthy

>
