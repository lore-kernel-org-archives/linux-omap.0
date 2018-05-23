From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS Qdisc
 offload
Date: Wed, 23 May 2018 10:43:42 -0500
Message-ID: <176f9a29-0a89-ffa1-d7f7-708a2cdfdc7e@ti.com>
References: <20180518211510.13341-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518211510.13341-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, vinicius.gomes@intel.com, henrik@austad.us, jesus.sanchez-palencia@intel.com, Sekhar Nori <nsekhar@ti.com>, Yogesh Siraswar <yogeshs@ti.com>, Schuyler Patton <spatton@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Ivan,

On 05/18/2018 04:15 PM, Ivan Khoronzhuk wrote:
> This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
> It potentially can be used in audio video bridging (AVB) and time
> sensitive networking (TSN).
> 
> Patchset was tested on AM572x EVM and BBB boards. Last patch from this
> series adds detailed description of configuration with examples. For
> consistency reasons, in role of talker and listener, tools from
> patchset "TSN: Add qdisc based config interface for CBS" were used and
> can be seen here: https://www.spinics.net/lists/netdev/msg460869.html
> 
> Based on net-next/master

Thanks a lot, it is great work.

In general I have no comments as of now, but I prefer to wait a bit (few 
weeks) for more comments and possible test reports.

If no comments, pls feel free to repost as final series.


> 
> Ivan Khoronzhuk (6):
>    net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
>    net: ethernet: ti: cpdma: fit rated channels in backward order
>    net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
>    net: ethernet: ti: cpsw: add CBS Qdisc offload
>    net: ethernet: ti: cpsw: restore shaper configuration while down/up
>    Documentation: networking: cpsw: add MQPRIO & CBS offload examples
> 
>   Documentation/networking/cpsw.txt       | 540 ++++++++++++++++++++++++
>   drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
>   drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
>   3 files changed, 913 insertions(+), 22 deletions(-)
>   create mode 100644 Documentation/networking/cpsw.txt
> 

-- 
regards,
-grygorii
