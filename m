Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D49351C2D
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412554; cv=none; b=Wc/Ybu/d4n0vMIzRNKXcqYxh2Vxba2Ev0ygD4bfen4yU+P8upKmLLK6jCF/sz37y/QDyg3jtLlPfa607ThrQC2CvszjrD7j5oBIR7MLCShO5fzd9M2Y6SuKneVwN0HDB3WuPkCVJkbnpPnQsokRHaAJCh2NelLe95bhB6qq0X+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412554; c=relaxed/simple;
	bh=JNeksg9S+lB98sqZfvaiYvzh63QDCtUQjEt4efnJmzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKPr22+iqfQfba3IbWEJaO2fMiwDkEEVvW5u2+2VWLt4oLKh6NFTX4Q0WE7YBu8QatezdIDdfQH6NWrNkZ9kwZ0E7mCG9Gjcc36vW/QRujSfyrUy4hsMsgdxoeDxwmOarmZKwsK/sRYZoC26xVdvr1f5vvSdBEtQZ2V6X9cXD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56d9f191ae6so272779e0c.3
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2026 00:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776412552; x=1777017352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYGvKR169qobRnTdQfak1Kyzy8QQtDe/iStEp2kI73Y=;
        b=fikYLcW7y5CwgV5pt0Ahkklm9pMuFb2AdY0eEPYx5R0IbkR+d3Zca6kNqMI/KYNaxE
         AMhcMjYNCOLYhBQLryNK17ZeyIqg/w3YxuY8lVUeigW3IWXbXuAyoSJDbFNegFQN6Yxl
         Hj2HxqG8qAXAWxmMkdogCwnqH+g45BZNRGG6q21xQbVHp3CSzKP+z73MUSWkN1l/cISW
         7XZZ9GdAvq/AkBAeZmcdPzmRSapB0/3yItICiaLj1Z4yfz0YYyqGSPMA5b1TmbYGEGlt
         3s3LMXawZXEG2/4Uz9OV1d7Iu1THTn3lYRcCAHq3nreOhiZBnPuHqSbLDAIfgC0GsfYC
         TFvQ==
X-Forwarded-Encrypted: i=1; AFNElJ97uV5N7nSzNxvTXUusHOTL2gWyfbjf85bypoVlFnOG9ZmsyUr9cRkrg/OQm2PdL2MEo1/o65WTsWrU@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYOWX/h9t2jEZTbdj8+oMFXdRo5M7aQpvaZLXhXFIzvRPJzIo
	0o0FNxt7LKAg6wc4jx4EOkAbEC27CW9V9Zet9pR9zF28/AhXt2QCWzMaT5GO3Yhz
X-Gm-Gg: AeBDieuN4/1sPh3jAS539nHtcE50z9/BPdNjfSyCZu7BTZjBSBTe91cx6aUMzwALAEp
	u/A5VIQywdhTb1l1MkNeptu9n3VcN0+0couJkAlSJ4x3ACgQ/I3sdeZSk8Ah+efidBRtv8hHhyB
	MksPEXdG7kNKlKC/UpmLAqvOE8hatcgz+7uYzyxZXSLc/KZkcgC0oEDsHi8zNs47qn7FCnZpoXj
	VYdanU2FHVyKr1MpnQQFgfdKCcVn/MrUvgrltUgJn71c+ZOCJ2we4pflYv6bToPom7sMyFHMglh
	5PRoH+cdgJ2HkG8eBKTdqJ1rv4K6baP2ugPyECJjZrDh8BUMu5/r/bxZOFOpKpVCWkSkDKGkaF3
	q6cVBue6PQMmpxFQ01y42J4bkmYcfDJQe+aM9s6M7uWId62zDEg0XdlBX7DYP8pwSneODyz6jNF
	U1mpLJw9N+Uu7X/sBRBr2JgQ1mf/AUeM1FIwg7fROGcC6qJU8amUGLYGJ8DqGQYeh90ftmBrE=
X-Received: by 2002:a05:6102:160d:b0:607:a3cb:4573 with SMTP id ada2fe7eead31-616f7d6405dmr653848137.26.1776412552537;
        Fri, 17 Apr 2026 00:55:52 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890937da7sm381796241.1.2026.04.17.00.55.51
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 00:55:51 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60591ade110so280219137.1
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2026 00:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5K95j2IEcYta3nyCLZMUohnA14Lt61PqnPDL0xR/rvxuBT8YaVu/hTuItDUZeaYsLGe2k/lTVNH2F@vger.kernel.org
X-Received: by 2002:a05:6102:4a84:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-616f4b50373mr742219137.3.1776412551117; Fri, 17 Apr 2026
 00:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416131810.3116408-1-thierry.reding@kernel.org> <aeEm5DavehkPmSgl@darkstar.musicnaut.iki.fi>
In-Reply-To: <aeEm5DavehkPmSgl@darkstar.musicnaut.iki.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Apr 2026 09:55:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxkOeAZqPsVRecOmQV+n=+ey=nFcdduiXvs9LBj-nNQQ@mail.gmail.com>
X-Gm-Features: AQROBzAxAj1dJZMvY5l2s199UA8tSOX5OgUQyonlFdS__wBHgEBXO25Dv2sGHpo
Message-ID: <CAMuHMdVxkOeAZqPsVRecOmQV+n=+ey=nFcdduiXvs9LBj-nNQQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Peter De Schrijver to CREDITS
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 20:14, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Thu, Apr 16, 2026 at 03:18:10PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Peter sadly passed away a while back. Paul did a much better job at
> > finding the right words to mourn this loss than I ever could, so I will
> > leave this link here:
> >
> >   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
> >
> > Co-developed-by: Paul Walmsley <pjw@kernel.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Thanks for doing this. I think also the m68k work should be mentioned?

Indeed: Apollo Domain workstations, and Ariadne and Hydra Amiga
Ethernet.

Also: IBM PS/2, Microchannel, and Token Ring support.

Peter is also still listed as the contact info in
Documentation/ABI/testing/sysfs-driver-tegra-fuse
and as DT bindings maintainer in
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

Thanks!

> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -3645,7 +3645,13 @@ D: Macintosh IDE Driver
> >
> >  N: Peter De Schrijver
> >  E: stud11@cc4.kuleuven.ac.be
> > +E: p2@mind.be
> > +E: peter.de-schrijver@nokia.com
> > +E: pdeschrijver@nvidia.com
> > +E: p2@psychaos.be
> >  D: Mitsumi CD-ROM driver patches March version
> > +D: OMAP power management
> > +D: NVIDIA Tegra clock and BPMP drivers, among many other things
> >  S: Molenbaan 29
> >  S: B2240 Zandhoven
> >  S: Belgium
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ef978bfca514..ffe20d770249 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26145,7 +26145,6 @@ T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
> >  N:   [^a-z]tegra
> >
> >  TEGRA CLOCK DRIVER
> > -M:   Peter De Schrijver <pdeschrijver@nvidia.com>
> >  M:   Prashant Gaikwad <pgaikwad@nvidia.com>
> >  S:   Supported
> >  F:   drivers/clk/tegra/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
