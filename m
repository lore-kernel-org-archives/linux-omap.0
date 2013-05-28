From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] usb: omap2430: fix memleak in err case
Date: Tue, 28 May 2013 21:40:26 +0400
Message-ID: <51A4EC0A.2060506@cogentembedded.com>
References: <5192E650.3070303@huawei.com> <519C3BD1.6050307@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519C3BD1.6050307@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Libo Chen <clbchenlibo.chen@huawei.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, rob.herring@calxeda.com, Li Zefan <lizefan@huawei.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 22-05-2013 7:30, Libo Chen wrote:

> when omap_get_control_dev faild, we should release related platform_device

> * Changelog from v1:
> 	* fix spell: s/fail/fails/, s/relational/related/ , thank Sergei <sergei.shtylyov@cogentembedded.com>

    It seems you've actually replaced "fail" with "faild", not "fails".

> Signed-off-by: Libo Chen <libo.chen@huawei.com>
> ---
>   drivers/usb/musb/omap2430.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)

WBR, Sergei
