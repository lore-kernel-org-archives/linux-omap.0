Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF83911B8
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2026 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642096; cv=pass; b=NKA6rSG2EpHBtjQ8bJT80M1BAHLjPYWJz4fh+iJ2mNgeFsieae1/a5hL3lMf54v1r/5egG6etI3HRhyABFbpcDGlFCv+7EaUy1LAuUpQu0CB+nkMBkMq6+oRvKPQZk/6hcxO2a+tNjnQFdsC2sIQB3eAvAu1Ia+PsXnW7hFbMiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642096; c=relaxed/simple;
	bh=NfKjw4OH3cZc9vx5/lhcJtqmI4I79M2cvfhxFcHCX3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7iwoljt9ittBkFqH/bidvUOyr41mQIOrGJZaMsuELTUDxMtgMStSn9RsFtpp7qK2iEUwVLC6MZ0eU1gzdkGSmYOR7fmTPN32NmrYZ4lRJUG4yrQ+AktPrS0JTijVrcKF83Xn4VCjZm/cj4xmN0tB95BTJg4Y1HycLPMuUrhY3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoU8BiPS; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoU8BiPS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-366070f71adso5621314a91.2
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2026 20:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778642094; cv=none;
        d=google.com; s=arc-20240605;
        b=M5anz8kT6zuuLoKSO9k8Mfx1NhyQKaZlecyx1j8CH0mzzxRFXNUXa24Vje30CAHNHJ
         UV1Eh2kerB7X48JdSELM+ie36NtbRnCZwagduevhibEwV+x4KdvrAkyWoNrCgG/VDYMT
         +NICvf80JBIzaenGIvTPrd5A/fOFiMBWvZh4jjtyKyUlyqQrDx7UT3ItSAlj0rtC7x1b
         OC3L6RlOwnkGUl+WaUD9h3Hz1pzdiQlzSimZqnJVkFRz5MRYKFoBSJgfavmIZLjoU8fK
         cPpl2yCgxptfZRvQEfAaKUGToiv+m6AWBJgLpnXz7sKsBpcGps5ev2M9YAXXwe0SN7JY
         1XyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CYlVJgBMJMBSzC9+QqB70POzR/0T9ox9YRqJAIrAuGo=;
        fh=xmGAy3cUTsitC6AfOpDyiWux8DXwq5IgbjmQPfb6VcE=;
        b=ZN3s+Im1gtbieKNLml4CVFW/jRwmg/AxrSNzkAZALi0Mc3xakNoW4bygkUPQnRRTxD
         H2jPym2i9Zuvl4vhz4sRvDSzOZlVZlT05OOAkAE20sylDrGcMZdlXv9qYx+HWLxIl2ei
         lkB+s5gRYGBCKI/61sGnPxqUo13h/7tiog/Y57zq4V9NGe+mEZMxpRwPJe7qYJorEYJ1
         1suJpyL/ejxDyb8xKDuOttPh38wlhDT4rp1uXrWaMAAS0+FXWfRrzs9Ni8pZxztu04Ro
         GyKSQmckmF3gH4TDx1tnBmYd4sMUC+HXGZHVmGVSulu1tMLyBodOSHaQ2TSG37Biktlh
         ecJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778642094; x=1779246894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CYlVJgBMJMBSzC9+QqB70POzR/0T9ox9YRqJAIrAuGo=;
        b=YoU8BiPSQjAF2RxzCuMLgIdUl0lLoqS84iXP8IiingE8LFuozIiqGyIMhF7NwWX0dA
         0hpP65SZDBcg4jVO+XJrH3txGPhR5IPYjoiL8dEaoK6powWQiTDw0DSB3yve0hUH04wt
         RjAoBTXB9uekOptZiwcDtEP0jnFSAKDs7NJCOX3Nr/JtideJr5UmzI6fqyAyAXmCeCon
         f4gSxijFfdXsEFyWAj2wkiSDbt9icjgT2W/Q97i1T/U3xfMRusjIpYjJXYG3H3EmFQdn
         DUpGvobJE3DxvVHWpt9Jh8PhofWa61W9p9JpJ9MC2z0vXu88pAcMNLBY2RPkb/L6Bf1I
         QOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778642094; x=1779246894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYlVJgBMJMBSzC9+QqB70POzR/0T9ox9YRqJAIrAuGo=;
        b=YL4U/OrhuGPJvZSSV5BRim0QrG7gXpGgkISM8wgwUOvVKpWc9YJ/Gxt2xRXz6K5G8V
         49fj3e6QbNBNOsRv3mbLiKT7EWCAxshy+xqKED0bbtnCSSDjb7aZVJDnzw6DkyCr972i
         tChsB6Wo4CymJmHfnStz5lkrPAIVOf2Kaqa2FIzb6N5IC2Q9CJ5SnbVLtUyAQ+ufL+y8
         dt00ANGZGZDapY8bp2m7WPnHSSx+DJwkdVQpRXNvnHCOlvRZCENlZ4fGBVwunhXZUdy8
         mkiUinh8IGNMxmEM6xPnlcdIQKGO3dRbzLY3DuBkWMHz33Qrsm1WVZi5lcg4qqwafijK
         0lMw==
X-Forwarded-Encrypted: i=1; AFNElJ+xNoLna+k5j0WpaAzQ7YHkX2s3Ee6aDX/tUwgqvdQowLHJGL2q3vOSTgkUiN/1P450CMK2lWhLA9e0@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrwgJE3646C8g2N7rJ1/ZdSCCtPpm+3slj/qPhkuuFHTB3gWA
	NQjqJkx2kb20QUezwEmlnstM7Ep6T6eCiERyC1dBZkEfNBeOZOSzqbOr8HSE16KZR+RXp/49bDu
	9h1mgcK3k764yGvab2UMGR5m3UPLbuXY=
X-Gm-Gg: Acq92OH1ehxT8/JKUM4y6antYGsSR0hNaAGi3KwNlTek7FS7cMgjk0551j/e24jLL5k
	N7XnilyvE2xoHhZ3FKU7dk37p2HMHXwdswn7H6nBvg51YQULvzJssl+VTYcmBnpxotaF3Iwr7XX
	nIx9QBu6Z6lcx9pOMG5/3OnpMk9RHAV8+2FQlQ5c408Vsub6KgeF0FK+FmkEJx/i0z+IaTe9kIr
	Fh/it8uuUm6uJLXPl/TavFmdpggQ/MXG7nhDQLbPZggxvBwDBws4lnKBf2ijx5Rnya4AZE9xOuS
	egoQ3X8agGtPBNW9o0X2O9W6FcLPC16MK8TdOg==
X-Received: by 2002:a17:90b:3907:b0:368:1088:bb1d with SMTP id
 98e67ed59e1d1-368f79946bemr1029956a91.15.1778642093964; Tue, 12 May 2026
 20:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
 <20260508103837.138142-8-phucduc.bui@gmail.com> <af_g24kqkm4QhDuU@sirena.co.uk>
 <CAABR9nH62K5qqujXzr_HwT6F0V1ezzENAVnjqqu3zrMvmCYWbA@mail.gmail.com>
In-Reply-To: <CAABR9nH62K5qqujXzr_HwT6F0V1ezzENAVnjqqu3zrMvmCYWbA@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 13 May 2026 10:14:42 +0700
X-Gm-Features: AVHnY4KWCVXMXRBzhAxelHPQRxBLjCfp-EOJxWzIat9M2x18913Y6relP4HsudQ
Message-ID: <CAABR9nGHO+q5BUmUtER_tcC1drz3bBap-+=pew2+JBKYsg_6Pw@mail.gmail.com>
Subject: Re: [PATCH 7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource handling
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz, 
	tiwai@suse.com, jarkko.nikula@bitmer.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

>> This function now mixes scoped and goto based cleanup which cleanup.h
>> warns us not to do - are you sure this is a good idea?

If you'd prefer to remove all goto jumps from the function,
I can prepare an additional patch for that as well.

-------------------------------------------------

--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -322,42 +322,40 @@ static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
                                  "McBSP", (void *)mcbsp);
                if (err != 0) {
                        dev_err(mcbsp->dev, "Unable to request IRQ\n");
-                       goto err_clk_disable;
                }
        } else {
                err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler, 0,
                                  "McBSP TX", (void *)mcbsp);
                if (err != 0) {
                        dev_err(mcbsp->dev, "Unable to request TX IRQ\n");
-                       goto err_clk_disable;
-               }
-
-               err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler, 0,
-                                 "McBSP RX", (void *)mcbsp);
-               if (err != 0) {
-                       dev_err(mcbsp->dev, "Unable to request RX IRQ\n");
-                       goto err_free_irq;
+               } else {
+                       err = request_irq(mcbsp->rx_irq,
omap_mcbsp_rx_irq_handler, 0,
+                                         "McBSP RX", (void *)mcbsp);
+                       if (err != 0) {
+                               dev_err(mcbsp->dev, "Unable to request
RX IRQ\n");
+                               free_irq(mcbsp->tx_irq, (void *)mcbsp);
+                       }
                }
        }

-       return 0;
-err_free_irq:
-       free_irq(mcbsp->tx_irq, (void *)mcbsp);
-err_clk_disable:
-       if(mcbsp->pdata->ops && mcbsp->pdata->ops->free)
-               mcbsp->pdata->ops->free(mcbsp->id - 1);
+       if (err != 0) {
+               if(mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+                       mcbsp->pdata->ops->free(mcbsp->id - 1);

-       /* Disable wakeup behavior */
-       if (mcbsp->pdata->has_wakeup)
-               MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
+               /* Disable wakeup behavior */
+               if (mcbsp->pdata->has_wakeup)
+                       MCBSP_WRITE(mcbsp, WAKEUPEN, 0);

-       scoped_guard(spinlock, &mcbsp->lock) {
-               reg_cache = mcbsp->reg_cache;
-               mcbsp->free = true;
-               mcbsp->reg_cache = NULL;
+               scoped_guard(spinlock, &mcbsp->lock) {
+                       reg_cache = mcbsp->reg_cache;
+                       mcbsp->free = true;
+                       mcbsp->reg_cache = NULL;
+               }
+
+               return err;
        }

-       return err;
+       return 0;
 }

------------------------------------------------

Please let me know if this looks okay to you, and I'll prepare the patch.

Best regards,
Phuc
