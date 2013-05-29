From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: Re: [PATCH v2] usb: omap2430: fix memleak in err case
Date: Wed, 29 May 2013 10:47:36 +0800
Message-ID: <51A56C48.5000501@huawei.com>
References: <5192E650.3070303@huawei.com> <519C3BD1.6050307@huawei.com> <51A4EC0A.2060506@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A4EC0A.2060506@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, rob.herring@calxeda.com, Li Zefan <lizefan@huawei.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2013/5/29 1:40, Sergei Shtylyov wrote:
> Hello.
> 
> On 22-05-2013 7:30, Libo Chen wrote:
> 
>> when omap_get_control_dev faild, we should release related platform_device
> 
>> * Changelog from v1:
>>     * fix spell: s/fail/fails/, s/relational/related/ , thank Sergei <sergei.shtylyov@cogentembedded.com>
> 
>    It seems you've actually replaced "fail" with "faild", not "fails".

sorry for my weak spell.


thanks again,

Libo


> 
>> Signed-off-by: Libo Chen <libo.chen@huawei.com>
>> ---
>>   drivers/usb/musb/omap2430.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
> 
> WBR, Sergei
> 
> 
> 
