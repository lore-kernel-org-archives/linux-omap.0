Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC842E43A
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506452; cv=none; b=D4pp4JK7m/4QdR8L072PyZA6H9d45IEicQFh9hGurj2NAK8JD3aCpiJGSVKvrfx2Jn4L2nWFoRF8YxVR1YAVd6xYOgDZ6X2MbXNRgS4Asy+2v6j6u10uDrZbq43M4ZrkIn6vjmSCERZaHKRIB+MEBIrA+wE6xu7YoHwVBQDW5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506452; c=relaxed/simple;
	bh=UBYBBoGbVT0qDMPUQ7wtDEFeoAv8u4EqWKANGBDwPQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miic3yQWFgxrSM4D5ycl0vAYw7i3tFeWJ95B2xzD/7+ssCrM9+mSbBGGt43OvjIx+RtSNTMlom3lD5anYCD7stmkhsTaL86yYT5wXuRhXMVTtPRfqzPGkiISz2raag+JkVPFDplVUKyqjyfH6U/QgHOgFXhDVtkCkxsIfTpBWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7868ca1f0d2so245282137.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 00:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788506449; x=1789111249;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NS7q+6fusbmwIYCwSSgkm4FqpxMVHZCBweF5L2Z29Tk=;
        b=FjdZJt/ArCL5/4jlH1Uwpca7Brdgi6uGD3NIO6W5j1isgA5P/KT8WrFpx/Nqx4JhXO
         OkISxAlMxslOmYUEzkcjBmpzaw4FT+cnc9CJabOF1LMH8tMFVcxnrIfW4Fwb8AT8M0U6
         juPjGx9w8GZQ6kOKL/n6pgfmG5jDXjPwKPHu7ruTpsw7FlNutzJdnW9riBNphtNgJNue
         JLPUgIVGd97cAwEl9IXJKW/mSnO4fBxCYA+Bz2xb/3rKNtbQ/D8qv3oRCO0bQtcusxc1
         iLoJoMZnn/cK+4FgtZGnZtuDmOaLnQ3w8U+Ca7fVSsdnxlFugEhnbMMtFCDyA9EvUbYk
         b0nw==
X-Forwarded-Encrypted: i=1; AKwUvBxIliPZkd2TKqm/6eCRslFwAje1DQsT03kchvrGnVOZemYmhtJgMmvRsmcdtA1EO7I3OoXvNHAyN9Ai@vger.kernel.org
X-Gm-Message-State: AFuF++mvsyqF4jO8Y0S1NL9xUBS6AG/Cy4Xcxk3Gr8o4YvDhY2iIpai9
	t4v7hUsFlvEgsbL67z+qOBftBYy876Y0iSI+MAmW/VkzkbF2BRlFnjiV4/BosGdEuII=
X-Gm-Gg: AYBFou0XIEc8HDadGWbE+5JRnps1HbMAf/X+DgZ9+1nT4MtkmR9bz4t2WZl2y4EdSsx
	xfSMAtazYrH3hBBA18Fqc7zwbEtxCfolRRaoceSEk91uXq4Xh/Q9ES1SDpOqMqwmn+hCEn8O+a3
	fHdWnxYLElrVR5yYqpY30OdXkx8hjfWqMEqnbSZ0ulnb9thDqHy6jeKnMPJ3AOMGRcNx/HHIa8L
	W61hMYtJPUnMPecUE+/+7rvuHpZEuPPkKlRoX0wSbuMuKaLsqcUH1XoFtCF5NpYU+AAGJRJDooI
	ceqLjBb0/KD1ylkDUEwxXZUEmlMK9LazEUA3qSJ6V9C/ftYDGIYw78kp2UT9JINCNXy5jDue74o
	8PARFamNfdAKe0gHJB833vAAKmocRz7IysZWe66aWRpJ1P2UKDpDD7E9LkJnGGJRY2nlxt+G5fn
	pN+z+/HIvqv6yDPvzJYmw//fx7mnY8BtfWaR0O6n73clnXJgdqjiK/NfekUywN4ZBmUW5MSB0fg
	uUgEeRNFZlVjWsdzVouODJvHbymRnRhFAoXAw==
X-Received: by 2002:a05:6102:8098:b0:783:79ac:9dc3 with SMTP id ada2fe7eead31-78a4a880ccdmr1035642137.10.1788506448927;
        Fri, 04 Sep 2026 00:20:48 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47ad27bdsm1244895137.6.2026.09.04.00.20.47
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 00:20:48 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7868ca1f0d2so245275137.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 00:20:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzaWquu4S7xvDlrpxubzWBhUobxVxIxwbfsM8MoKm/jGXjcvy/m7XysSQeSPjSwPTz+dmzMdB7bKqth@vger.kernel.org
X-Received: by 2002:a05:6102:26cd:b0:780:7e65:f0ab with SMTP id
 ada2fe7eead31-78a4a58e509mr845164137.1.1788506447549; Fri, 04 Sep 2026
 00:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
 <b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com> <69f7eabf-95cd-4bfd-a1bc-a1227c4b31e8@ti.com>
In-Reply-To: <69f7eabf-95cd-4bfd-a1bc-a1227c4b31e8@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 09:20:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyj-x-tm4E+ZC8KMkzx48hpAxkrK==0hjXeG_HQYZDLQ@mail.gmail.com>
X-Gm-Features: AcwNN1W87AoGB0mn6F4o5J_OUipieRwifJnmyyR6p6PKe6C7v2GciBlPCkwdp3k
Message-ID: <CAMuHMdWyj-x-tm4E+ZC8KMkzx48hpAxkrK==0hjXeG_HQYZDLQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-omap@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 06:44, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> On 03/09/26 18:00, Siddharth Vadapalli wrote:
> > On 03/09/26 17:36, Geert Uytterhoeven wrote:
> >> It does not make sense to have a comma after a sentinel, as any new
> >> elements must be added before the sentinel.
> >
> > While I agree with it, this seems to require a 'cleanup-series' rather than
> > an individual patch, given the following statistics:
> >
> > As of [0], running
> >      git grep "sentinel.*}" drivers/net/ | wc -l
> > gives
> >      84
> > and looking for the ones that terminate in a comma by running
> >      git grep "sentinel.*}," drivers/net/ | wc -l
> > gives
> >      38
> >
> > So there are '37' other instances (apart from davinci_mdio.c) in
> > drivers/net alone that require a cleanup.

[...]

> > Since this isn't a functional change, I am not sure why a specific change
> > is required in davinci_mdio.c, unless you plan to cleanup the remaining
> > '395' occurrences in the remaining code as well. I am not against the
> > patch, but the reason for picking just davinci_mdio.c for cleanup isn't
> > clear to me based on the commit message.

I know. Over the past few years, I fixed several of them I encountered,
but never got to fixing all of them. After rc1, I flushed a few patches
that could be sent independently, so there it was!

> I have posted the following series to cleanup all networking drivers
> (excluding davinci_mdio.c since that is done by your patch) at:
> https://lore.kernel.org/r/20260904043724.2955444-1-s-vadapalli@ti.com/

Happy to see my single patch triggered your great response!
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
