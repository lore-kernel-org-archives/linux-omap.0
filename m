From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS
 Qdisc offload
Date: Wed, 6 Jun 2018 11:53:50 +0300
Message-ID: <20180606085348.GB5346@khorivan>
References: <20180518211510.13341-1-ivan.khoronzhuk@linaro.org>
 <87602y1n4j.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87602y1n4j.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, henrik@austad.us, jesus.sanchez-palencia@intel.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 04, 2018 at 02:23:56PM -0300, Vinicius Costa Gomes wrote:
>Hi Ivan,
>
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> writes:
>
>> This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
>> It potentially can be used in audio video bridging (AVB) and time
>> sensitive networking (TSN).
>>
>> Patchset was tested on AM572x EVM and BBB boards. Last patch from this
>> series adds detailed description of configuration with examples. For
>> consistency reasons, in role of talker and listener, tools from
>> patchset "TSN: Add qdisc based config interface for CBS" were used and
>> can be seen here: https://www.spinics.net/lists/netdev/msg460869.html
>>
>> Based on net-next/master
>>
>
>I didn't test this, but it looks fine from my side.
>
>I agree with Grygorii, that if no comments, this should be re-sent as a
>patch series next.
Thanks, I'll do it on this week.

>
>
>> Ivan Khoronzhuk (6):
>>   net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
>>   net: ethernet: ti: cpdma: fit rated channels in backward order
>>   net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
>>   net: ethernet: ti: cpsw: add CBS Qdisc offload
>>   net: ethernet: ti: cpsw: restore shaper configuration while down/up
>>   Documentation: networking: cpsw: add MQPRIO & CBS offload examples
>>
>>  Documentation/networking/cpsw.txt       | 540 ++++++++++++++++++++++++
>>  drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
>>  drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
>>  3 files changed, 913 insertions(+), 22 deletions(-)
>>  create mode 100644 Documentation/networking/cpsw.txt
>>
>> --
>> 2.17.0
>
>
>Cheers,
>--
>Vinicius

-- 
Regards,
Ivan Khoronzhuk
