From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list
 of vlans for real device
Date: Fri, 19 Oct 2018 17:02:36 +0300
Message-ID: <20181019140235.GB3909@khorivan>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
 <878t2up4er.fsf@miraculix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878t2up4er.fsf@miraculix.mork.no>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 19, 2018 at 01:22:20PM +0200, Bjørn Mork wrote:
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> writes:
>
>> @@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
>>  	return NULL;
>>  }
>>
>> +static inline int
>> +vlan_for_each(struct net_device *dev,
>> +	      int (*action)(struct net_device *dev, int vid, void *arg),
>> +	      void *arg)
>> +{
>> +}
>> +
>
>
>This stub should return 0, shouldn't it?
yes, it has.

>
>
>Bjørn

-- 
Regards,
Ivan Khoronzhuk
