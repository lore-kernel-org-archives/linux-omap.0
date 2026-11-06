Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987600;
	b=aifJTzDbymwErrqREEJmrNQWYNEvvyUOIm2rdPnfLS0IobKmmKXK5B1wHLXzRvPSo5Fr
	 VWGbZmlJPE+jTAYiLBUN5QQeRN7ffDwAIu7lrWg8aWeZhHVKDOZQ3XD+RmyzUuh8+Z6GN
	 9evSghLKdcS2TZaR2s9OSHQvxyJ6v0MsSrItdtUCV0xDjGeYWHG50uCIyJF41mA37agGD
	 QYMnuKMg8bo9yzs93ugcHjm11M9B6V2Ym9IZEdNAJZ1LmnDm7iD6fjPmW/eJPeWTX3QHM
	 utVom7k0CospSYeO7mCCsPXpBF+bY0Ofw+VW9+X5FbmIYoCSXf3QwjcXv2pcmUYy8DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
	b=nc3rKuLcw7xe20kifFQdpKUj+j6fDyH1n0JgphbNi3lopU3ZZIvjOQkQ/oI2OUBy5XrS
	 CfVqZIHokS9bb20lQ6lhlVXDWi+1wluGM++nuZNFviabRcr4X/n9GRnDJMJ+zsi8Lk4Zr
	 RS9JNlkS/u0E7gxNeunSSYqMlfrUcLBF3yiYIb86i5y6zPpDJOq7OyLJ02CbkSAKlEmFv
	 4gODiAzeqWU4PInDb6IRV9/rV0Vh9ezx/91PZHts+GY0jNA+9XkKapNhmQ93qpI658e+k
	 4FlcF1TNfDfniR03WuI+uV1o7jpzM78MmS0shmQnzNbiUsXtM4NE8eg7unmfkRrtFng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jlcDAy1q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340A606A32D
	for <linux-omap@vger.kernel.org>; Fri,  6 Nov 2026 17:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6340A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jlcDAy1q
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so770a12.1
        for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2026 09:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987599; cv=none;
        d=google.com; s=arc-20260327;
        b=gadM06uQalgrGjfHZiNzD3gpW6xeEmHU8bOIthKUZ7Lqdv1in82MHGSUcpV4H9jMIr
         PzEGbYxfKDkLO0Hg6F0MpJMlVCC8D/50dU/KXXeTPwpho1puvVt2CbS4ui6WhnK8KO9Q
         G3KqYC2GveNcyONT0GY8pWqOznfT6prFhl6tt6k1SzHWk4Zs8MQ13W6FqiZs/+kub6Yn
         I3+dd1t8CnQz5wUhz5QanMaF9sFhFl6nlnox98FQAJVFkdHf9GtMJ3A3IpfMsieDzm4+
         JyukGllNb5v4x5OoMoTylsE1F6n1fKPlu6kYOQf1So2LbPI7rSxNC8stuYLMH/zipUSd
         Sy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        fh=R0xbpuAIPvAZAUutptVox2rxioO1xXut+vds/evnYqs=;
        b=oAGJMnX9Ww8uRwsAV4anzmOU02h46xPnwFF8hDk3zMR3iV8eyo/AgO1yNkrSNCZpdk
         rYTDp3nMXKHiqeSZj8nAiJegy2+N/dTsdgaUTNdi08YU2BUrjLGfoeviX0Q9sT4PWLYg
         TMKjhlpYjbvbeo9vh5bdyYSZ6vfr54BT+oiDOR5fG0+tYxGXZf5KBAYDDzwOwYVXoV3E
         eTuDtN5RNfqOvFBuUiV0SkQKyFxB+zD6Ss6BHLxEjgKVRkfuL3bfhfPfwKuxICF6H3Ee
         e2y/qVzdlc4ZujCYdOC2glhyWbSCvVmkR0cs8aeP9FLJTiUD39PXuokRaU3UaeGUJ5kC
         gheQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987599; x=1794592399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=jlcDAy1qwlP8CV/J8ziGOhM7zgiwe1Yqasgt18zZ9BLFfbdjvFbOPJHelnnlWn7/NF
         Iv0y6BvcfswTFEAK+vaTKFWw4pm1SC9i7SkbSqJgyIWek4Oq+yCZaP0CXyGrm6BTXeAy
         PMZhXc8r+FCA+Uan8Tn54ozp3MQPEOEFZdVxBH5ggJzVX08faCYPNZDo3xsJ3VF8tmEg
         pX3urwYaX0msYCvMLpruaNTx6NxqPVTVZ/iC58DSiI1w9TNgPQSmlsdvsWkpbFzggva5
         DeXnKd9qGJxbmFLWSsqwsQR8pJQE3NG/l6oFkjRU8+PfaF5R3/yJ38vi2guHN24z+b5U
         +fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987599; x=1794592399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=dJ9c6Nj7zewMJkHZpzQcszknlm0z7WrNsiXFPq6p2lKKRtqeS7HYec24whEOUbgnBv
         BTHXV/Y3r6VEhKPds73ByizImCIKvdMbjx8WhA0t3oRxtYOPvPR2UEj5a+hE3qGxbmlH
         h8H0sV8L9gdAwEYr94FEIE/MylZKwKysiI7C8Hl+qgfdhN7mqf7GKR3KaCOKvIvDzsbe
         cZc0Cx7addMB8BUlzQoPNEYTcROO+5QgE3uF6QYmeGNY+dCkl3vLl15AyjGPcOIXdQFO
         Mlwr1tAu5cf/Pa8URZR6cNU3kQmiBFL0eBMdqyBgudAGzVHue1LmvLVjB7Ux9L9e3pPk
         qaBg==
X-Forwarded-Encrypted: i=1; AL+hErHvDyoOoPq90wqo4g9OtWCkR6EGGD0URdAAJwKUaUX1falag1poNQW2AeAzfVSqnzBYKXEaxGlN1Z7R@vger.kernel.org
X-Gm-Message-State: APuU4Z8fgmFGK9X6BRYdT03UeL6fs0zhSz74uJMR3lZxDsSPvQmaVZX8
	lJMkZfnw3A5wM+bIP7STvbs4RHEkAiCRlURouX1k1NDQZDaI/wnyFoqs56AOLtS/R8sbOXu/6AJ
	EJv1CA6QsR/YS80/bQpyyCir6CL5C5U72vhiqdnmx
X-Gm-Gg: AYBFou2tulwrpXCVGRC+5Ge3D1/at56Ouo6Ux2ElmzSiV+LnUd+4ANQxArFyDgIVzH7
	XUvhA2LJ877JOhu7MIOatTHvCHyeklLKxZNzuz1CeZrlrO9oBWJb3NyuD2eXkq6iV261yzm60xw
	PVayCilkvT9vIFft5NsfXetd+Z1K6jF6CCMA/fNyauBrMijeL72+1DQ3rAJ2jWwWBNfbP0oqwEb
	/wthR8vYAddIRWLCXEewcn+Nw7gypnjB0LoP3N8K3mYjbLzkXtXorpYFu9lH82ySjMCNiASnqbP
	UpPAk9knuGlHeO4OGtvr9mN2HC7SYzxhxeAvkX6Ijc4WHgT8HykvaXTnmnyuCsCkBcD4Y574P1s
	65VO7t8dfVVa+xSxED5pMEKey4VajRjxyaSzxFG434o6Nx6SjMJrwLZ8ammFaCAO02jY=
X-Received: by 2002:a05:6402:20d2:10b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b6f84514ccmr6722a12.13.1793987598073; Fri, 06 Nov 2026
 09:53:18 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com> <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
In-Reply-To: <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 09:53:06 -0800
X-Gm-Features: AclHuK9NbTvBEPfZwCm6iqd7sXh-jqNYXp8FMPv7QJO9bGGBVmf4WllHJrUhzyo
Message-ID: <CAHS8izO7QmD1qp=QfUsCq-R+p7OuOVUtqPJZh1k+u7H1J3KnoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: deprecate skb->pp_recycle and skb_mark_for_recycle()
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Byungchul Park <byungchul@sk.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, 
	Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
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
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 11/3/26 22:14, Mina Almasry wrote:
> > Remove the per-SKB skb->pp_recycle bitfield and skb_mark_for_recycle()
> > helper, and reference-count netmems directly by their underlying type
> > via netmem_is_pp() inside netmem_inc_ref() and netmem_dec_ref().
> >
> > This series simplifies SKB and netmem reference counting:
> > - Reclaims 1 bit from struct sk_buff (skb->pp_recycle).
> > - Unifies reference counting of SKB fragment netmems and regular netmem=
s
> >    under netmem_inc_ref() and netmem_dec_ref(), eliminating the separat=
e
> >    skb_netmem_ref(), skb_netmem_unref(), and skb_mark_for_recycle() API=
s.
>
> Part of the performance gain from page_pool was to completely avoid the
> atomic refcnt operation, when we can see that page refcnt=3D=3D1.
> Are you removing this?
>

I am not, and this is a very sharp observation, because retaining that
optimization was one of the things I struggled with my LLM to come up
with a way to retain that optimization without pp_recycle. Patch 4
includes verification from pp-bench that the fast path remains just as
fast:

   - no-softirq-page_pool01 (fast path): 37 cycles (18.7 ns) baseline
vs      36-37 cycles (18.5 ns) patched.
   - no-softirq-page_pool02 (ptr_ring): 77-78 cycles (38.9 ns)
baseline vs      76-77 cycles (38.4 ns) patched.

But the sashiko comments indicates there is at least 1 race related to
this we missed. It looks like a smp_rmb() after checking the page is
exclusively owned may fix it. Let me see if that works.

--=20
Thanks,
Mina
