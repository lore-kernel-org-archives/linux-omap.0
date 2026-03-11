Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627E35AC3C
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238410; cv=none; b=S0xhNEj7/8a2QBX+YnqDZ4AoN/+7iWHi87MQWPZFrwUwB2DZlHZTFs21UxE9Ddkvzrdpvw7C4/DFrTDGiAXOfwQfcmqfG2Gr1IJepERqKyHoh1/TyUj9cyJVP0jbUmN9Hjj9pWZh4B/vB9PTU+gmXeNgSid1FLDOAPteE3OidaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238410; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKeEPiC8DnPZxVBzfVtF/Vpo5nQ7CIcm+SngWH/VPeVuuV4rq9L6Wf0Xoe1qP7DmNY2BA6n71jBHgMrIIM638qXwMa4ekc0qYN97EBq4pD+oHb6dihe9aFQl4YqH6P5xdhPabRx8Vj8sqkAE0Gp1YKEcsforKJq3dKicVpxBKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so984936a12.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 07:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238405; x=1773843205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=Ns3mYIxXykMajp7k8r4cN5f9YmVMaM1LZweGcGXoMQ4bUtFrBi8EBl9t6Kvnp5SyOa
         kdSRE1kVOM0aUIBAaraFGL6SVTJEda3kxkA3UghIJrpmEuYA7JMoZsi23nYhd7Eua15b
         WwwpDVzisJLxRcatc5gMzfW89Klj8jRLsAzJoHPdO4OWi2yHyfVbMQ41jSA2y96SsQCs
         nv6+1vRBB3QBcta2qIaHbgiQYlexjYS05FqMWGg8kh3L5lYek8eZboe4SWvdOOXV+WQH
         7TxfMBQ4reJlvvp6WFyCbRTovrQbm61c1YuuYPr8Ghoi9O4FnJz6X1ZlU6aS4qSJPGQn
         ktMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf7RJnA67aeCl9u53Lb0auO8PwWJbs8M0VIQU+GzOsPVFkI746nhUkP2xcmboBVJpJgoO4SCNSmJpC@vger.kernel.org
X-Gm-Message-State: AOJu0YzaklfesqMHud3Hv/KDiA0shIvrh5mChlASqTvObski1EZ8CrBu
	HMGgs/30HAzb3ip43lc6CQgrsPSbNHmGskMmxfDFfPjyrTAbSEcWVAwbbYl8hz7l+g//Zg==
X-Gm-Gg: ATEYQzyNxv2Gxd2A/P0G1Usx52QHOtA5yOLoVmqkQmZ060+h6Xq9S5IK9vA9cGoGlPf
	r2hH+4EEaMX8J+vhOMPrY6Dlk0AdZnIXoyxYDZnZj59S7qtPEm/WKpEVco3iiO2P1QthuIyejF1
	fbWwI4z1HwhD051uzShKC5BXnzcb7MmZOq12Tw44LsKNp6YlpbtKXDivCWNBBVB2xlqTmyBp6xv
	Mx6mut9vkcnIeO3UBsSweh6NAedVcbl+XciCoj1/nPdb8RH0XLxRRxSFwS6msCF6hWdeMxJu8+A
	D/uIRzhOubbPMOVDnm2t9vH66VOnSiXPzsu2k/7yY4XEmpon6Jew1OVK7wv0rxbdiKHrGvBN0UR
	2n53HCaKRvOs62PPntQXaTgJMxpNouXw7335tHOC3bRpxd8ww0vOp85YvKUtlpukhF36n2sKehH
	uapWaO8ZnGM3FJnSL6GsfginoYBEhwu+nImY6LjZQPruJKEz25SEDcKPGH+6px
X-Received: by 2002:a17:907:9701:b0:b93:6bd1:a4ba with SMTP id a640c23a62f3a-b972d3d033bmr169886966b.3.1773238405084;
        Wed, 11 Mar 2026 07:13:25 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de48cfbsm59952566b.22.2026.03.11.07.13.24
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:24 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b96dc65b886so180169566b.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 07:13:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXj20Mss+tiuPzuMTXQJG0ffvsULp4EAnPFdPAb8kxpmGYZPJ9aVWTOKciO41g9PTuQbfypAv372Gw@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
