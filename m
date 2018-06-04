From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH v2 02/21] mfd: omap-usb-host: use match_string() helper
Date: Mon, 4 Jun 2018 16:13:58 +0800
Message-ID: <f9950977-2777-2836-b8f6-e967f7b1d851@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-3-git-send-email-xieyisheng1@huawei.com>
 <20180604074453.GK25455@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604074453.GK25455@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Lee,

On 2018/6/4 15:44, Lee Jones wrote:
> On Thu, 31 May 2018, Yisheng Xie wrote:
> 
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: linux-omap@vger.kernel.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>> v2:
>>  - add Acked-by and Reviewed-by tag.
>>
>>  drivers/mfd/omap-usb-host.c | 24 ++----------------------
>>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> I already applied this with the tags

Thanks
Yisheng
> 
