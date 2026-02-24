Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12836829F
	for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922850; cv=none; b=d3mQPvuCPwQXB5Xgh6QGLdEeD4ErtsMOG1hYYpUargwNVFwaVQyka6fYZGTKzVMmMYNwNkS/gzfYVhV5vJ54UpTx2rNVuRWaS9LgEH8zry74wlSlfxcFsYpR7jLfu4vM4DBaGJ8cQfQ6kTG2LSelgzwcB/zM0wWhCHi504zMlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922850; c=relaxed/simple;
	bh=i3q7I3HDbIZE2ViLYMXs13uKtcpqu5vabX2yCdjCgLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUHHDK02pnYCt1x1d7JtbjIA+R/Oy5GXCUIiUvG0lKrcNN62pNlD1M/PVVV/1aDlKxFvLBmfAcwkN9vnDICK7vBtbMyibDZkCGrXmhzbZ2HEp8eCxRMM9t5VvuCt5pRinJw7s9syGdLrPvfjMdRqWq3ldTkTd0+HT1FH5aO4020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYiAZt1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYiAZt1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F20C2BC86
	for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2026 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771922850;
	bh=i3q7I3HDbIZE2ViLYMXs13uKtcpqu5vabX2yCdjCgLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iYiAZt1id1XT0Nc/u2cnzyYF1vFxlrrnblR4MexnicOGKbXsUmmW9KRaC7pnzJoe3
	 n9pVlQRnZfK1cRZ5q7IdsvA7RgA8QqJ+Vwe4ve2T8wlGtOyZ/H8ipozSExf7n/Cvzt
	 KxjobDZg/mFMEqS3/USm071G43KZOdQY9+rPhtQpVHxnQn7VAUNSGtM4jtMrBJW/f4
	 fwZGYYT0eLUzh1NZ1BWZsvEkPUZlVcubUz08mPsAZ1BIS7KC+K7pXFfp6PsKujbQb2
	 hlCA5BF3BZkB8EbhBll//X+vtF4ZeRpEmeCY3wjPFXnF0QoFfrxY+wbVfbkb8CMkxe
	 Hi4Pr3r3Adgkw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-797d6f934e2so51238627b3.0
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2026 00:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvAILnGKARangIPw6WB9IQg8I5HUebTx1YDd4lwgNOzth9rkYU8Ryoz45PJa2yFwH9nzuImXucjDLu@vger.kernel.org
X-Gm-Message-State: AOJu0YyCk5SqwVZGHonxK+zf9n22IKlDyS4GqtXVoabE7GIZcv4syHc5
	RH8tuOnQ7ZzQRyxSgzn4gkqkhwv/tySL8Nve1nSWIE9NifB9t22jf0YpZ7Qeh3DStmn8M0lGTgE
	oSFXSvmJrXZRhNPNMD2uuxZfrnConJWI=
X-Received: by 2002:a05:690c:4b85:b0:794:7210:61dc with SMTP id
 00721157ae682-79829190d22mr81325537b3.66.1771922849602; Tue, 24 Feb 2026
 00:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-am62l-padconf-v1-1-0bb6f066fabd@ti.com>
In-Reply-To: <20260212-am62l-padconf-v1-1-0bb6f066fabd@ti.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Feb 2026 09:47:18 +0100
X-Gmail-Original-Message-ID: <CAD++jLnY5Dar4qvBcSiUBgPaDR94b4-ONtuZEaO75Uv5=6foKg@mail.gmail.com>
X-Gm-Features: AaiRm53pigVbE7s4jmjKR7_vFmD2hgbe0l7bXfTTEFLsTkiHi2nSHctBg71UP-c
Message-ID: <CAD++jLnY5Dar4qvBcSiUBgPaDR94b4-ONtuZEaO75Uv5=6foKg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: add ti,am62l-padconf compatible string
To: Kendall Willis <k-willis@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, bb@ti.com, 
	vishalm@ti.com, d-gole@ti.com, vigneshr@ti.com, sebin.francis@ti.com, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 10:38=E2=80=AFPM Kendall Willis <k-willis@ti.com> w=
rote:

> From: Vignesh Raghavendra <vigneshr@ti.com>
>
> Add "ti,am62l-padconf" compatible string for the AM62L SoC, which
> requires register configurations to be restored during system resume
> after suspend to RAM (RTC only + DDR mode). This reuses the j7200
> configuration which includes the PCS_CONTEXT_LOSS_OFF flag needed for
> proper restoration.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Patch applied!

Yours,
Linus Walleij
