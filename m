From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: switch to
 readl/writel_relaxed()
Date: Fri, 29 Mar 2019 11:11:23 +0200
Message-ID: <5e37fb17-ccf8-540e-0cdc-bc3b71ccf259@ti.com>
References: <1553792993-7722-1-git-send-email-grygorii.strashko@ti.com>
 <CAK8P3a2MP-YNkHLG9LgrQ_zeRWiJkwwNXJmptunF8+_uZTcYFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2MP-YNkHLG9LgrQ_zeRWiJkwwNXJmptunF8+_uZTcYFg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On 29.03.19 03:00, Arnd Bergmann wrote:
> On Fri, Mar 29, 2019 at 1:10 AM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>> Switch to readl/writel_relaxed() APIs, because this is recommended
>> API and the MDIO block is reused on Keystone 2 SoCs
>> where LE/BE modes are supported.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> In general, my recommendation would be to use readl/writel instead of
> readl_relaxed/writel_relaxed everywhere, because they have much
> more predictible behavior. If you want to use the _relaxed version
> in the fast-path for data traffic, that is usually fine, but then I would
> add a comment next to it to explain why it is safe there without extra
> barriers to serialize with spinlocks and DMA.
> 

it's not fast path, so readl/writel should be ok. I'll resend.

-- 
Best regards,
grygorii
