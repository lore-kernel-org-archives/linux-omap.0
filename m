Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114533DEE1
	for <linux-omap@vger.kernel.org>; Thu,  4 Jun 2026 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546983; cv=pass; b=Kb+dCkxJpAkXVISxtXMg0I1VK/IoKo0up5cfUUT8jxsptqC974zDRbEPFfxUwDHRZQHFItdVkwr4rgL8TJpG1KC1DC3GZzYvsUn6V1GLFUH8niqZ9uo1Pm7Wp5tB1ObrtBlSxyg5x0kBj0EQfhpJfNvjGEppCIhkO6cNSyKc5oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546983; c=relaxed/simple;
	bh=vMJIO0/VJDOw3ph6V6pYDwvUo/TujnLGusvcPY/NRBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+1iPe7iKr2cSuA9WZ/mhViX8VDbCztf/1HcvFgwvRkA2f/uk92z6plfu2Ejv6eIqii0RWmiuhaFzyKdWyddmzhX5VTYQwX2GCUgZ7Zi1yh6rmglWrh5dycTtAVLwhAfkIgJlm3P2PFvmZ46UOI5J3ljfv9FSNy7/6FpAcpigLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBfF/g2z; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBfF/g2z"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660e9ea23cbso132314d50.2
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2026 21:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780546980; cv=none;
        d=google.com; s=arc-20240605;
        b=V2qKnxBDErWHBXZQJJfdxuAsyQ6sRmQBEvHtB/6mhftELCQqOdGGq8hXzJIKm3fpG/
         yAnXBtB2j6jSnEhO1frLC4cUZUucyPWMBVOavZmMEFecKlZGuUxrXko6LQ/7Yx3s/WDj
         R9PimFik5lZTy+gHWmuZB9CSdhPNY2EG5m4JB2mwE4FeGf1A/QBcSJ/JcDcnS2D+JySy
         x+ZuZdwmGcPjOQbyVgpjFebya7q0SMegOOcoxBZpoONB9OjeoSKQI4boBWA0udyIjeT0
         pQc7kqdQvUgtenYTcD/LcH89+nybBuYaaJ6/TpZLV4MgqSAkc3UGgWhGMVSKirzCq94j
         zxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N+UAvzNp7kr1X+8H+52+phqg8y1TmFeAUeyBSpAhRxc=;
        fh=z1Dbg/fVoBoUakeSi0SHRkmOHFCQcsjdZ6NsjsLsXB4=;
        b=EbDSXKzbGPQMITYBNPH5zBY8sxv0cP3sZQbFdeYQa4n28BPUs5kAL836rGR/gAeUMS
         sd4ao7c7QuhHcLBDz0QI04+0USj+ec8MhMRJGxavGav9+h9dFpXovFcPhcEgqceyxMdv
         aFfrBEjP8FnLEQvGr7gjHJqRDjAHhhiR8X1MQrmmVur7q0cUncPayT7qQs4bbtNI50sS
         7PCapDuHvFJ4i6BQnX6TWWUcOK3/SOkgti3ihFFe0KyBxH1A0o/P0ulOTyiAS+tuTfmU
         u3XiuHsoKaw7tkDNaHgZQWT+J/fl1EhH7I4KqyBDzFXQctXTa9OXpEfHvGAPTHufZolV
         OXnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780546980; x=1781151780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+UAvzNp7kr1X+8H+52+phqg8y1TmFeAUeyBSpAhRxc=;
        b=mBfF/g2zB4gACyYVb9XP4LyaU0EG5WoHgpANzjyxewBby6dZ2hdCl2ExRGBWIc1AS2
         D+JxfImGyizH/cHCnr/1YI/ddiFBncQbU4/Tvxx7yT3He4bZHiOs3Y4ddowo/VV4E7gl
         nJQbjHV0xkiQOSdVy59kC10UdS6ZoN29h1q8FYugJfclAa8Wn1l2qvuyEtU5duhlAu44
         XhFvx+dyzDBIn+FOvXLgyeeUPeb/nULsdOjY0ts4cjVkDrqc8DigECuQ2zyLQPIPES5M
         KHXOnzJxYQmAsTB1WYePVs5jdGjXFD9OVzGrOW7+6ZMOLy6mK5r+XInkeskd8FRGaTY8
         BVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780546980; x=1781151780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+UAvzNp7kr1X+8H+52+phqg8y1TmFeAUeyBSpAhRxc=;
        b=QvEK5OQAHGavKT2wsDChKlF1hu+f9PnuO4MxbHB6OC875Kbm44tGPr2ksTxuOU2FyH
         9Q0oKuk7v88MUD9w7g2nqyP6k5fJP/qSWqkxffley3GomnWGOeMMHAKTAIizMeUpfBMO
         BBBLSrfz7B+ezZ/LqIjYfarFAIcxIVNQDvYWhEb3a48CxJPx4w915z8KYVtgNH3tQDAB
         ZlmrCBt9TByy+zLGpMLFPcM4sAchhbDzYQC8MH9ccsUDm4ULs00jOKbLIClVMbdH31JX
         h2UtNY5+SwJLnFiLZPICEjFSkh4UzY/izyInEjgPA9nhqZqgeJtGoMcLn0oHuxQCM1Pw
         QdAA==
X-Forwarded-Encrypted: i=1; AFNElJ//dj+g9MYAd3ZTXimxl0MPbtOPKNV92QqqM1ZsH3UxnuCYUmLU5vAkKxlBlt8fbyIFwXwgKs9aW3AA@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhnGKRU1VMGK8rfwVziJQ2XPHRJTMiiiRaDFNGcV3RmlG8Fh8
	S5Y06smj4G6KFdDjKrZI0W2QlNChEwAkeV68uYEJS8jno0QN5njyplVgjZ4sduqN6bqnUb/p9GQ
	7+EMkRo4ZhGsAIqPHiB4sVVW21fc/1pQ=
X-Gm-Gg: Acq92OExVVvaL4mID5cp3/qcwbRLNePk30YaVQPI5lUTU3Nbh1hW73VXCLj9m/IlqoM
	tMH3MNbR6liPuFlL5A66qiUUqeGJS9LzYD3AmCWi9ZIBIkxwJRw6h6QRWEon+i+KQBY5OGSEZR+
	eCrqxOuC9jT4Dgwa1mPAck+TalI+RasLR5m9fWz971WCJgz0Ju6D5XrhQ6PRymfuvv9rEsS+xEw
	rEGDRIAv07shvHbPwuhWSspM0JsSY7lcDydBRqQS0FwNk+pkLVBHK/bQMT7n18OAdeFlYc7Harq
	68EepnylaUIMELsQskRD6/GtS/3MEfk=
X-Received: by 2002:a05:690e:4199:b0:660:651a:26e2 with SMTP id
 956f58d0204a3-660dbe97c0amr5430479d50.13.1780546980048; Wed, 03 Jun 2026
 21:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603140742.1398659-1-lgs201920130244@gmail.com> <c835f4f16639eb47111aa64c2968193fb71957ad.camel@siemens.com>
In-Reply-To: <c835f4f16639eb47111aa64c2968193fb71957ad.camel@siemens.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 4 Jun 2026 12:22:48 +0800
X-Gm-Features: AVHnY4JWw6Atno5IMaMOvNK1N0PCOo-mGo6u3aZynkumDnwNDuJeF5ImeFCvCAA
Message-ID: <CANUHTR-Z2qwdEwnG1dzfe8zH1z3hbdmGMaDNhch3oOxxA2RihQ@mail.gmail.com>
Subject: Re: [PATCH] net: cpsw_new: unregister devlink on port registration failure
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you for your review and comments.

On Thu, 4 Jun 2026 at 00:58, Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hi Guangshuo,
>
> On Wed, 2026-06-03 at 22:07 +0800, Guangshuo Li wrote:
> > cpsw_probe() registers devlink before registering the CPSW ports.
> >
> > If cpsw_register_ports() fails, the error path only unregisters the
> > notifiers and then releases the lower level resources. It does not undo
> > the successful cpsw_register_devlink() call, leaving the devlink instance
> > and its parameters registered after probe has failed.
> >
> > Add a devlink cleanup label for the path where devlink registration has
> > already succeeded, and use it when port registration fails.
> >
> > Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> thanks for the patch! Apart from the issue Andrew mentioned, the fix itself
> looks good to me,
>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> > ---
> >  drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
> > index 7f42f58a4b03..95b3b58db6e0 100644
> > --- a/drivers/net/ethernet/ti/cpsw_new.c
> > +++ b/drivers/net/ethernet/ti/cpsw_new.c
> > @@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device *pdev)
> >
> >       ret = cpsw_register_ports(cpsw);
> >       if (ret)
> > -             goto clean_unregister_notifiers;
> > +             goto clean_unregister_devlink;
> >
> >       dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
> >                  &ss_res->start, descs_pool_size,
> > @@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device *pdev)
> >
> >       return 0;
> >
> > +clean_unregister_devlink:
> > +     cpsw_unregister_devlink(cpsw);
> >  clean_unregister_notifiers:
> >       cpsw_unregister_notifiers(cpsw);
> >  clean_cpts:
>
> --
> Alexander Sverdlin
> Siemens AG
> www.siemens.com
I will address Andrew's feedback and send a v2 with the subject updated
accordingly. I will also target net-next and drop the Fixes tag.

Thanks,
Guangshuo
