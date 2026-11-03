Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740471;
	b=Z8MChjL7qgz/5GWc2u0Qj3sBEU1x4pX/Brzw5aTGog/WjAhjI/pvOhNQMIZ2+jNc6rnQ
	 bOzUlnJSa+lhcMPKA3++F9a4lrr3c5ibuzluOkeKLJF8W3LaNuWgYK2vf3yPYKbLdHBC0
	 +Q0dON09jUvkz2us8nhr/hGELq4o1YbMnaMCk7Qf9vDZFQCmg4eu72HP5ulTdiROWET+z
	 g6qytgAqfmyVGUPmDSZ+sHEjnXHj7ILRNaaBrJONPEfPcw4JLfh9Gb16Q29JJfrg6lrSp
	 OVirVXJL4odNu/BYRvIWRmf1+8ISPbJj4bvysV7C+0QIz7wEDWsXYDjGEh0xAvp5KGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Mqx62j/MS4Vpw2prk2XGbtfQUzR6R3P7OHsZIxuKjsE=;
	b=AHkShKc0lwvpjVh4/gdheXihUjZOm3XEniAB7G0mzneVnJ39K1UFU4MMFscrDBGcqIyA
	 TfhAO7UYQVJuEujap3QRvUaLVYrhq0Xe1wq2ZgFlAOttr++mFzA/lNknWcGvtvFk6uGnD
	 ZVD5CHH1jjWPTFJwM9TS/wLFf70VKj9+dx680C+6gdW6g8E5lW+E+rWiYa7lR4DrLOK5C
	 hbIwnoJN+yrn1mmsul2AtdTSphGCiDMpDieISocvZkBIhJpxqv5hxdNoiBUOgoOmc7j8x
	 mrXoBotv+jaTX1mQRoqmJl4HV6sfgmld19VNsZD3jpKKr4r1WOYmGEMFByQEVVzpzkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mYGS1684;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BE606EE89
	for <linux-omap@vger.kernel.org>; Tue,  3 Nov 2026 21:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E4BE606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mYGS1684
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a190c53a3so1505722eec.0
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2026 13:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793740469; x=1794345269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mqx62j/MS4Vpw2prk2XGbtfQUzR6R3P7OHsZIxuKjsE=;
        b=mYGS1684RqdpIK3Jfjbz6kYwRHrgKYWCC1uuvnoOTjJXIBein+s1KCDC7vlL6NmdcJ
         YJPv4Ur4CgDzErAdxwqLrsAYqUPSYXuMC+qmyYuTQmhquyhpS1vDQ1xYZkjIsf/pDFjB
         i0rug4OnGvOLknH2N8uBjGDfXXfMRGoKRaYD3ZW+YE/tCe/zBJ92Uf0jrZLRbv5IUuvp
         bcVIfchr0lzb86bMjOB5CRy60S2UB+LyHa0kxDCebJFLBzbJgIDOgVBURVQBbTo+GSYd
         cralVlMDdP3a1YXMxNbNxMJ2kWKOG/aFb1PN492xf7orGbZIp1/xLN61vOkM/ykO6NNX
         We0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793740469; x=1794345269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mqx62j/MS4Vpw2prk2XGbtfQUzR6R3P7OHsZIxuKjsE=;
        b=qrHORR9u6EmVKP3LOuYacH8deA2OWIa6CBsPs84l3nwAqh4r9yFV3Kh6SNKxOaobJw
         oBk9HI4UwrslWjnWeSA3bw81w0ZHWcEy1P+oyEh0J6C4U8jyTOrBTgXRMe58Y4uqug1/
         ans1RSPZqEkAED6XS00f8JdEzqDJrILvFfqWlskIPa5o0SWjUw7HMBufGQBFJgAb1BTe
         xLEoiit0fQbHugbY7f1taqYgKNBytqvIii24Q4SDc4++Sa6fX0dsFBkONruaNZPI8rSW
         pQxjg556Fsc+eaxQnu8dag6xlIyd+tt9lHmIIrggPcowiidBw3OWSUuSX+M9kBX3lWLk
         GCaw==
X-Forwarded-Encrypted: i=1; AKwUvByc+wF8fgR4lc4DWqHWE/B/2hXsvcqLe5VuutEGdgKmBUNzXAhKsv4Yx2Bxl6O+UG74LUI7nPxWw2i5@vger.kernel.org
X-Gm-Message-State: APuU4Z9x/wt66SuT86OXJtM5B6LcGZbLZvqZOXfy8co+rpjCS4G3A7pR
	o3kECpIzbL+pC8NMW1FMBmI4a9XYCiXsmPUNR25wxCUd+z/BOyE/s/uObiyHG2XkLNYELLX9K09
	pLmxpQqPEQlzpcZ1TabJShgNgKw==
X-Received: from dycmb15-n2.prod.google.com ([2002:a05:693c:20cf:20b0:369:f67f:7a43])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:20d2:20b0:368:2c6d:ddfe with SMTP id 5a478bee46e88-36a30008535mr24191511eec.9.1793740468575;
 Tue, 03 Nov 2026 13:14:28 -0800 (PST)
Date: Tue,  3 Nov 2026 21:14:21 +0000
In-Reply-To: <20261103211424.127627-1-almasrymina@google.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103211424.127627-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/5] net: skbuff: refcount spliced page_pool frags
 via skb_pipe_buf_ops
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pavel Begunkov <asml.silence@gmail.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Byungchul Park <byungchul@sk.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vikas Gupta <vikas.gupta@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Yibo Dong <dong100@mucse.com>, 
	Brett Creeley <brett.creeley@amd.com>, Justin Lai <justinlai0215@realtek.com>, 
	Larry Chiu <larry.chiu@realtek.com>, 
	"=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>, Paul Barker <paul@pbarker.dev>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Ronak Doshi <ronak.doshi@broadcom.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Eric Joyner <eric.joyner@amd.com>, 
	Mohammad Heib <mheib@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, 
	Chintan Vankar <c-vankar@ti.com>, Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Kevin Hao <haokexin@gmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

Update skb_splice_bits() (spd_fill_page(), sock_spd_release(), and
skb_pipe_buf_ops) and skb_append_pagefrags() to acquire and release
references via netmem_inc_ref(), netmem_dec_ref(), and skb_frag_ref()
so page_pool RX fragments spliced into a pipe remain pinned in the pool
while in the pipe and pair with skb_append_pagefrags() and
skb_release_data() when spliced into a TX socket once netmem_inc_ref()
and netmem_dec_ref() handle page_pool netmems.

Caveats:
- Because pipe buffers created by skb_splice_bits() hold pp_ref_count
  until released (including across tee()), user pipes holding
  unconsumed spliced data keep those page_pool pages in-flight and
  DMA-mapped in the pool (bounded by pipe capacity and RLIMIT_NOFILE
  rather than sk_rcvbuf) until the pipe buffers are consumed or closed,
  with page_pool_destroy() deferring pool release via its periodic
  workqueue and page_pool_scrub() unmapping DMA.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f6764117243..32a9dcdf2cb22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3114,9 +3114,27 @@ EXPORT_SYMBOL(skb_copy_bits);
  */
 static void sock_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 {
-	put_page(spd->pages[i]);
+	netmem_dec_ref(page_to_netmem(spd->pages[i]));
 }
 
+static void skb_pipe_buf_release(struct pipe_inode_info *pipe,
+				 struct pipe_buffer *buf)
+{
+	netmem_dec_ref(page_to_netmem(buf->page));
+}
+
+static bool skb_pipe_buf_get(struct pipe_inode_info *pipe,
+			     struct pipe_buffer *buf)
+{
+	netmem_inc_ref(page_to_netmem(buf->page));
+	return true;
+}
+
+static const struct pipe_buf_operations skb_pipe_buf_ops = {
+	.release	= skb_pipe_buf_release,
+	.get		= skb_pipe_buf_get,
+};
+
 static struct page *linear_to_page(struct page *page, unsigned int *len,
 				   unsigned int *offset,
 				   struct sock *sk)
@@ -3165,7 +3183,7 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
 	}
-	get_page(page);
+	netmem_inc_ref(page_to_netmem(page));
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
@@ -3281,7 +3299,7 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.pages = pages,
 		.partial = partial,
 		.nr_pages_max = MAX_SKB_FRAGS,
-		.ops = &nosteal_pipe_buf_ops,
+		.ops = &skb_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};
 	int ret = 0;
@@ -4692,8 +4710,8 @@ int skb_append_pagefrags(struct sk_buff *skb, struct page *page,
 		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], size);
 	} else if (i < max_frags) {
 		skb_zcopy_downgrade_managed(skb);
-		get_page(page);
 		skb_fill_page_desc_noacc(skb, i, page, offset, size);
+		skb_frag_ref(skb, i);
 	} else {
 		return -EMSGSIZE;
 	}
-- 
2.56.0.385.gac671c819a-goog

