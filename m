Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AA3D2FFC
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198513; cv=pass; b=nmbCTUVKdqrMjKq3c3UKqgAGteX5I7we4q6aTqCCspHEhLo6dzpSbzwe7sjV0W27Drgzx9C7d7vVlTM1jC68/TPHpRrU4lXhmCCLBtyMnXUp8ejtrL7FukGBIzd3SG6FxrUa8PIXEJuim8jPWdCiHf99E+/JqP08J7cHYhbQoQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198513; c=relaxed/simple;
	bh=JP6sOAXLUvLPH7W7EcdkbwSmBSNvmNL/XWPIPeP0OXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ5n4OqwpW/1MmezCBdRnAJlCwucR49wu7I86e91yFSxi/9PBAGDEtbw7/GIBxomiTgpxRKJqovdOYDFqfgs46bAVOmSyJGkg4vjvUh0SnFQXvhC/rR/jPENTBAjEDMI2o0Q6ovfqIN3KENd4KRV6JQ/VgNQ3ImnhtcjU5si9XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbdklFBN; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbdklFBN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce9e39fccbso853065ad.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784198512; cv=none;
        d=google.com; s=arc-20260327;
        b=lywkxF99FSmkkGTGN3uKurYYdad1Cq51kkMstZ+YMdJkF3yEX5JwuPRcOfXJYrqf7M
         2D0PFrPO/kjGPG6Cq05pobDXmkEavhAR7NZ3WEASeJG/bahdSc1IWFZzLp8uEMCpkREm
         EpyGKc6AyHSB9unbdgfYa0Dh6aAsAdKmKlhazwWRC3Wq6uQEqxjdLzpmWTsvpCvsI1sV
         FC5NxBLQO/7JwVGNz0y/wnHtTvqJTuXkR/HNfTjkqDv/ULp0BsPKVS26yqhZ/F9L4h6P
         Z+pI2jaoXUC7S8d15CEbvcQY3NBbd5UNJOODJOFA9dzqiRgMQe3bYyE4ZEVCNuRe5M60
         +8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eQrzUwZj4GqJ8tiddXXhlzubaZjD3v0tccnIoXXZE1k=;
        fh=qC6v0N1enMqYC2AkSH13wHxM6Z3XVmzyrB2bjoKftP0=;
        b=nae6sEvvV8O0+D+fzsYkHq0684C+H1Gmui5UIMfz6JAgZC6KMM9swQhtpnF/JUfrny
         x4eDGkRAS5SoXUGwYL3e9B/KwkRAE21u+k050Bbyz6rScXWGrF3gi7fFGgFaaM3h5gz+
         AmKm6rG0NAvsVYgIuzXK4cDqhRfTf8tY0SRWnCHizRsoG+4XlnitAAydFHH4nDNkO8cy
         D6lUGbB6JpxNmsbVIdRMcxbxl5EhU7ik2NG0vZ48394pkPkTHV7gwd8OUes5kPAPbzB8
         fOL9Sq98W8a3ggW7LUzTQN0Oc+MVcjVm1drB0xCHCoZ2hSxNsgEM7K23xyMUmQiL8OAq
         zt+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198512; x=1784803312; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQrzUwZj4GqJ8tiddXXhlzubaZjD3v0tccnIoXXZE1k=;
        b=cbdklFBNUifx0w2lOF595jpRs5xQGs6+DfCiHP0QARRojLCnd6WnA5iZvANQNLDMn/
         dhBOGQPCAIdNstUcRqnJrIbzFtQVXegzFGjyFoAdlhLdgxzanbOBkpMlf02KwSDTqbfC
         FJg8BYCBN3/FuEjCtz86v0cOfdcN2w/chbvUJ3RkRQ27kJO6uOypEfNfC42swdFtBEYM
         jr5rdHst+R7vBrNxas4ubgFAyAw4P/mtESDIgNPG7XnvCju3kKkUw20R8mXTE7X4bbUZ
         55XetNGmwIckf7jH2XjGY1jGmP0IWPufND41HrAaArSwCgfLw89WEmK3FypaqFaqVM9T
         As9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198512; x=1784803312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eQrzUwZj4GqJ8tiddXXhlzubaZjD3v0tccnIoXXZE1k=;
        b=fdxiFx5YmFan4qn3WxPwO+ojwlJe/tLjHCLB+KNqkKRCCMgtcVzwAHUMz0bRmTyexf
         ivIJ/08cmPHbbccjnxpHcpxK6IDpsUIYEDJJMgIDjqsMntqqyasaayh/FDxJKt5pYg7w
         4QxBntdMT/wx/yrfrclfN+XqYCulIL7o7IU6EqokUb7C/A+6dHh5hitFCFIENhzxzqQs
         rYiHQh01NCGDT4RsjfHqVBT6xVIpYhr7TVytSHw1PKdICd+LhbiN4FKZCPopWoJoRjL5
         02Rl+HNUrXjhJZELXjFxvKFBbRGPzLrkA08kNzXkSUPYtkUKD4LYf2PgvOZLWqgfwnP8
         lwxg==
X-Forwarded-Encrypted: i=1; AHgh+RoxzZ4P3ebKEGyu9dURm9P2BmpQLpRNkOesACHbGtdYtmZDqYJospUYhbl4gGffUWFL+m5BejUVsSf+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyc7DelWCqp/adFkzocPycfE7UYGY2ltOJOLKn1K0Q/jp+rg6H
	SgJNiwR+spg1gWlr6b5B24Wjt8uG5/ihQdfWLtb+se9A/QVHa2M+gCRLQ+Pt9YPg4oeRIblQ3qO
	3x70Q8E6w/0VPkAhZuozVoPBX3g/oVos=
X-Gm-Gg: AfdE7clbPLkzAdAtZIRkCGr8YbTYky/FTqiK9CEMWLQtdOh7wH7RhtanWbehMdL6d3m
	mI01oMeUFXW0/29MknqiI+YErg48zcK3+NGuhoUDjaBtO8TqfzpHXCLkIyAmJQ1BKVHRQ1BJxJK
	pyMeaOL00FighlJIBNJo4DVXxfv8FuXI9QvJEeQ1cbNPSvlxzRF28Cw8HmK4HberOEkYbP6pgBg
	4BHeDlg1Dt5+jvIR0NXAoq7+k6Jm7rHJnCnABtTK1No5vG0Opm3m8Ex42bTbc06bT3WF1P0ikNt
	YsoRtM/21j7IjnTa
X-Received: by 2002:a17:903:3c2d:b0:2c9:e846:a589 with SMTP id
 d9443c01a7336-2cf1f486585mr20139935ad.13.1784198511761; Thu, 16 Jul 2026
 03:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716090829.72082-1-phucduc.bui@gmail.com> <20260716090829.72082-11-phucduc.bui@gmail.com>
 <3940b68d-da97-4e27-8816-e912162b6f62@intel.com>
In-Reply-To: <3940b68d-da97-4e27-8816-e912162b6f62@intel.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 16 Jul 2026 17:41:40 +0700
X-Gm-Features: AUfX_mzrjRGlLMVZD_1hObbnwLCLnGXTB2JeQoYT0Gfa37WjMSZzbVYfBE1414o
Message-ID: <CAABR9nGtoFmHjUcbhKxwY_-YJ_Kb++OVN8YkZKvkCMgBEHFjjQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ASoC: ti: rx51: Use dev_err_probe() for error handling
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cezary,

Thanks for the reminder, Cezary.

>
> Pinging this patch too to make it easier, Phuc.  Certainly 7/10 isn't
> the only one.
>

I've fixed the remaining instances and sent the v3 series.

Best regards,
Phuc
