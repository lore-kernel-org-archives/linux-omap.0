Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9503546E1
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137081; cv=none; b=IxB63i1rvQOpa9tfXl4OqEFhNRuWSVdRzBXIzRuARZmW2+aADwrKHXXMdduy1vSlg2rUjmhYcCDrgAuZqmh7JpGGw/Zny3I9+ApySA1x0zSgRuylYE4jvRxqc9pIHG7CIsnb6SF9PFJ13ybwoUrXlW+/qadlEXpIgR/gHCDIS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137081; c=relaxed/simple;
	bh=PP5yhYryslowLo+tyyQ5GI0EMA4NSlKy01xm398KDD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2p2NHO8nWKJM+XOOT3ZhRwoOO+E+WinahRII6XCN50I76S8eAmC7rH8ila3AuKxhFTZVpQso9WAHI39rYHlNYA+Lzy2TTxOAQZp6IGSDcgYi2MvBbaEMeGp7m2LRvvv86H3wSjmOUGqQyDdKxikahBo1A8wGVdOvG6Kc4+bx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQpF2Hsq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQpF2Hsq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1139D1F000FF
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137080;
	bh=sPFcLEJayxJS9D/zfRUeWNmk5gfqjsKMVFMkoI88Te4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nQpF2HsqcbiSVL0p1lfn+hDGnbuoS51NjYT7cy2pol+XFtRd0wrJZF5C7hcB/uxXn
	 lENw92ZQY1RYjAnmbPIDAiDfkk4gEK1zAW8ukQ+i2DVbKptU7AA9SmPiS+rxjYBi5v
	 uq2NTUsLFmSqCXeGI8w0JOqXDEB3nvxUz6vA40SlsJFRyEAFXqoBan06njezePWh+X
	 v7f7G29Qd+0Ht5CpKmLynRdH3vtw0gD+GDy0sDJy4o1jD8X6EselJGxyVUzI+MR/zA
	 vtw8/o7hl5nVBF5XCrI1tjoOC823yDTbIzW8/n5zlO5gfkX+L+zBeH8KnmXTj819MG
	 5ryFKqB/97RQg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b76668f4ddso438551e87.1
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 07:31:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy0cWi8v6lG4KCyBHjQsq/gVJtwVzKHOjFa09XhQj5stxcTSNQRhDyTOXRBziRXPc6tZuye6Xp2iQD9@vger.kernel.org
X-Gm-Message-State: AFuF++nwRnqCUIcROQog2U8NTH5n8eSQvE9XDEYh8yEdUy7xQ3AvuDW/
	+VFi4t+E3VhhUZ/sqZvjb7n1Hyb6phVJXYmvw8ub/7vETKN0roCqrzBXsfgnCzjkTFrUjAmaN9P
	om7NpgCcs2Ezod7S+o83NGG82FDFfqKE=
X-Received: by 2002:a05:6512:10c6:b0:5b8:99c4:a17 with SMTP id
 2adb3069b0e04-5b8a033a8demr931795e87.21.1789137078446; Fri, 11 Sep 2026
 07:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907064725.10686-1-hemanth.selam@gmail.com> <20260907064725.10686-5-hemanth.selam@gmail.com>
In-Reply-To: <20260907064725.10686-5-hemanth.selam@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 16:30:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXcrEmxqohi+h2n46fiG8_8xg2TuWdsVXMmxDACHE7Nw@mail.gmail.com>
X-Gm-Features: AcwNN1UjsLlmoohGA3HkY-aId86aupbvdrMevM43Cjunyt9mta9vrSXyoY3yyVk
Message-ID: <CAJZ5v0hXcrEmxqohi+h2n46fiG8_8xg2TuWdsVXMmxDACHE7Nw@mail.gmail.com>
Subject: Re: [PATCH 4/5] cpuidle: fix repeated word 'that' in comment
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

On Mon, Sep 7, 2026 at 8:48=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Drop the second 'that', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-te=
gra.c
> index aca907a62bb5..d2fc216c38fc 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -281,7 +281,7 @@ static int tegra114_enter_s2idle(struct cpuidle_devic=
e *dev,
>   * LP2 | C7    (CPU core power gating)
>   * LP2 | CC6   (CPU cluster power gating)
>   *
> - * Note that that the older CPUIDLE driver versions didn't explicitly
> + * Note that the older CPUIDLE driver versions didn't explicitly
>   * differentiate the LP2 states because these states either used the sam=
e
>   * code path or because CC6 wasn't supported.
>   */
> --

Applied as 7.4 material, thanks!
