From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Date: Thu, 7 Mar 2019 21:53:50 +0100
Message-ID: <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
 <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
 <20190307201807.GA950@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190307201807.GA950@kunai>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Adam Ford <aford173@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Hoan Tran <hotran@apm.com>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Thierry Reding <thierry.reding@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-tegra@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 07.03.19 21:18, Wolfram Sang wrote:
> 
>> It's been almost a year later, and several Linux revisions, and this
>> still seems stuck somewhere/somehow.
> 
> I wanted to respin this series once rc1 is released.
> 
Maybe just rebase and repost ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
