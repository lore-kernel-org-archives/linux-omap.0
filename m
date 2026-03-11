Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706D257825
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235391; cv=none; b=JG5TmkxF6hecxWlTkdBqGI0183X1EWPeoIRsJxH4zixCABW8xJZZB/4syzbkEQcOCKq8sCWtcYp8MkEHKkpdbfRrhgdY/ALzhdRvW78X0jkBc6UDA2uvjXPEAIvFATXeEt86qwqWQflEghH7QlKrZM7bSzQdYbkLrvc4jELA6w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235391; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHBfcehI1lhG06HkiwfsF36gFJCuxQLgVkAeMp/B5B9ifaFov1WgJurx39e+i9zLdfb+SKcCvmNkysKcpC8B8szgDamu+4JW3tps8KvU2gpJKIPVdS4056yh/PrJMz4z5g6aVYdp2kQEpwcOpVwDKatZzcBd2UNgxaXKESsz5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10529900e0c.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 06:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235389; x=1773840189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=b6G02cwQiTUTWXl+FPbyNJ8OUjSKtPz0kZHE7tI0BjNtFUC9EApe3W5Of7o7uppabn
         hqCohgsom6AUvl8xrOGoXrsSVkbZ/uZHxYtUsccZ89jpyeRPjpDw8Qrs1adG4S6Law6f
         XR0UM+0xvqpG6ioY0KHVqdrVHMYONcUpTBVmto0Sm7wHhAW+io2goDYg9BmD2O6UgRjq
         qcCEMmHAYq32Twnqx87XAat5Tam1jscg1bZ11pn+Dfx+0ZRvspUkhzvRFOnxa6BAKW8H
         5CUaziXn/fPtnTA0aoMsM8uy+pjEy79Mm4CkPBTRsdwNxkkXKZE24J5udjK/jB+ZL7iy
         93bA==
X-Forwarded-Encrypted: i=1; AJvYcCWVF5eD4PnRb7SqWmnWMap/DOxM9GGRBkVSSoncETF8MOGMRGTnIlJ5ubnste9wnAPv7h6u5Dc/CQdq@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9lq0FbuDq8/aXe8nSuY85DzADJ8rTDJo1FUr/zy6rh7EpK0q
	N39MBgYEQO9CBloSVbkKNgWtTcLA2lQ2Ec+9GW2jbi617HJo3Qr5lw5eqY50L+an6aY=
X-Gm-Gg: ATEYQzy/Rp8PTawSBp1IV35durMjs18cQl5Go5mgFd9HotxNKVTjX4RBYrJVJLJwCKR
	SHcqCW+QzFpnu3L88aVvVvsUpd/HVyKwyX4NHboeEYEqVufGhGqKddNG8JCvSkaK5X3n8ZAOdoZ
	ZIjcuKKJHOFi4qsb+vjo+POCgOyr1bvoGuu0d1bXSPtCCBP/JhOwiUCMDXH7alu+GK0MYjvmsac
	vmkDsJwIbfnodLzVTWHuO2N/IHHS1EtQLZTjvsUHomb45z5Ju4ClJ5AMPOyTZ+9S6eTW2+qd37a
	S1pPGqdUvhZ8X87xy2VGvQ90lyza8GkWb97MZj+FOu7Z0l8EPOXfjMIeSzn7bD9zXzVGyVSOPTp
	qD3Ubp1xefbJzMS7D0Lvw/WjryR9QkNqXIbW8uVprW7JC8rGPNh4d9vFQ2SN4yErMqyUP15dcHW
	6V4cQqnkyfc90HQy4xAn17lad2hTfCQ5SlR+jvrBk7y6WEJBIz/HyZDkOQNBBwvEOM
X-Received: by 2002:a05:6122:8c17:b0:567:5ccc:1367 with SMTP id 71dfb90a1353d-56b4752d741mr866037e0c.11.1773235389220;
        Wed, 11 Mar 2026 06:23:09 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4646bdfasm934846e0c.13.2026.03.11.06.23.08
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:23:08 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10529889e0c.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 06:23:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVixX3XzHGpHh48GaBYjdXBmv0n6PH08zGa9faGNzNOA005kokKtn1EC9M4jAEiQHCbsOXd1QdNCJ43@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
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
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
