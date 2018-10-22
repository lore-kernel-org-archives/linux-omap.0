From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: unsync mcast entries
 while switch promisc mode
Date: Mon, 22 Oct 2018 22:02:51 +0300
Message-ID: <20181022190249.GA4892@khorivan>
References: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
 <6ac434fa-858b-8395-91e7-442cf18b33f0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ac434fa-858b-8395-91e7-442cf18b33f0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 22, 2018 at 01:26:35PM -0500, Grygorii Strashko wrote:
>
>
>On 10/19/18 3:25 PM, Ivan Khoronzhuk wrote:
>>After flushing all mcast entries from the table, the ones contained in
>>mc list of ndev are not restored when promisc mode is toggled off,
>>because they are considered as synched with ALE, thus, in order to
>>restore them after promisc mode - reset syncing info. This fix
>>touches only switch mode devices, including single port boards
>>like Beagle Bone.
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>---
>
>
>So, this is follow up fix for
>176b23 net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update
>because I can't reproduce it otherwise.
>
>Could you update description and re-send pls.?

Done.

-- 
Regards,
Ivan Khoronzhuk
