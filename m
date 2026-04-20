Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA3382F02
	for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2026 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667822; cv=none; b=lTugeoksUctXhLitKtjjg0xoROOYJcYLuX/bPdZMJkXLEjCriZmnotX9T//MWUgCZsxohZQfoXu55Hv90pVMEVlM2oe+pWdGRprqHj/6Y8TIBLtbnFIL4VN2VLpQkGYC+vwC5u1SMCc0kP7xr1KY0fp+7Y2xr0j7O6CJ5X3aydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667822; c=relaxed/simple;
	bh=66683rtKBPWrf7C4XTuvMiaBte65Hl+xhzNuAjnDIic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl1L5yagdqqBK40ewp9JTSj6s4oPv2xcFhIIQi5uBrwuxlgxxz4KBHZPHlE5lTlAypeEJImIw6/dJLaT6FGLOXR5nks94KA+NIpzcp5xRiHgeiU5Vo02+Rbd8tDQAixZdeo6GHIEnTk4hGuw3uKbakqGWOUzkrL79Y5VKrtAqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56f3e6bbecdso809966e0c.2
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 23:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776667820; x=1777272620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev7Q2PR+MzeC42yfPBg+fufDGNaPf4avnQMcEXwV9q4=;
        b=EmnFPBpOc4xadTB5aKDiRjXgYavQa9uJ/kfjNzL62vN73p1GDJEJbY+VDnNFgm8aGL
         zc4LjS3KSQeHeveEX58xPdVOyiEuUmHDIU6BTPdlFpSFILjyNUeyULmQj7U6sArDfoLV
         oGBfPFIYR8WMaWXHATu6EXyo5VD79QVaU6yqAkCCnHLEDPbsFgAlgvmSDNwlnuD6+Gbl
         ugxW82vVoASh1l76sVnjN7zqpzbVTQaYQTsih9AMIg2hj95jkw0ZXRe43LXcUSoyRXST
         gl+JQNrfNSkEIzjLdCjX4djsEWpK+7L0cuLQhFY8pCSj/NaEyhBPeq6608EmfCmjX3dD
         Wy+g==
X-Forwarded-Encrypted: i=1; AFNElJ/MfV8yhYS12WF1lAMd9mH771UcYimHUQxwBlQsStWfIZSXNEsSbzxUdzu6GMu08it/1dYF4129hhxd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2q4SCYxzUoipEDG1WbPyrT53sfMgY9h/vL6V52CVO0ep9KHbR
	xq1U8/Mzj/Vi2J9EtBiJBfFhI43bjpE14mVhnJF/md95H4MPRhByTtQDzXxdf5Pc
X-Gm-Gg: AeBDieuAMWw2RwuFej+gIEEDxPLz+adLYmiUCzGTvCKYzfkBWwCDjgCPvrnbs9bn8sf
	OQxtFaLCoctE5K97p69WCJIeGilKfQGZdp9J/lb/EOQ0XVaOTpf+rUY73woKd1ZAuQRtkx9X+U8
	YBDKOKSQhkHjhUD9rS/0RHU9IpMziQmA2GQSfSo5QXhGnbzPc/5XCl5xCgUBEbfdQP/oWtkYG0/
	+Yf94XT+ByiXklLj+lp5DyrOCTFgBWyQn78FBAuBepyDTW6UABnxyS97HsUIqE4QF61pCREVdjB
	qDrzlUMOT/RaevcRv8wEPDjYpIwQioFMBMO8koVWwQsqF/427loAI0ARGkhl66BfRxovT56c5rz
	EH7OJrrZmWmFmY8bPZ6AgaHxRWJuIcxv48F3xf8cKZVxw+6t7Jvm0LInEDEJ8MeHM+S5ZDS7Zlq
	KaQnX0QBl4d9WRBQRH+e0lwjepClSgeGlwa9JmxfX13yMOQGkM6T/bSEiM/kSieuVEWWuQOl4=
X-Received: by 2002:a05:6122:ec3:b0:56d:4511:9367 with SMTP id 71dfb90a1353d-56fa55dffc5mr5117365e0c.0.1776667819835;
        Sun, 19 Apr 2026 23:50:19 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf90fsm5414515e0c.1.2026.04.19.23.50.18
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 23:50:18 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-613207140bfso868682137.3
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 23:50:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/KFqdxAianbwaefN541RJsRWTYwInucoda362lDY2XDIKZeBlREMbp694sdAkgrWJrqIZXCNG37D13@vger.kernel.org
X-Received: by 2002:a05:6102:6051:b0:60f:7499:9b6b with SMTP id
 ada2fe7eead31-616f859752fmr3673069137.29.1776667818181; Sun, 19 Apr 2026
 23:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
In-Reply-To: <20260417131549.3154534-1-thierry.reding@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 08:50:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>
X-Gm-Features: AQROBzDvJRShLyy63Y8y4xm5mUkGqHiHZxGK82_lU0-LEkdWIcvZD7MEx0w1d6U
Message-ID: <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Move Peter De Schrijver to CREDITS
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thierry,

On Fri, 17 Apr 2026 at 15:15, Thierry Reding <thierry.reding@kernel.org> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Peter sadly passed away a while back. Paul did a much better job at
> finding the right words to mourn this loss than I ever could, so I will
> leave this link here:
>
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
>
> Co-developed-by: Paul Walmsley <pjw@kernel.org>
> Co-developed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Co-developed-by: Geert Uytterhoeven <geert@linux-m68k.org>

   "every Co-developed-by: must be immediately
    followed by a Signed-off-by: of the associated co-author."

https://elixir.bootlin.com/linux/v7.0/source/Documentation/process/submitting-patches.rst#L506

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add more missing entries

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
