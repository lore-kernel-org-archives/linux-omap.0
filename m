Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340131;
	b=zj5DWsf4ODBdTYVSa4Cb2Px/HyoLTp4RFmZyEKRK/zah5YLn/Vl1WUb0jcDMw+76rInk
	 Ao2po7alP8w+xuvEK5U8Pt48vEj3BArSxv/7/KX7V9MrTw2OfdGIQzmSotGaJwzs9Mwcz
	 QQxSKG9Ju9jn8DnaAnwGEZr5cMMHHQwfcvQgHuDPlXyOSKvoTc5fFMr9KqOCDo9p4yf4K
	 WbL6oFIEc6C7PZ5Pw6xUzZqioR35CbMJR3i4Kpfa9wD41mbKa+tbw9rw4Q0RvL9uda4zQ
	 JW1FaHvGZCFPku1PlJBrSHKWODKdGdxv/NJDoxD4nuSvpV+0NxVsrR+Hc7PCENrV73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=FZwsc4vEEFoPSZcA9FrAm9Zjfu5lDJ7Cw08Uku6ESbo=;
	b=aEWTzdwtzQIv2+hbxqTGXy5eIJ75trosU6Jy3HwvIg/bUijkE22RgjT3arpGLWPNNgoA
	 0V4PKppANjPFM2w2NfoSxjMRdalOEY6HTaAIDQcxXGLFZe1Z9sV6puEvjcBoVY+Y1jY1H
	 goNeYXgvYYZgHgob2ijUuRHywgRYdCS9gplKtnn6nnz/Xh5UBqjyBnEf7hCbqNHTfFlFn
	 Y9RapJO+dTXxH7w1j1JemyeFtkakq59vmcBYAwwlc3tP8DSBpmmpdCLGe/f5fwDMkkRRK
	 9brXXiGS9aENc5EjJWtLqJk48UnppLHbJkTrUdHUCEeDqqaoZv2htsq+PEwgC/EcX6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="B/ndMjUk";
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48218606A31C
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48218606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B/ndMjUk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdd4dafdce9so1003682a12.2
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794340129; x=1794944929; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZwsc4vEEFoPSZcA9FrAm9Zjfu5lDJ7Cw08Uku6ESbo=;
        b=B/ndMjUkDcWvqgfXf/+6/0AGo1TpdEndEdCmBQ8h1vAuWWvvCMRma5AyfOceO1F01v
         SzxOYObtpP5oDROrkYzfV31IBR0ADwxP8XnnFfsDAXtNgNZGQUf3YtkjnHbaF9htkxmO
         +3WVSmPyi5iuXYjJa7jVHF8SI+Dc0P4PfmVcZLkNmXtMU6Wdw6Rmm5sX1LtopkncN6AB
         MSD6Ps371FgU0uojCT59IBgVsMdpn3dHOGOnnv0Uhc+UgXLlFuU8ByTIVeD+cG2x+FMa
         9BRDmV3EGwfRDPDDWVEkEScrkMod3M+q5T9KICPXs0XhWnJYuLWw/UNSc4FbENLKjJcx
         dcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340129; x=1794944929;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FZwsc4vEEFoPSZcA9FrAm9Zjfu5lDJ7Cw08Uku6ESbo=;
        b=qPQ31z/+UM0MaK/cPVmRf6nvZoh6cB9epqcwMh92fnmdP6FjuhuSezqRavVPYZdCem
         YDqZLfJtNv4Kyk5vd3HUWP81N3PlVgxoCTTPogCIDUyF3vzJxC1gt/uukN6uSJPqIqRy
         jxdAaBsnxu18o80VuxWadZJY3NTeBci3i4IYgfK9l89g5YSfoEapTfz/MVrYXrHYe4tu
         TpalVgA8QHFHbVDEtREkJaG/wmMmSUYJVakJExxrwW72nM6bGdcZMIMcsKIwCG9XBuoJ
         vWRA64KqKpRy/LNagh37PyqepwxpQACmxsVPHdHiLVnbBfwW3gygll1PEcxfcz1vV712
         P7dg==
X-Gm-Message-State: APuU4Z82dxdsenJ63tNGOqs2wjGFgMFdQf7IG/bTdhDhZWMCMF7GHsL4
	2lgIrX3SXEdp4FyYS4KeABJBv4XknhoWJ6Kz0HweLhyENBRWITYQicBfU1qJpJKFUWA=
X-Gm-Gg: AYBFou06bKS9+mS0PfHUrrRanDFdZGb2BM7jFjmo4LKLCX6nhYCKQQzEL90wqhCdN29
	wOxWdpMha/FEJHkYdxH6NWVndM5igqEcX/Cijl0jx5OGzCxRFChErGMuvw1VLYzOmq2bV6CA0tE
	62CG+634gXbXyNAzcI+xiquiYNCvyLsludopvZINCpv33I+xu17v5ljbqTQ5WWm1e/5sMFypx1l
	kAvuY1KmhlBDQUFo8aMK8TEzMHeyaWyL14ooyQaSE7QhF+cfzhKtuf3lLRiOrG6IWSTh8zatu62
	GfG3AMKihXRtPTXsTFgm2h5yCf0Hn3UbP1lvqNlAqG4dAxXYXrYuuPAtKqtoxjN9CL2Nb6cl9od
	Zxu3TphptwTVmLt3vGJxqWKTenUVYdN0pgbr9Ozm008r9Ouw19zn5UTsy4MMLo7oGdI2cqRKcSC
	Tw0xPX5W1EAgCcxVMFrTpFhGmdIUrZVEGf4EC1TAZbn6HQ+rLPt945sG05+WzZO1Mpwm/+3pcpa
	nSn40sGILbxplBqOHPyJIIrTsNZPE5gifETix4ZiPpdj8qg79KrnTVbIiRb6dl8YaQk+ijZ8D1f
	n9gYPFpM4A==
X-Received: by 2002:a17:90b:33c6:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b182ee21e0mr8597a91.35.1794340129433;
        Tue, 10 Nov 2026 11:48:49 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b17dfb9827sm995022a91.1.2026.11.10.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:48:48 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, absicsz@gmail.com
Subject: Re: [PATCH 1/2] ARM: omap: cpuidle34xx: balance cpu_pm_enter/exit()
In-Reply-To: <20261028212302.75ec622e@kemnade.info>
References: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
 <20261028-susp2-v1-1-174b52857d89@kemnade.info>
 <20261028212302.75ec622e@kemnade.info>
Date: Tue, 10 Nov 2026 11:48:47 -0800
Message-ID: <7ha4ngv55s.fsf@baylibre.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> On Wed, 28 Oct 2026 20:15:11 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>
>> These calls are usually done in a balanced way, so allow notifiers to
>> assume that these calls are balanced under all circumstances.
>> Seen some spurios vfp issues probably connected to this.
>> 
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>
> Looked again at some discussions with Sicelo testing such things:
> He had observed a NEON off count 1 but MPU 0 in /sys/kernel/debug/pm_debug/count.
> Probably more involved, but lets not freak out things here.
> So that is definitively a real problem fixed by this. vfp_pm_resume()
> would not be called to restore the state without a patch like this.
>
> So this is
>
> Fixes: 1cd96478cf150 ("ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()")

Even with this fix, I found on OMAP3 (beagle and beagle-xm) that there
are still intermittent failures, and the NEON vs. MPU count mismatch was
a good indicator to dig a little deeper.

I think the fix here is to add the neon_clkdm -> mpu_clkdm wakeup
dependency before the clockdomains are allowed to idle.  Otherwise NEON
could idle immediately.

With the patch below, I don't see any intermittent VFP crashes anymore
with early testing.

I'm still doing a few more tests, but will sent a proper patch with
changelog after some more testing.

Kevin


diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9992549c7336..d11967c2f4bf 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -510,6 +510,20 @@ int __init omap3_pm_init(void)
 		goto err3;
 	}
 
+	neon_clkdm = clkdm_lookup("neon_clkdm");
+	mpu_clkdm = clkdm_lookup("mpu_clkdm");
+	per_clkdm = clkdm_lookup("per_clkdm");
+	wkup_clkdm = clkdm_lookup("wkup_clkdm");
+
+	/*
+	 * Add the NEON wakeup dependency on the MPU before the clockdomains
+	 * are allowed to idle: once pwrdms_setup() has programmed NEON's next
+	 * state to OFF/RET, an idle NEON clockdomain otherwise lets NEON power
+	 * down while the MPU keeps running, and VFP instructions then trap as
+	 * undefined until NEON is woken.
+	 */
+	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
+
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
@@ -523,11 +537,6 @@ int __init omap3_pm_init(void)
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 
-	neon_clkdm = clkdm_lookup("neon_clkdm");
-	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-	per_clkdm = clkdm_lookup("per_clkdm");
-	wkup_clkdm = clkdm_lookup("wkup_clkdm");
-
 	omap_common_suspend_init(omap3_pm_suspend);
 
 	arm_pm_idle = omap3_pm_idle;
@@ -562,7 +571,6 @@ int __init omap3_pm_init(void)
 	if (IS_PM34XX_ERRATUM(PM_PER_MEMORIES_ERRATUM_i582))
 		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
 
-	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
 			kmalloc(OMAP3_SAVE_SECURE_RAM_SZ, GFP_KERNEL);


