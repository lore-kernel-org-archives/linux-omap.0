Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DC401A33
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635416; cv=none; b=lck7bhO9xjmHxpk/OhHJNT4qZu0K0Nc5cUT5GKvhbBLdU6JywP85MoBsI/Q/a/O7L4KNyPyhLUiM45Tw6VKZbO8+d91T/4zob7uUFeIX0o8FSmsuRDjRDQK+h0cbdlY5Rll1mQk9Pe0Mq8MOQeF3l1022xSwwnGMNjrT+o0Ozs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635416; c=relaxed/simple;
	bh=4Zrz52H95k+2o4Ds3cyFVf9KDSMD0Ecbhl8XG1xNSLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj+cxEnCG1cwDIOSRA8w5eJVwgm4Tlb1eQsL6OVP9SwnEQpYEbQhAFZp30fKqaocPAHZE3FOit8wM2XMosU9aNFKOS6vn6M1V22Bthk89gvGNIhPMVPesx0gfGPHim+w7bTQWRqxkEJbpJML6yKI9Mg3ENNZNqojTcGkz0zTSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBa2OYyc; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBa2OYyc"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c1632faeb9so4136443eec.0
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774635406; x=1775240206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=So9g254LjIG5mvcH+IfiKGLnYk5lJbv9pvaJ0NR//W4=;
        b=NBa2OYycUzzHgCcPiToCMO5ix/iCd7DXuiDT+1zZbparpN2AUGlb0ThptzB0boWr1c
         wFrhOnljaTKpdbVsrd471DumoqjHgJzeyIqJA2S1Wuecv9vurWXlGmmrOhGan/AAtaMC
         EXv/5Al5OuFaEq2osGhQDIN9tsjL2iuD7XYt0P1UpspTJ7/HqBTh7K+WXnTZQJlENHTa
         FqwTcVj1fiJ/F3tuBBXUS3Q0e+VHtbQZ9RGoHzdsQF+HC9Q6iBIynh8B+HA2duOCctQ1
         JpvGBKRi1aIUXzDgbU4guDnMbysCmUEspTnxKxzL8E267qzl3zmZUCQUakQNCLEjho2m
         Pc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635406; x=1775240206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So9g254LjIG5mvcH+IfiKGLnYk5lJbv9pvaJ0NR//W4=;
        b=XUUWGsF++FiriUNU2KPZl7Cb5/JUcNKmnEJFZ8pSYqrFfwZ/2leta7kRtKyQDSGah0
         LWgw+HHEPR22mgJiKC7lz/loZXKZO1sjGUwfqsEz6dV7otvUV2p4a7LN68dfbv26Pg7A
         xUwtjFZPGjnWaw2FblkzhGrhVx93dWSQ/k1azEQy48x+BzHRIrmg4xARgrLxawAAdDH6
         eUO2aUt+HZwXEYMnu95UyBWUqrmEoKMRe9hsfQWKlEiCXJsMvo2SMWosivAe7Y9Fmq9n
         0MZI8q/uNoWJcxIVZvckelcuzDijo9Yk+WkcAuvggT8+vPg9bEDGcwfiron2nnLbNQlY
         o5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUzqengGS+sDW3kQF0RjvdGWEjBnpLiQaL/y9vWWmyvXJu/BGoVBl2wdmJKjDkce/Je0Z6wQPNFfJi4@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdkCkWsdpKSN9IYIqN4PBLgt76iaxv50vquARz8Yzs9LRvbxc
	SOaESpXdoOcvCy1sguBZpiaK5rAxuDGT/aQNPQc08ytoocuCO54XXIFH
X-Gm-Gg: ATEYQzymYuYOQtlPlr+hXGU6OvIi7bdvrk5u39qFYo69Q5B0kKtZ6GoNqzixqMUbdB/
	+MlRnutPX//7Wke+cTQt+ekDtLRHrh2/IfiuQ3eTxmB4BIdXNUUaivJ+dvH0mXANuL80xbitMsV
	AlblXYC6SNvHuLKFsgX8ToDEUMGVSSJnqaSyZnAvaKAgA4F1kvZnf2hk3jDZ9HxJMPxzRFzG5u5
	mZqodp7lYhzTx+VYGfqq9F0eDm3MQbdrtAfz73JcReYMjBkvI951YLZZvXE8zX5Bqf8Rt6JYMmH
	pSKf/NGx8P6e8Sih7D7jDxIyWMr7yPWRNSeTZuV7yTK2G2HM+zl2jPoMcCJ4V/rgW8UXED7X3tG
	LO9p3rc3A/XNmQf0TKGHjp01kNGR65eeLQomv2M9cqY0RttC7x/Y+Hpvjz9MC+amaHiYhp1NBM1
	IaZs/KjeheBJujW3B+pxZKHuxGJ/IwszqScERRCHA0Oxw90dwUvpSKCE1oBJYJtbon
X-Received: by 2002:a05:7300:d215:b0:2c2:5cc9:6d2 with SMTP id 5a478bee46e88-2c25cc90ba2mr856175eec.2.1774635405883;
        Fri, 27 Mar 2026 11:16:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:85b0:37ea:7fa8:4717])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7483ffcsm32538eec.26.2026.03.27.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:16:45 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:16:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <acbI0NnMvmSiobLz@google.com>
References: <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
 <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com>
 <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi>
 <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
 <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi>
 <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
 <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com>

On Fri, Mar 27, 2026 at 10:27:07AM -0700, Bartosz Golaszewski wrote:
> On Fri, 27 Mar 2026 18:23:29 +0100, Bartosz Golaszewski <brgl@kernel.org> said:
> > On Fri, Mar 27, 2026 at 5:59 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >>
> >> Hi,
> >>
> >> On Fri, Mar 27, 2026 at 03:22:12PM +0100, Bartosz Golaszewski wrote:
> >> > Hmm, I'm wondering if there's a race with consumers already requesting
> >> > the GPIOs after the controller device is registered but before the
> >> > software node is added. I'll send a version with software nodes being
> >> > registered first, then passes as firmware nodes to the platform device
> >> > API before the device is registered.
> >>
> >> It crashes early, I was able to get an UART log from OSK (another
> >> 16xx board):
> >>
> >> [    1.001525] Register r12 information: 2-page vmalloc region starting at 0xc2808000 allocated at kernel_clone+0xa4/0x20c
> >> [    1.013092] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> >> [    1.019500] Stack: (0xc2809ed0 to 0xc280a000)
> >> [    1.024230] 9ec0:                                     c072d000 c0529474 c06b3aa0 c050a3cc
> >> [    1.032958] 9ee0: c072d000 c085c000 00000002 c052582c c050a324 c072d000 00000000 c0503160
> >> [    1.041687] 9f00: 00002710 00000000 c04da8f8 c0060900 c2809f64 ffffffff 00010000 946f70b5
> >> [    1.050384] 9f20: 00000062 c0816120 00000002 c052582c c0525848 c072d000 c04da8f8 c0060a18
> >> [    1.059112] 9f40: c2809f64 c2809f64 00000000 946f70b5 00000062 c0816120 00000002 c052582c
> >> [    1.067810] 9f60: c052584c c072d000 c04da8f8 c050352c 00000002 00000002 00000000 c0502400
> >> [    1.076507] 9f80: c2809f7c 00000000 c03f86f4 00000000 00000000 00000000 00000000 00000000
> >> [    1.085205] 9fa0: 00000000 c03f8704 00000000 c000850c 00000000 00000000 00000000 00000000
> >> [    1.093902] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> [    1.102600] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> >> [    1.111206] Call trace:
> >> [    1.111328]  software_node_to_swnode from device_add_software_node+0x20/0x80
> >> [    1.121704]  device_add_software_node from omap16xx_gpio_init+0xa8/0xe4
> >> [    1.128997]  omap16xx_gpio_init from do_one_initcall+0x68/0x1f4
> >> [    1.135620]  do_one_initcall from kernel_init_freeable+0x1ec/0x240
> >> [    1.142517]  kernel_init_freeable from kernel_init+0x10/0x108
> >> [    1.148864]  kernel_init from ret_from_fork+0x14/0x28
> >> [    1.154357] Exception stack(0xc2809fb0 to 0xc2809ff8)
> >> [    1.159820] 9fa0:                                     00000000 00000000 00000000 00000000
> >> [    1.168518] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> [    1.177185] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >> [    1.184295] Code: e3500000 012fff1e e59f3034 e5932000 (e5923000)
> >> [    1.191040] ---[ end trace 0000000000000000 ]---
> >> [    1.196350] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >> [    1.204559] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> >>
> >
> > Thanks. This makes sense. Both omap16xx_gpio_init() and
> > software_node_init() run as postcore_initcall() so if the order is not
> > right, it will fail.
> >
> > Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
> > reason to run software_node_init() as a postcore initcall? It only
> > allocates the kset, can we move it to core_initcall() by any chance?
> >
> > Bart
> >
> 
> In any case, Aaro: the following should theoretically fix it:
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 51320837f3a9..5ba904f8a08a 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1134,7 +1134,7 @@ static int __init software_node_init(void)
>  		return -ENOMEM;
>  	return 0;
>  }
> -postcore_initcall(software_node_init);
> +core_initcall(software_node_init);

This is wrong direction IMO. The matching by label is working now, so
there is no reason to rush this change into the kernel, it is simply a
cleanup.

Wait until the resolution of my pact allowing using node names, or your
proposal that installs and attaches nodes dynamically based on bus
notifiers (or both) and then make the conversion. Then you will not need
to move init order around, add new dependencies between drivers, and so
on.

Thanks.

-- 
Dmitry
