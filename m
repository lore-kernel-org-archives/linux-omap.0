From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v4 net-next 1/4] net: core: page_pool: add user cnt
 preventing pool deletion
Date: Thu, 27 Jun 2019 21:44:46 +0200
Message-ID: <20190627214317.237e5926@carbon>
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
        <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: davem@davemloft.net, grygorii.strashko@ti.com, saeedm@mellanox.com, leon@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com, brouer@redhat.com
List-Id: linux-omap@vger.kernel.org

On Tue, 25 Jun 2019 20:59:45 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> Add user counter allowing to delete pool only when no users.
> It doesn't prevent pool from flush, only prevents freeing the
> pool instance. Helps when no need to delete the pool and now
> it's user responsibility to free it by calling page_pool_free()
> while destroying procedure. It also makes to use page_pool_free()
> explicitly, not fully hidden in xdp unreg, which looks more
> correct after page pool "create" routine.

I don't think that "create" and "free" routines paring looks "more
correct" together.

Maybe we can scale back your solution(?), via creating a page_pool_get()
and page_pool_put() API that can be used by your driver, to keep the
page_pool object after a xdp_rxq_info_unreg() call.  Then you can use
it for two xdp_rxq_info structs, and call page_pool_put() after you
have unregistered both.

The API would basically be:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b366f59885c1..691ddacfb5a6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -357,6 +357,10 @@ static void __warn_in_flight(struct page_pool *pool)
 void __page_pool_free(struct page_pool *pool)
 {
        WARN(pool->alloc.count, "API usage violation");
+
+       if (atomic_read(&pool->user_cnt) != 0)
+               return;
+
        WARN(!ptr_ring_empty(&pool->ring), "ptr_ring is not empty");
 
        /* Can happen due to forced shutdown */
@@ -372,6 +376,19 @@ void __page_pool_free(struct page_pool *pool)
 }
 EXPORT_SYMBOL(__page_pool_free);
 
+void page_pool_put(struct page_pool *pool)
+{
+       if (!atomic_dec_and_test(&pool->user_cnt))
+               __page_pool_free(pool);
+}
+EXPORT_SYMBOL(page_pool_put);
+
+void page_pool_get(struct page_pool *pool)
+{
+       atomic_inc(&pool->user_cnt);
+}
+EXPORT_SYMBOL(page_pool_get);
+


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
