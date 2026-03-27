Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11CF262FC0
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638237; cv=none; b=QpX2ZlYYnaja9XgFnWoXy2oQAUe6UZ5ubUp/NU3bfEPHJXdpNXpH6EhwWGYzc839h657N2NABGnuD7KpzBqcwPt+/OD2/2LCRTubE2z0cCq8l1aED1uHtC6CE2FPu8BDPUo3pANZdtn/ix6tVutVP9I6bJfLNeKech0+xuagpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638237; c=relaxed/simple;
	bh=d8JWbiEgeVgaqmtaxFp1joFAajMXm8/TLH9XFRODR6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHv26pqZeRT39qnNLUxdY5oA8MVvxGwZUXCLsV6YFoTWqGbOySdUxV2mloJk2hbtsdCFmrnZGW1LVZATxpO3C9iQSaxue1QxJNfWALxe2WTSh2UWLQKB9ePmMq7OLo7WN+MPKxt73uRS/wJqoP2O3cDjYHMiFWk+aaPT5vnoZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWftKgEE; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWftKgEE"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4b77adso3544334c88.1
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774638234; x=1775243034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hb37xWKdnjS5lXA97a47Lm2vaHCVy/T7RDUhhmT/v14=;
        b=YWftKgEEJB+7iofRNm9nsB1E+4B/7lTzwG1pMzCf6DxScu3teMFHR6gc0n9ZQv8lnm
         G+25MNWefM0Gx1INgxVUGbAf/YgiNwxnXTfup9lDTV3sHTHIHz0ReIK7w95Dm1YmPoH3
         CdbUjXdcBhX60EXAjdTuf7Wu7Dbd2jFJTOH3YkLGCD2NO+gtmn8goLKReZPBc3e9trO1
         c0cvN8LK+81PiCmetrKn4Tvlyhm9yKR6FatynfzBA1YWcU1+8OFixt/R4Aj+Ucm1P3H8
         3LKfbTdlvCeZCTNnh4deCE2FRkxAb4ocSJHcP+35JUwjfn5jmA0ChS1u+VXtB68JDXeX
         jNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774638234; x=1775243034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hb37xWKdnjS5lXA97a47Lm2vaHCVy/T7RDUhhmT/v14=;
        b=R1fjhXAc3ITy4vOr+/AcBMsldZq3xfmvB8Ujc0qOEaKZKyrOuAaoTmbMmDUuLZXjTY
         e3VWSz6ldZKNe+rLJEZVlupKUCoICi3dUO5edTdxw11t1jaEyFCl0G9Q/xk1dtkl6OjU
         6Ixm/0O3h/XftxkVB7/o5cl3dkNp4OIaA4X90V2ZvrugdyE5i3LLFyFKGqVod86UsbdQ
         ex8gfr3hzLDPDDvNomlMdowdLgN4Ens9PddS4f+OCFEwrM3XMIPxyBpRpOef6MolZedH
         weTSEU51eUyah4bJ+IbiiqhWvJgdCl8ufCvMOkgZKHFKA3ah2G7uN/BzS0Jmx1Kr6iU2
         UtRg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0T1wJnFsOanxawu+qNOGzdza1r4bKbMwaIZ3j2rOSgnWZUoUjidZHsA3QxghNEyb2F1e9q+E+z8h@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDTM55VhzL19WiUI1UhiMiHSR7rbLTaLLPhhPMIa+sh7ujhZx
	MLJ0y/qX/yUbvm23THKMDbEBNGb0k/dUiPlpNdKiBtG2VYlEx46dTzMr
X-Gm-Gg: ATEYQzxen6RQnmC0JmChYPn0an7eBj/jg2n8GNZ+gleWarNIxiBI5PbWtxJ7//dzz55
	RRY7gF+yad/juBGCGl1KpzeMYngxpyS5HgSgDNDZOptjnOQuhsCtpW3OlQTM3skB+ddl5Ci70gV
	DP2GavI9HI2LJ8TijOR58N6xVQsNf/MffJqYO13PLvbnKRJEWVG6coIwaKJIEkk6jILwMljhvjd
	lVf+YNt6wqt9Phy6ssZGwp7UiEhh2U+Rwhi1gc5vsP/LcRcM1cwJ7Cc1b2PVWPGtRDciQG99Cqh
	8of2+W2tzhLJcE5+F3kvlFJeRshKgFTlrv3pUEy4LenD2UqCaMv3OgDcMwmu9OZ+NUJcDhdKhfW
	CvSNbeE9rTdz8G+MHXgFiS1Upm8JG3RkGFfRgYLQ8GTVxttWcbZbBipRHKS9zh/NE+nPs2xOwo1
	A+5XOuxt09n0KImpiABu+iFHOvkEbgnF4GFheQMC1on5T0aD3r/tI3CueMA1rWQ2x5
X-Received: by 2002:a05:7022:6706:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12ab28fd24amr1965677c88.34.1774638233602;
        Fri, 27 Mar 2026 12:03:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:85b0:37ea:7fa8:4717])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c49a5b0fsm178578eec.11.2026.03.27.12.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:03:52 -0700 (PDT)
Date: Fri, 27 Mar 2026 12:03:49 -0700
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
Message-ID: <acbUEIXfBMDWEarF@google.com>
References: <7h1phxpzml.fsf@baylibre.com>
 <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi>
 <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
 <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi>
 <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
 <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com>
 <acbI0NnMvmSiobLz@google.com>
 <CAMRc=Mc6JwG2uMr-T0owu_reDgO5WwmzYknEKRdfQRwzuV=XHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc6JwG2uMr-T0owu_reDgO5WwmzYknEKRdfQRwzuV=XHg@mail.gmail.com>

On Fri, Mar 27, 2026 at 11:26:02AM -0700, Bartosz Golaszewski wrote:
> On Fri, 27 Mar 2026 19:16:41 +0100, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> said:
> > On Fri, Mar 27, 2026 at 10:27:07AM -0700, Bartosz Golaszewski wrote:
> >> On Fri, 27 Mar 2026 18:23:29 +0100, Bartosz Golaszewski <brgl@kernel.org> said:
> >> > On Fri, Mar 27, 2026 at 5:59 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >> >>
> >> >> Hi,
> >> >>
> >> >> On Fri, Mar 27, 2026 at 03:22:12PM +0100, Bartosz Golaszewski wrote:
> >> >> > Hmm, I'm wondering if there's a race with consumers already requesting
> >> >> > the GPIOs after the controller device is registered but before the
> >> >> > software node is added. I'll send a version with software nodes being
> >> >> > registered first, then passes as firmware nodes to the platform device
> >> >> > API before the device is registered.
> >> >>
> >> >> It crashes early, I was able to get an UART log from OSK (another
> >> >> 16xx board):
> >> >>
> >> >> [    1.001525] Register r12 information: 2-page vmalloc region starting at 0xc2808000 allocated at kernel_clone+0xa4/0x20c
> >> >> [    1.013092] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> >> >> [    1.019500] Stack: (0xc2809ed0 to 0xc280a000)
> >> >> [    1.024230] 9ec0:                                     c072d000 c0529474 c06b3aa0 c050a3cc
> >> >> [    1.032958] 9ee0: c072d000 c085c000 00000002 c052582c c050a324 c072d000 00000000 c0503160
> >> >> [    1.041687] 9f00: 00002710 00000000 c04da8f8 c0060900 c2809f64 ffffffff 00010000 946f70b5
> >> >> [    1.050384] 9f20: 00000062 c0816120 00000002 c052582c c0525848 c072d000 c04da8f8 c0060a18
> >> >> [    1.059112] 9f40: c2809f64 c2809f64 00000000 946f70b5 00000062 c0816120 00000002 c052582c
> >> >> [    1.067810] 9f60: c052584c c072d000 c04da8f8 c050352c 00000002 00000002 00000000 c0502400
> >> >> [    1.076507] 9f80: c2809f7c 00000000 c03f86f4 00000000 00000000 00000000 00000000 00000000
> >> >> [    1.085205] 9fa0: 00000000 c03f8704 00000000 c000850c 00000000 00000000 00000000 00000000
> >> >> [    1.093902] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> >> [    1.102600] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> >> >> [    1.111206] Call trace:
> >> >> [    1.111328]  software_node_to_swnode from device_add_software_node+0x20/0x80
> >> >> [    1.121704]  device_add_software_node from omap16xx_gpio_init+0xa8/0xe4
> >> >> [    1.128997]  omap16xx_gpio_init from do_one_initcall+0x68/0x1f4
> >> >> [    1.135620]  do_one_initcall from kernel_init_freeable+0x1ec/0x240
> >> >> [    1.142517]  kernel_init_freeable from kernel_init+0x10/0x108
> >> >> [    1.148864]  kernel_init from ret_from_fork+0x14/0x28
> >> >> [    1.154357] Exception stack(0xc2809fb0 to 0xc2809ff8)
> >> >> [    1.159820] 9fa0:                                     00000000 00000000 00000000 00000000
> >> >> [    1.168518] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> >> [    1.177185] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >> >> [    1.184295] Code: e3500000 012fff1e e59f3034 e5932000 (e5923000)
> >> >> [    1.191040] ---[ end trace 0000000000000000 ]---
> >> >> [    1.196350] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >> >> [    1.204559] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> >> >>
> >> >
> >> > Thanks. This makes sense. Both omap16xx_gpio_init() and
> >> > software_node_init() run as postcore_initcall() so if the order is not
> >> > right, it will fail.
> >> >
> >> > Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
> >> > reason to run software_node_init() as a postcore initcall? It only
> >> > allocates the kset, can we move it to core_initcall() by any chance?
> >> >
> >> > Bart
> >> >
> >>
> >> In any case, Aaro: the following should theoretically fix it:
> >>
> >> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> >> index 51320837f3a9..5ba904f8a08a 100644
> >> --- a/drivers/base/swnode.c
> >> +++ b/drivers/base/swnode.c
> >> @@ -1134,7 +1134,7 @@ static int __init software_node_init(void)
> >>  		return -ENOMEM;
> >>  	return 0;
> >>  }
> >> -postcore_initcall(software_node_init);
> >> +core_initcall(software_node_init);
> >
> > This is wrong direction IMO. The matching by label is working now, so
> > there is no reason to rush this change into the kernel, it is simply a
> > cleanup.
> >
> > Wait until the resolution of my pact allowing using node names, or your
> > proposal that installs and attaches nodes dynamically based on bus
> > notifiers (or both) and then make the conversion. Then you will not need
> > to move init order around, add new dependencies between drivers, and so
> > on.
> >
> 
> Hi Dmitry,
> 
> I'm not rushing anything. It's fine to delay this for now. But the new solution
> you're mentioning (whatever it will end up to be) is something we should use
> when there's only a lose link between the supplier and consumer. Here both the
> GPIO controller and the consumer are instantiated from a board file and are
> built-in so there's no link-order problem and we can directly reference one
> software node from another. It's a different kind of problem.
> 
> I'd like to figure out whether software nodes are not made available too late
> into the boot process for no reason and if maybe it makes sense to initialize
> them earlier.

Actually you are right. I wonder if we should not stuff the call to
initialize software nodes into the same place we are calling
of_core_init(): drivers/base/init.c:driver_init().

Thanks.

-- 
Dmitry
