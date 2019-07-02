From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] net: core: page_pool: add user refcnt and reintroduce
 page_pool_destroy
Date: Tue, 2 Jul 2019 17:56:13 +0300
Message-ID: <20190702145612.GF4510@khorivan>
References: <20190702153902.0e42b0b2@carbon>
 <156207778364.29180.5111562317930943530.stgit@firesoul>
 <20190702144426.GD4510@khorivan>
 <20190702165230.6caa36e3@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702165230.6caa36e3@carbon>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, grygorii.strashko@ti.com, jakub.kicinski@netronome.com, daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 02, 2019 at 04:52:30PM +0200, Jesper Dangaard Brouer wrote:
>On Tue, 2 Jul 2019 17:44:27 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> On Tue, Jul 02, 2019 at 04:31:39PM +0200, Jesper Dangaard Brouer wrote:
>> >From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >
>> >Jesper recently removed page_pool_destroy() (from driver invocation) and
>> >moved shutdown and free of page_pool into xdp_rxq_info_unreg(), in-order to
>> >handle in-flight packets/pages. This created an asymmetry in drivers
>> >create/destroy pairs.
>> >
>> >This patch add page_pool user refcnt and reintroduce page_pool_destroy.
>> >This serves two purposes, (1) simplify drivers error handling as driver now
>> >drivers always calls page_pool_destroy() and don't need to track if
>> >xdp_rxq_info_reg_mem_model() was unsuccessful. (2) allow special cases
>> >where a single RX-queue (with a single page_pool) provides packets for two
>> >net_device'es, and thus needs to register the same page_pool twice with two
>> >xdp_rxq_info structures.
>>
>> As I tend to use xdp level patch there is no more reason to mention (2) case
>> here. XDP patch serves it better and can prevent not only obj deletion but also
>> pool flush, so, this one patch I could better leave only for (1) case.
>
>I don't understand what you are saying.
>
>Do you approve this patch, or do you reject this patch?
>
It's not reject, it's proposition to use both, XDP and page pool patches,
each having its goal.

-- 
Regards,
Ivan Khoronzhuk
