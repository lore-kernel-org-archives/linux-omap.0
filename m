From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: linux-next: Tree for Dec 3 (switchdev & TI_CPSW_SWITCHDEV)
Date: Wed, 4 Dec 2019 17:35:23 +0200
Message-ID: <f2700b07-df9b-94ce-0323-a4fece236838@ti.com>
References: <20191203155405.31404722@canb.auug.org.au>
 <58aebf62-54f8-9084-147b-801ea65327bb@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58aebf62-54f8-9084-147b-801ea65327bb@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/12/2019 01:43, Randy Dunlap wrote:
> On 12/2/19 8:54 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do not add any material for v5.6 to your linux-next included
>> trees until after v5.5-rc1 has been released.
>>
>> Changes since 20191202:
> 
> I am seeing this (happens to be on i386; I doubt that it matters):
> CONFIG_COMPILE_TEST=y
> 
> 
> WARNING: unmet direct dependencies detected for NET_SWITCHDEV
>    Depends on [n]: NET [=y] && INET [=n]
>    Selected by [y]:
>    - TI_CPSW_SWITCHDEV [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && (ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST [=y])
> 
> because TI_CPSW_SWITCHDEV blindly selects NET_SWITCHDEV even though
> INET is not set/enabled, while NET_SWITCHDEV depends on INET.
> 
> However, the build succeeds, including net/switchdev/*.
> 
> So why does NET_SWITCHDEV depend on INET?
> 
> It looks like TI_CPSW_SWITCHDEV should depend on INET (based on the
> Kconfig rules), but in practice it doesn't seem to matter to the build.
> 

Thanks for reporting this. I'd like to ask for some advice of how to proceed?
a) change it to "depends on NET_SWITCHDEV" (as it's done in other drivers),
but this will require to add NET_SWITCHDEV in defconfig

b) change it to "imply NET_SWITCHDEV", but then NET_SWITCHDEV can be switched off
manually or by random build and cause build failure of cpsw_new.
To fix build below diff can be used, but TI_CPSW_SWITCHDEV will not be functional

---
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 71215db7934b..22e8fc548d48 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -368,8 +368,9 @@ static void cpsw_rx_handler(void *token, int len, int status)
                 page_pool_recycle_direct(pool, page);
                 goto requeue;
         }
-
+#ifdef CONFIG_NET_SWITCHDEV
         skb->offload_fwd_mark = priv->offload_fwd_mark;
+#endif
         skb_reserve(skb, headroom);
         skb_put(skb, len);
         skb->dev = ndev;

Thank you.

-- 
Best regards,
grygorii
