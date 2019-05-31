From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH v2 net-next 7/7] net: ethernet: ti: cpsw: add XDP support
Date: Fri, 31 May 2019 20:03:33 +0300
Message-ID: <20190531170332.GB3694@khorivan>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
 <20190530182039.4945-8-ivan.khoronzhuk@linaro.org>
 <20190531174643.4be8b27f@carbon>
 <20190531162523.GA3694@khorivan>
 <20190531183241.255293bc@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190531183241.255293bc@carbon>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri, May 31, 2019 at 06:32:41PM +0200, Jesper Dangaard Brouer wrote:
>
>On Fri, 31 May 2019 19:25:24 +0300 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> On Fri, May 31, 2019 at 05:46:43PM +0200, Jesper Dangaard Brouer wrote:
>> >
>> >From below code snippets, it looks like you only allocated 1 page_pool
>> >and sharing it with several RX-queues, as I don't have the full context
>> >and don't know this driver, I might be wrong?
>> >
>> >To be clear, a page_pool object is needed per RX-queue, as it is
>> >accessing a small RX page cache (which protected by NAPI/softirq).
>>
>> There is one RX interrupt and one RX NAPI for all rx channels.
>
>So, what are you saying?
>
>You _are_ sharing the page_pool between several RX-channels, but it is
>safe because this hardware only have one RX interrupt + NAPI instance??

I can miss smth but in case of cpsw technically it means:
1) RX interrupts are disabled while NAPI is scheduled,
   not for particular CPU or channel, but at all, for whole cpsw module.
2) RX channels are handled one by one by priority.
3) After all of them handled and no more in budget - interrupts are enabled.
4) If page is returned to the pool, and it's within NAPI, no races as it's
   returned protected by softirq. If it's returned not in softirq it's protected 
   by producer lock of the ring.

Probably it's not good example for others how it should be used, not a big
problem to move it to separate pools.., even don't remember why I decided to
use shared pool, there was some more reasons... need search in history.

>
>-- 
>Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer

-- 
Regards,
Ivan Khoronzhuk
