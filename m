Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9628314E;
	Fri, 27 Mar 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636921; cv=pass; b=t5Tkw4RCnlWEd5MwveV1zalAe9PH1vBfoh8AJhjZtUtAUBYCTn/ELq5DRBTVmr3y8IL5kByLJLLApWJsrSFixJgxPXds4LB0jQWxeiil809gN1abuPdQ0Xbbszn5eMkhbVP1HjHLwUmQIv/dmqEBnZS6jS3hX708nEdZalQKpxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636921; c=relaxed/simple;
	bh=hVyWtxZzo86g0oBDSscH900eVF4dnwEPQ6r+2/Ig9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Finx1yRlQTats8auUv/1lLrCHyMCUrOUUtzVyyJLvnbFQdOiznoNsuLo8FzqVaN6ONgXmB8Rlh/+E75E5oA0PTE11qhtZtThbcellNUFVUZ0BN4BN+74zEUMkKo7TkZe3pH5ZS1CA0s0RV54H/1znS40MHtooT8PUq5XkEPvi54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=y+R8JQPx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="y+R8JQPx"
Received: from darkstar.musicnaut.iki.fi (85-76-0-165-nat.elisa-mobile.fi [85.76.0.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fj8cp0W99zyWr;
	Fri, 27 Mar 2026 20:41:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774636909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd4uDnLevu0tSEkSmPLwVZpLlNwGK5ZHbNTrNexbWPI=;
	b=y+R8JQPx1CZdyXpc/Pg1KSZghb0AScXqB8cUDX0LFrgdmol7eT1O39u5F50t/7fTz1iaVj
	65HMTuFDzg8zjtqiRrGTIGy0Br5DOsyTWa4/M4oUJiI/6xelzTO13pE7lvMbK5xo1myE5J
	7HdGS1GKMzoajzFFD4v7CohixFGSVkI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774636909;
	b=WxuI5szQ8sU0yI1aV+gZrUYh+Dpd29NAqtLJPxivWjLmw8bkx1y37p0Ic6WUK0068sWxzS
	PbzMQQb3lRCHttJL2YHJ8RtVQvv5gIPnoz4bkBb5pYSoqaqvQKqBYKJ/gcYOvdfL/VHguW
	ug9hzVYiWutRBnXLgcj66Fyug8QD0Ds=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774636909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd4uDnLevu0tSEkSmPLwVZpLlNwGK5ZHbNTrNexbWPI=;
	b=FXkMIcPmx3d4tetmZV8ueEij7WaPT5f7A8rcTtbEHDZ0NINRYAKTKDR3d9PCtBnVWt9pkP
	zrGxhwRJu8OBgJ7MuD31wpiOZ0zlXPNbQuCKVmIb6pfqH8fQ4xJnSNXS+UkNHz1WoNRSOZ
	NvrWJfUHmEZEcnHw3fUqH1soK9ucuAc=
Date: Fri, 27 Mar 2026 20:41:44 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kevin Hilman <khilman@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <acbPaKSLVXjiIbfU@darkstar.musicnaut.iki.fi>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeUEApQuw8prxr6ku674fqORCy2=givJxLe+cUCC0PGww@mail.gmail.com>

Hi,

On Fri, Mar 27, 2026 at 10:27:07AM -0700, Bartosz Golaszewski wrote:
> > Thanks. This makes sense. Both omap16xx_gpio_init() and
> > software_node_init() run as postcore_initcall() so if the order is not
> > right, it will fail.
> >
> > Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
> > reason to run software_node_init() as a postcore initcall? It only
> > allocates the kset, can we move it to core_initcall() by any chance?
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
> 
>  static void __exit software_node_exit(void)
>  {
> 
> If you could give it a spin and let me know if it does, it would be awesome.

Yeah it helps. With that change, both OSK and 770 work with your patch.

A.
