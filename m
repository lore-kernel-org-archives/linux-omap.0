From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
Date: Fri, 21 Sep 2018 09:33:24 +0800
Message-ID: <83d29681-b008-9b1f-5961-e23f0174d5f4@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920.085055.1188796939437872993.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920.085055.1188796939437872993.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dmitry.tarnyagin@lockless.no, wg@grandegger.com, mkl@pengutronix.de, michal.simek@xilinx.com, hsweeten@visionengravers.com, madalin.bucur@nxp.com, pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com, leoyang.li@nxp.com, linux@armlinux.org.uk, sammy@sammy.net, ralf@linux-mips.org, nico@fluxnic.net, steve.glendinning@shawell.net, f.fainelli@gmail.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, t.sailer@alumni.ethz.ch, jreuter@yaina.de, kys@microsoft.com, haiyangz@microsoft.com, wei.liu2@citrix.com, paul.durrant@citrix.com, arvid.brodin@alten.se, pshelar@ovn.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-
List-Id: linux-omap@vger.kernel.org

On 2018/9/20 23:50, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Thu, 20 Sep 2018 20:32:44 +0800
> 
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, so make sure the implementation in
>> this driver has returns 'netdev_tx_t' value, and change the function
>> return type to netdev_tx_t.
> 
> I would advise you not to send so many of these changes as a group.
> 
> If one of the patches needs feedback addressed, which is already the
> case, you will have to resubmit the entire series all over again with
> the fixes.
> 

Yes, I will send it separately after test and review again.

Thank you for your advice.

> .
> 
