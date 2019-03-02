From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] fbdev: omap2: omapfb: trivial code cleanup
Date: Sat, 2 Mar 2019 09:20:48 +0800
Message-ID: <bdb40e58-ae8c-497f-cb35-baecdfbdd2a9@huawei.com>
References: <CGME20190301015537epcas4p242dee277b9b0b4953775bb948985775c@epcas4p2.samsung.com>
 <20190301015342.28888-1-yuehaibing@huawei.com>
 <f14aa8d6-7cd7-4295-11d9-ee0aefdaa7c0@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f14aa8d6-7cd7-4295-11d9-ee0aefdaa7c0@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: trivial@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2019/3/1 22:50, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On 03/01/2019 02:53 AM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> After commit 60d2fa0dad06 ("fbdev: omap2: no need to check
>> return value of debugfs_create functions"), there are corner
>> code need to be cleaned.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thanks but I've already applied earlier patch from Anders Roxell:
> 
> https://marc.info/?l=linux-fbdev&m=155004766902831&w=2

Good to know this, Thanks!

> 
>> ---
>>  drivers/video/fbdev/omap2/omapfb/dss/core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
>> index 7e6a3eb..b5956a1 100644
>> --- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
>> +++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
>> @@ -136,7 +136,6 @@ static inline void dss_uninitialize_debugfs(void)
>>  }
>>  void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
>>  {
>> -	return 0;
>>  }
>>  #endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
>>  
>> @@ -169,8 +168,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
>>  
>>  static int __init omap_dss_probe(struct platform_device *pdev)
>>  {
>> -	int r;
>> -
>>  	core.pdev = pdev;
>>  
>>  	dss_features_init(omapdss_get_version());
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
