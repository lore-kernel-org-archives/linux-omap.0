From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] net: core: page_pool: add user refcnt and reintroduce
 page_pool_destroy
Date: Wed, 3 Jul 2019 00:41:43 +0300
Message-ID: <20190702214142.GJ4510@khorivan>
References: <156207778364.29180.5111562317930943530.stgit@firesoul>
 <20190702144426.GD4510@khorivan>
 <20190702165230.6caa36e3@carbon>
 <20190702145612.GF4510@khorivan>
 <20190702171029.76c60538@carbon>
 <20190702152112.GG4510@khorivan>
 <20190702202907.15fb30ce@carbon>
 <20190702185839.GH4510@khorivan>
 <20190702230241.3be6d787@carbon>
 <20190702211536.GA22618@apalos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702211536.GA22618@apalos>
Sender: netdev-owner@vger.kernel.org
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org, grygorii.strashko@ti.com, jakub.kicinski@netronome.com, daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 03, 2019 at 12:15:36AM +0300, Ilias Apalodimas wrote:
>Hi Jesper,
>Getting late here, i'll respond in detail tomorrow. One point though
>
>[...]
>>
>> This special use-case, seems confined to your driver. And Ilias told me
>> that XDP is not really a performance benefit for this driver as the HW
>> PPS-limit is hit before the XDP and netstack limit.  I ask, does it
>> make sense to add XDP to this driver, if it complicates the code for
>> everybody else?
>I think yes. This is a widely used driver on TI embedded devices so having XDP
>to play along is a nice feature. It's also the first and only armv7 we have
>supporting this. Ivan already found a couple of issues due to the 32-bit
>architecture he is trying to fix, i think there's real benefit in having that,
>performance aside.
>I fully agree we should not impact the performance of the API to support a
>special hardware though. I'll have a look on the 2 solutions tomorrow, but the
>general approach on this one should be 'the simpler the better'
>
>Cheers
>/Ilias

BTW even w/o optimization it has close to 300kpps (but with increased number of
descs) on drop which is very close to netsec measurements Ilias sent. But from
what I know there is no h/w limit on cpsw at all that this CPU can serve, so
my assumption it's rather s/w limit. But that's not main here and XDP usage
has not been estimated enough yet in embedded, where hi speed not only benefit
that can be taken from XDP.

I need more clear circumstances to send v6 ...

-- 
Regards,
Ivan Khoronzhuk
