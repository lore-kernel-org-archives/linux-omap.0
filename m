Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115095;
	b=xm1RrWy1SugQTeKaUqFtOjbJiAF+9vVw+e45yfHPr7/Q0kEJk3WXCCCV6sSXbRKbKU4N
	 4n1Cqu1wz6K0STwpeN/rS3HXRxjSBj53Fwq2CVAmRAUMZ9TaHwWJTmAiDkVN+H6c5g+TJ
	 T/ofmdxA93Nvu7fRUrvrRpqYOHIwkRmlf7Cknq+NNLqhD49CBKPq7tIr7z5hiY5q/VPbk
	 dCKc3UJ2U50iwKCtYR4KQItsIUjzzsHnf+di7SXo578xoVPj87kUPQfqTWBYZYsLLbbQj
	 1c7kuGyxpAXhR5XHKvvBUv4Jze/iwDGqWk7fno6WYUUDNGOauQVKXsVkOBMl5gC3B+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115095;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XJ8YVJK/sKNycWi3MkxIZMW+XV37XoghNTXy23scPpw=;
	b=tVLPXXksp6Q9hYrLuAw4ngNtcdIvZZhiwNL90xq0i6SVmMojZFUiDKrPFtmMBYXg6xYn
	 hyer+rHEOSoX1sRPQm7mnX36LoAfmbKGGbQxIfv6hpvp2WSgAlauIZtYXpUnAGt/dp9R7
	 uJngSU3FDxUq/MmnC1L8gPYnOv7QIvt67TXvL0oQTNMo9U3ZoeT+nqhKFLLM0JzFnx40u
	 5L7cWJ7ydoitwtbp7IDgvdkgeq4wi0IjbX22ec3w+8mFFFD+Y6NWm0S5gK9Dcwinud6JY
	 lCl2CnVGT00l95fJsBu/nOlRZQ1jqKK414Yh3vE1G33+/u94EmEedhqUs4ZNT2Ci+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=i8lbYZaq;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734760A2630
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 19:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D734760A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=i8lbYZaq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=XJ8YVJK/sKNycWi3MkxIZMW+XV37XoghNTXy23scPpw=; t=1795115094; x=1796324694; 
	b=i8lbYZaqPVAxytzJNf8qTb4dYEzo1xQt+g9nFXtN8aduWgNB8qtO5rjXgUxdPKQyNZ9gZ0td3Qs
	INQQhVFkxHEwJBxin7z0wpfxnAeFuHSUTbtgvkjMOoJwv0f8OW+FEKB/xIsNJLLMh1mpaCXbF4lYR
	Ibyt0FR1m2SFP4u7zIyNXeLgl0a5NNyX7Fx/X4KMreQa4SrYIsUryaUoh/IfhX3OEj2q23XCnO8PB
	B2DrxxeXdE7Xpg4k8oLl3ilqQRT+a6J37gCME7lvikPKL6q0i8grOCp4ST07zC1hN74V6NMw6ds3Z
	Kb+cZfSFypcUOL6f+GUcL83UFnsI8Gx15HIA==;
Date: Thu, 19 Nov 2026 20:04:50 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Roger
 Quadros <rogerq@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: OMAP2+: pm34xx: add NEON wakeup dependency before
 clockdomain idle
Message-ID: <20261119200450.038bcc12@kemnade.info>
In-Reply-To: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
References: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 10:11:05 -0800
"Kevin Hilman (TI)" <khilman@baylibre.com> wrote:

> On OMAP3630 (BeagleBoard-xM), about one boot in three dies early when
> a context switch touches the VFP, which traps as undefined.
> 
> The VFP is unreachable because NEON is powered off while the MPU runs.
> omap3_pm_init() sets NEON's next state to OFF/RET and lets all
> clockdomains idle before it adds the NEON -> MPU wakeup dependency, so
> NEON can power down immediately and stay off until the MPU next idles.
> This was visible in pm_debug, which showed neon_pwrdm OFF:1 while
> mpu_pwrdm OFF:0.
> 

I haved played around during debugging with this:

@ -687,7 +695,17 @@ static int vfp_kmode_exception(struct pt_regs *regs, unsigned int instr)
         * rebuilding and running with CONFIG_DEBUG_ATOMIC_SLEEP enabled should
         * be helpful in localizing the problem.
         */
+       u32 access = get_copro_access();
+
+
+       WARN_ON(1);
+       if ((CPACC_FULL(10) | CPACC_FULL(11)) != (access & (CPACC_FULL(10) | CPACC_FULL(11)))) {
+               pr_err("no access to copro\n");
+               WARN_ON(1);
+               vfp_enable(NULL);
+       }
        if (fmrx(FPEXC) & FPEXC_EN)

That error comes. but the endless exception  recursion of course still comes.
I am wondering if I should submit something like that with a BUG() instead
to have some more sane error message.
So the visibile symptom is that these CPI15 bits cannot be set.

Regards,
Andreas
