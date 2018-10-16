From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list
 of vlans for real device
Date: Tue, 16 Oct 2018 13:15:38 -0700 (PDT)
Message-ID: <20181016.131538.1460013299973717680.davem@davemloft.net>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
        <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
        <2242102f-bfc8-e334-e9ae-93edd26587eb@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2242102f-bfc8-e334-e9ae-93edd26587eb@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: ivan.khoronzhuk@linaro.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 16 Oct 2018 14:39:43 -0500

> 
> 
> On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
>> It's redundancy for the drivers to hold the list of vlans when
>> absolutely the same list exists in vlan core. In most cases it's
>> needed only to traverse the vlan devices, their vids and sync some
>> settings with h/w, so add API to simplify this.
>> 
> 
> below has to be under ---.

I think it is good to docuement this in the commit message.

More information in the repository can never hurt.
