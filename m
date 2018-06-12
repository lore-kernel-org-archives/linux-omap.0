From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc
 offload
Date: Tue, 12 Jun 2018 23:35:34 +0300
Message-ID: <20180612203533.GB9473@khorivan>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
 <20180612163658.GC12251@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612163658.GC12251@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, vinicius.gomes@intel.com, henrik@austad.us, jesus.sanchez-palencia@intel.com, ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 12, 2018 at 06:36:58PM +0200, Andrew Lunn wrote:
>On Mon, Jun 11, 2018 at 04:30:44PM +0300, Ivan Khoronzhuk wrote:
>> That's possible to offload vlan to tc priority mapping with
>> assumption sk_prio == L2 prio.
>>
>> Example:
>> $ ethtool -L eth0 rx 1 tx 4
>>
>> $ qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
>> map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 1
>>
>> $ tc -g class show dev eth0
>> +---(100:ffe2) mqprio
>> |    +---(100:3) mqprio
>> |    +---(100:4) mqprio
>> |    
>> +---(100:ffe1) mqprio
>> |    +---(100:2) mqprio
>> |    
>> +---(100:ffe0) mqprio
>>      +---(100:1) mqprio
>>
>> Here, 100:1 is txq0, 100:2 is txq1, 100:3 is txq2, 100:4 is txq3
>> txq0 belongs to tc0, txq1 to tc1, txq2 and txq3 to tc2
>> The offload part only maps L2 prio to classes of traffic, but not
>> to transmit queues, so to direct traffic to traffic class vlan has
>> to be created with appropriate egress map.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 406537d74ec1..fd967d2bce5d 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -39,6 +39,7 @@
[...]

>>
>> +static int cpsw_set_tc(struct net_device *ndev, void *type_data)
>> +{
>
>Hi Ivan
>
>Maybe this is not the best of names. What if you add support for
>another TC qdisc? So you have another case in the switch statement
>below?
>
>Maybe call it cpsw_set_mqprio?

Yes, proposed name is more suitable.

-- 
Regards,
Ivan Khoronzhuk
