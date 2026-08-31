Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646F453A4B
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199887; cv=none; b=A/lLOcqeTPNGzdZ2r5hVgoYcWci2Sp5gA1SCVzSyEyFI0CBjezazkgNUbZhzgsSBZqVfdb5FCWZE9T6CIWylAv9gxXOVunD9mO6sBjDPdCYdD0TI4ojnL4OXyDDJrFEUJLie0/Yvbd7FXsp9ZxvimM9S8Oop9AiqwrW2bQ9r75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199887; c=relaxed/simple;
	bh=fqYrrNpGh2ZJW4WjzQHxVJrJGSwNCRN5qjhjUVjTS6g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DXC/67kIhv1fto5N58YwRxhwseETRXV0JmQJgMzCsdG3PcpjkoUnmWG2ldWCNzjYX0rrcwGGufr3E7Yv8uAwIop9IYlPygU35mxuT9AUwDuUnW7X9avibXOoVkYxisnJY0fg+bu2iLMu6JYvQQ6ngcWATSGJWtsUATI9rxVkK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hVJXPuzt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hVJXPuzt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84864086bfeso4113039b3a.1
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199884; x=1788804684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0COa3gwYNjuFphklOyEy628vclsQHkS7aHlFcluzm2w=;
        b=hVJXPuzt5XjDm3RFBE52f1B0PYRMQGCPGyUxXgenn3niVG4ypvDc02xz5JsG1laV+n
         xHojciVZgQ9TxSfEeA+JSH2rSf4CojWyYQ4XnY74x7wu5uxsIR6SZf6ArWYdNnFJRdfL
         SnqeSTGK34iM4ItletiG3IK3LKf9a45GXuJibveIy0kIW6PKzpw09eBkj+4Tz3wSVMQS
         7h/G3GHoeOvcd9KjaIPDm4eRUA/IcdqSfEbpD+/7+S6e1UYi8NFLvoFX2rKSmLB6z+zB
         RpBJpHPhpw1CkVCj9OQOs7MhTG9AFiwtQyoJWIbFHGjuaeu0du6+QXd1SKeWLSDTB0H2
         nLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199884; x=1788804684;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0COa3gwYNjuFphklOyEy628vclsQHkS7aHlFcluzm2w=;
        b=nm73GnIuT4JSJ8bsg53VC4uHvLL9b6naOaSTAHHVTHuP8OAYlWb+BSF8w0/FeQmYsw
         fIQdCQ2A/u5qyqwfk6cOYldz05qiHKOl2bEDP3aHBUhQ2ePooIsEWXYsGm44FzjfB4X2
         WmyKoLGoZSp4BGPHvC2uDUdHsEdMHhmx801uUo2MaFxPxCbO26ed+wvKvr+f/djyAIhH
         OSoU1UBp0wF8nSmjsVlfMGxLFeSXFsGiczABN3C0cpTV+uWPXAljXljJ5w8PmWbuu8ZE
         sXYDmuNfhOOyYeMVtRIAb/SjWbJGOM7tUW4EOaW8zhKz0AZLyyl+SLUYqfI5AZtXE7gg
         DcWQ==
X-Gm-Message-State: AFuF++mNPKNAC/A1bxo2nvZhaK3NlR/tXIyfkSgH2+wmMLWdYTln7H4N
	Xl3NZmF9vyGUmWoXcIsFVhOtoSbdMvyZUyvhcQU5rdKFyvvAvmoDoVuKmYzQYlKP6d3LJmNqWOY
	wVAk1
X-Gm-Gg: AR+sD10QnvRjx/zR5u/bG4UtDkoIzMZ2/dYSsBJ4Z+jwTiSMPeisbUyON0iioe7WbxJ
	aQ9yDe1DWEsvgEwpzkkWTM17vWSp5kAKXSfSKOkLHzVmRC5x6E+qGstFf7HaxplzHYPw9fiLsd7
	PzuCXSBJLBYOgT8AqdctqhcJntk2axrx0M4JzUS5jA/CHVh+S+QR1GFlwryS42vHZ5zUKOFymV4
	Irt28Vzbi3V9zqeKtlLMVE7n/yR+aU/vzxBZLb+6iSZrHI/UirGVUJb2TbcXRRVevjsV5gIIo93
	qLGxR13o45q9R3YYkvlX0ELfIMxZFAyWzkb2fD3DKOfNvQxNwB+mx/GcufLOhViwdKV3jSZsKFw
	7X47UHhI0ZgPldeeylVASpXlaSH6rp0ny50vyNOqGJ6fodmVaCHx5zbpfIP3P+ydCtDSUDeL8Zt
	MLwLtPdptbRr1xeMqTVMhBScdSz/vNWtE9lEznwL5QfFjTg1f/gL4RLHNaTw==
X-Received: by 2002:a05:6a00:3001:b0:84e:9257:d0c2 with SMTP id d2e1a72fcca58-85b59c6e775mr4223738b3a.9.1788199884202;
        Mon, 31 Aug 2026 11:11:24 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8569f49ed61sm4357798b3a.1.2026.08.31.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:23 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Thomas Huth <thuth@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260821081356.165038-1-thuth@redhat.com>
References: <20260821081356.165038-1-thuth@redhat.com>
Subject: Re: [PATCH] ARM: OMAP2+: Replace __ASSEMBLY__ with __ASSEMBLER__
Message-Id: <178819988345.2869653.13752991641389128437.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:23 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Fri, 21 Aug 2026 10:13:56 +0200, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__ auto-
> matically when compiling assembly code, __ASSEMBLY__ is a macro that
> only gets defined by the Makefiles in the kernel. This can be very
> confusing when switching between userspace and kernelspace coding, or
> when dealing with uapi headers that rather should use __ASSEMBLER__
> instead. Let's standardize now on the __ASSEMBLER__ macro to avoid
> this confusion.
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: Replace __ASSEMBLY__ with __ASSEMBLER__
      commit: 9d458ad3ec1552cd99ca1316ea30c4901e4fd4dd

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

