Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E73C7DE8
	for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356407; cv=none; b=tNE1iIGUOeBd7a1mRxtfyh2FKB11ndKKKomR2wLzIV/zj5ne7Fhs/t/q5MVqPtAYQyWOCEVCUSiS1DUtc1d/QLXaHA4U0Lr/SxhqfZwVqX4NbaNk/BPHgre87r+VIuLFzhpc6h5+ptib3jdY6a+g4JNu+4/VdSTDjkdDvuLvuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356407; c=relaxed/simple;
	bh=384v7QNU8uMOwn752osb83Wsjox2PvAoX3x1D79y4yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAOYNcMTrKtusfbzT7EcvuBPap8Hab0ggcNGndRftOSqMeQyGHSWqzmz0wGzMfXA/KE9PxBi+QUyT52EyHfT0Wq4Nnn0Xtukrx9yrG+UdUbI95zpieDG2Fh/8SIJEq6bFBK7/V0UW+RDOWnnlfV2s82T6FPrJkqOQNwSScbEdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMNy01MX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMNy01MX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0425D1F00898
	for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356400;
	bh=w6oFhP4d897O6hevgiojapWqh1TxSc/Rze+fEmEjBbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fMNy01MXgn7yDOs0oUjw2jFUQpwSTt24yg6pry8fPPD9ZjG/DC4y+11g0emIcDJIi
	 hBMCQ6qnUD2U60Sdxm/PYcEvWhFXPpcZbXoGvmsQn8x4ykjNye8a+ODobDiz/WS/9c
	 vKKEIZ3WQdoyNoJk2MS8ZSvzlLFGP/2PJywiLoXM/E3dcMKwW84FGNHSjJEq+hBCgC
	 oMiqUrtNDM/Os21ic2vpMuicGFwFzf2/adVvjqe6fKyBUefZzFfgsXtCWW6FrgcDvQ
	 wbyqtcIN9stuVPfi9d1QymqYItr+2hbB761p4yeQGMB0KfbVIzznpHVcAQBV+hCrIa
	 J+FiRHKbElF4Q==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so9138341fa.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 10:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByEVXdjXARQhFDPIMBimql4sAELCx57SQlG/N/gMLR6UQeb8W5/xujWROLhes0Eu3dFMZkoqQ3ZluvF@vger.kernel.org
X-Gm-Message-State: AFuF++nQor9QiSdKDRv6Af+WHRDv+cL81tOZcqZAKrRcjJCSTRRO7pWX
	+CN/w8uJ27tO1rDFKZPlXqhjCl9rdkuuOLzPKADCscRYO5QG0NzKNmhjOUE7J2Jt2kuYvbEe/aH
	k0yIlOSkg+Zqg2Kc7ZlMgQk6h2HoDyiw=
X-Received: by 2002:a05:651c:2127:b0:3a3:5a01:a794 with SMTP id
 38308e7fff4ca-3a63bf674d8mr15117381fa.1.1790356398423; Fri, 25 Sep 2026
 10:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907064725.10686-1-hemanth.selam@gmail.com> <20260907064725.10686-2-hemanth.selam@gmail.com>
In-Reply-To: <20260907064725.10686-2-hemanth.selam@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 19:11:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXy6J9Lw929W5RNiz9AetGjAOu0GxdFrG7T1zF3Coe5A@mail.gmail.com>
X-Gm-Features: AclHuK-gDqMuvMxuWX6tWnCQEQ9B7j9h5lfzr84tihm8zFD470uBDG-yTmqpy0Y
Message-ID: <CAJZ5v0jXy6J9Lw929W5RNiz9AetGjAOu0GxdFrG7T1zF3Coe5A@mail.gmail.com>
Subject: Re: [PATCH 1/5] driver core: fix typo "sucessfully" in comment
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Christian Loehle <christian.loehle@arm.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:47=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Correct "sucessfully" to "successfully", reported by scripts/checkpatch.p=
l
> using the misspelling list in scripts/spelling.txt.  Only touches comment=
s,
> no code changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/base/power/clock_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index 59bb37e8244c..3b8ba27802a8 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
>   *
>   * Add the clock to the list of clocks used for the power management of =
@dev.
>   * The power-management code will take control of the clock reference, s=
o
> - * callers should not call clk_put() on @clk after this function sucessf=
ully
> + * callers should not call clk_put() on @clk after this function success=
fully
>   * returned.
>   */
>  int pm_clk_add_clk(struct device *dev, struct clk *clk)
> --

Applied as 7.4 material, thanks!
