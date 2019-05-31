From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v2 net-next 7/7] net: ethernet: ti: cpsw: add XDP
 support
Date: Sat, 1 Jun 2019 00:37:36 +0200
Message-ID: <20190601003736.65cb6a61@carbon>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
        <20190530182039.4945-8-ivan.khoronzhuk@linaro.org>
        <20190531174643.4be8b27f@carbon>
        <20190531162523.GA3694@khorivan>
        <20190531183241.255293bc@carbon>
        <20190531170332.GB3694@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190531170332.GB3694@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com, brouer@redhat.com
List-Id: linux-omap@vger.kernel.org

On Fri, 31 May 2019 20:03:33 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> Probably it's not good example for others how it should be used, not
> a big problem to move it to separate pools.., even don't remember why
> I decided to use shared pool, there was some more reasons... need
> search in history.

Using a shared pool is makes it a lot harder to solve the issue I'm
currently working on.  That is handling/waiting for in-flight frames to
complete, before removing the mem ID from the (r)hashtable lookup.  I
have working code, that basically remove page_pool_destroy() from
public API, and instead lets xdp_rxq_info_unreg() call it when
in-flight count reach zero (and delay fully removing the mem ID).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
