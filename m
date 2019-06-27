From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH v4 net-next 1/4] net: core: page_pool: add user cnt
 preventing pool deletion
Date: Fri, 28 Jun 2019 01:02:47 +0300
Message-ID: <20190627220245.GA3269@khorivan>
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
 <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
 <20190627214317.237e5926@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190627214317.237e5926@carbon>
Sender: netdev-owner@vger.kernel.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: davem@davemloft.net, grygorii.strashko@ti.com, saeedm@mellanox.com, leon@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Jesper, thanks you remember about it.

>
>I don't think that "create" and "free" routines paring looks "more
>correct" together.
>
>Maybe we can scale back your solution(?), via creating a page_pool_get()
>and page_pool_put() API that can be used by your driver, to keep the
>page_pool object after a xdp_rxq_info_unreg() call.  Then you can use
>it for two xdp_rxq_info structs, and call page_pool_put() after you
>have unregistered both.
>
>The API would basically be:
>
>diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>index b366f59885c1..691ddacfb5a6 100644
>--- a/net/core/page_pool.c
>+++ b/net/core/page_pool.c
>@@ -357,6 +357,10 @@ static void __warn_in_flight(struct page_pool *pool)
> void __page_pool_free(struct page_pool *pool)
> {
>        WARN(pool->alloc.count, "API usage violation");
>+
>+       if (atomic_read(&pool->user_cnt) != 0)
>+               return;
>+
>        WARN(!ptr_ring_empty(&pool->ring), "ptr_ring is not empty");
>
>        /* Can happen due to forced shutdown */
>@@ -372,6 +376,19 @@ void __page_pool_free(struct page_pool *pool)
> }
> EXPORT_SYMBOL(__page_pool_free);
>
>+void page_pool_put(struct page_pool *pool)
>+{
>+       if (!atomic_dec_and_test(&pool->user_cnt))
>+               __page_pool_free(pool);
>+}
>+EXPORT_SYMBOL(page_pool_put);
>+
>+void page_pool_get(struct page_pool *pool)
>+{
>+       atomic_inc(&pool->user_cnt);
>+}
>+EXPORT_SYMBOL(page_pool_get);
>+

I have another solution that doesn't touch page pool and adds modifications
to xdp allocator. As for me it looks better and work wider, I don't need to
think about this in the driver also.

It's supposed allocator works as before, no any changes to mlx5 and
page_pool API and its usage and seems like fits your requirements.
It still supposes that allocator runs under same napi softirq but allows
to reuse allocator.

I have not verified yet, but looks like:

diff --git a/include/net/xdp_priv.h b/include/net/xdp_priv.h
index 6a8cba6ea79a..995b21da2f27 100644
--- a/include/net/xdp_priv.h
+++ b/include/net/xdp_priv.h
@@ -18,6 +18,7 @@ struct xdp_mem_allocator {
 	struct rcu_head rcu;
 	struct delayed_work defer_wq;
 	unsigned long defer_warn;
+	unsigned long refcnt;
 };
 
 #endif /* __LINUX_NET_XDP_PRIV_H__ */
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f98ab6b98674..6239483e3793 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -98,6 +98,12 @@ static bool __mem_id_disconnect(int id, bool force)
 		WARN(1, "Request remove non-existing id(%d), driver bug?", id);
 		return true;
 	}
+
+	if (--xa->refcnt) {
+		mutex_unlock(&mem_id_lock);
+		return true;
+	}
+
 	xa->disconnect_cnt++;
 
 	/* Detects in-flight packet-pages for page_pool */
@@ -312,6 +318,33 @@ static bool __is_supported_mem_type(enum xdp_mem_type type)
 	return true;
 }
 
+static struct xdp_mem_allocator *xdp_allocator_get(void *allocator)
+{
+	struct xdp_mem_allocator *xae, *xa == NULL;
+	struct rhashtable_iter iter;
+
+	mutex_lock(&mem_id_lock);
+	rhashtable_walk_enter(mem_id_ht, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		while ((xae = rhashtable_walk_next(&iter)) && !IS_ERR(xae)) {
+			if (xae->allocator == allocator) {
+				xae->refcnt++;
+				xa = xae;
+				break;
+			}
+		}
+
+		rhashtable_walk_stop(&iter);
+
+	} while (xae == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
+	mutex_unlock(&mem_id_lock);
+
+	return xa;
+}
+
 int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 			       enum xdp_mem_type type, void *allocator)
 {
@@ -347,6 +380,9 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		}
 	}
 
+	if (xdp_allocator_get(allocator))
+		return 0;
+
 	xdp_alloc = kzalloc(sizeof(*xdp_alloc), gfp);
 	if (!xdp_alloc)
 		return -ENOMEM;
@@ -360,6 +396,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 	xdp_rxq->mem.id = id;
 	xdp_alloc->mem  = xdp_rxq->mem;
 	xdp_alloc->allocator = allocator;
+	xdp_alloc->refcnt = 1;
 
 	/* Insert allocator into ID lookup table */
 	ptr = rhashtable_insert_slow(mem_id_ht, &id, &xdp_alloc->node);


-- 
Regards,
Ivan Khoronzhuk
