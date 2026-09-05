Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2D381EA0
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595355; cv=none; b=bHTqcuf7pwTibZ/FyQBBrgda6Oj+h9Lu+rYZuWmiRi6bxPkNRA8VFSdAI5kPfyRsHzzzRGzmQoDehyONRzMEMOHzi62DaPePX31QXCZ+4RIkMQxwjKoglCYYiKdt8u/G1iMeyulkzhLJgYPqmbe2nahLJlrzyP8I7Nrmk75JR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595355; c=relaxed/simple;
	bh=R8I8oweAS9knfvlYcgDOolf1C9n809RgicPSKaghaHA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qr7jk61CaHQ2ET6NDxExu9uGSPvafp+LqnsBCUBHXyyfz/MT+vkkVs7C44dxzgOq9UiQ4KYxf64VwCIJEw0/BcAcnNRjJoXwY2kzikFohVR8BaQjaY/TGNyh1LRbEDqtEQg9n/j4nlVY9PXcdFiJsxDP9syO1IA7Aiqm4jj9aKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6zXG/Z1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6zXG/Z1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so1480059a12.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788595353; x=1789200153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k4a8kETbbno+r0apC2sHIp95ZZ7jnRlfEcHkEbZMrCc=;
        b=d6zXG/Z1apBsqPr0NiFpJ8qbt90ciC2+Pnk+XnZ8WkG2lXsvPaoZGr4T6CBP8aZoCC
         lkmsrg3PmU9SuNEpEBBMoZV4McIMhwKJL6OCmaelOopyBBBAtJFrR7HKIZikU7Qc/pRB
         G2P54+1Z4OyTtD2zi6Q4aFYDX3OandL8m6L6IKm3BRGnPEZNBb6JM9KxGRFIKHqckWh4
         ezB0yQQlyFTR/ZXgK1JRxjuCYV9dkGfL9PGTW/yi+845NAiUfZxZ890rLy7udSN8Bi/e
         dwBiIpFeyqiu7zi0d7Zymj3/N1zEWzLdWV8PZ4qI+Dnez6yHqQfA0w0pOlo8IFstyEOA
         6xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788595353; x=1789200153;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4a8kETbbno+r0apC2sHIp95ZZ7jnRlfEcHkEbZMrCc=;
        b=VESel8wFeZd+HhR+zZLNpgvAp3y4gp9SQX0jj/t7N2kEU2k+l31UmH/YStPzStuXvZ
         H+Dhgt9myWuKxMYTAzaea0V8EG38Ism9T9hUnCYl/NwfKMre++ShKmP26PJSIHOK0HCA
         za0BSeyklP+KGpS7LZ6QHHwi7wnK1M22MWQbnSrLfsjbJEnVcTJXUM7yWH5two1RsCwp
         Vla1epA7zheZJAPZwR6hW03wPqcDg5tmBMdw3eiHV0FJogxqgWvtzJUFyBWTBEpD9bkc
         F5YfcQxnf++fXOfA/rj1a9+gvwotFiTq6sBZeVouxJRQDqgqewgt4K+eTqsFlr6EkxKP
         L0wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDwXSirFUAP6sRoU8x7YnLbc8gDcA7zvr0lRTIlUal+jQrdpObFXmh7j0zUQDNrsBDBtvB5rS6ZzAW@vger.kernel.org
X-Gm-Message-State: AFuF++mVg9D14Xi4WcQLFl57WMsg2ku0eCbPJNN1iA0lZeoP3gCngZMY
	PyBOgz2UoBZ6iVfd2NyKDoNEYOtPKXE7Sg40YbV1BItp9jgcP+rIdBrm
X-Gm-Gg: AYBFou1bc2fMKeZfiJ7fmCP6ViZNnXRVg2UH7n0h3KWQXwlTm16/aSuYW3ma04azoU/
	KN5T5YVM8yvvDag3D6NcLAP9/54Pao9WuV6b+8hUO2aXFuG/ia1GWuqKar335owQbXXe6HB5gGJ
	79JRX3Jg8L17aFdD873bOZh9UBPdSBNwyvqnj2Da/ryZaFhM6Xxx8ifZhSLHx5QgJTcDPqcjZbe
	6cJ0+yJ55gM0Q97KtrGBG6eiD85SdreW9vd1CAUMxmVbww6a2//+kub4UEjzHe/6zYjcykKEo8f
	IvVAs/wLCEJ4sB7WyMgOmljloMRAUZWaZJskpcUi1EbLwV/gH/ONvpBiG7qCTr4DlcNp/hSHCw7
	9JpnK5UIOO5B66mkYDm4ZCrU8qDCA8KPutxqDocTzarA7IMeVAqnysJ6rI5kHifJjSaly4ESHCd
	brbPU8i0G0l4akKdVHiiALXT6PiJ9aKS+jCYz4wgSYiCwWzbF5WLncJJxFKxFLy+34eibnhsO1G
	SXFY942YdLi+C0MfBM=
X-Received: by 2002:a17:90b:5246:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39b262a3cf7mr18232824a91.24.1788595352899;
        Sat, 05 Sep 2026 01:02:32 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm15543669a91.12.2026.09.05.01.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2026 01:02:32 -0700 (PDT)
Subject: Re: [PATCH 1/9] docs: kernel-parameters: Drop the atarimouse= entry
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
 <20260905070347.25902-2-kmehltretter@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <762382f0-87cd-2148-9846-40448c7b1702@gmail.com>
Date: Sat, 5 Sep 2026 20:02:11 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260905070347.25902-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karl,

Am 05.09.2026 um 19:03 schrieb Karl Mehltretter:
> Nothing in the tree parses atarimouse=. drivers/input/mouse/atarimouse.c
> only takes a module parameter, and git log -S finds no __setup() for the
> boot parameter anywhere in the git history, so the entry has been stale
> since before it.
>
> Drop the entry.
>
> Found by cross-checking every documented name against the __setup(),
> early_param() and core_param() registrations in the tree.
>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd2..c8d96de4c00d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -591,8 +591,6 @@ Kernel parameters
>
>  	ataflop=	[HW,M68k]
>
> -	atarimouse=	[HW,MOUSE] Atari Mouse
> -
>  	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
>  			EzKey and similar keyboards
>
>

The code parsing this boot parameter disappeared in the conversion to 
input drivers sometime between 2.4.33 and 2.6.18 (my fault entirely).

No one appears to have missed it all these years... thanks for taking 
care of this!

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

