Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DC38AC96
	for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521073; cv=none; b=Fr4LnGXA48m5qyo+R9JUL92KZN3VTD/xfiM9NzjtaWIYHLdevsvNwl1kpuAEPF0Q2+k390iRhEntqaeuikxnMRM/iRanRFu5snD8C6xZBn+uPb90PIhOGUDx2IT5JTs0ZtCurwsGZ1M1lHEoyGUCdrwju+Zh9xoVRM8xROiCCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521073; c=relaxed/simple;
	bh=u88vFk2onmkQ3b3xRrvtWd9AENivl8f91ttRccmuGcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaNCNqWzE/sQcPyf6+qBDf93NfzGckIy4DN0kwUb624uijgIx5fR1JjYOsosI+7ZrTONy+qonpLQCuCe5fc48c+0s7pMB9MzL2vY4i+MTayBh/H5x8lU6VbPGwHrkun8Ulrz0GyG+luNDEUamcJrvlrbzHgMQ+FQNpvNLjpn2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwLgAN5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwLgAN5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8321F00AC4
	for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2026 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521072;
	bh=u88vFk2onmkQ3b3xRrvtWd9AENivl8f91ttRccmuGcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kwLgAN5qmRJb02ARh2TZRlmVL+PadHjfTjgi0XQhPQA3jSptBNoidh+mP1Djn7kDV
	 FNrxvoJFpNoSy8YzudcKrNjoe9l5oN1EKXvHOPVpdyyRE2Fwrok/ddkH3AcRnfdKz4
	 U9ki95Su0164cYZ5JYmgSOAGe51V5CrPF4rV+zbtKIa8qDdTfCJAbzxcPvF556LpBB
	 SK3FMmwSvRcUO95m0XRCvERz9M8Y74r5Ymg/o8Ix2z/mCW2yhpMDZCvvQYlNBaOS4W
	 9tR3XtSaXd04Lo2qN8Ldpc2N2Dv7PDt0CVf3h9Owj2IFRuHHNhmo6rrXmsMeNtp0nO
	 qCjkGx+6qVKZA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so631167e87.3
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2026 00:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rphj6mhnBqup1JqgsLkNmNqvnsxmVDyEmq8RRQWwmyKvY4GsZqrrcZOXJ1uwvaqSazMJT0SV2zBH4f5@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOkIZn+ngWcff5CXolDPfjgpMX6aP0Y/jQ2dX1z6Lx35CsWij
	QHkNzwri1q20Eg5xtwuIXCMta4mfxJ8JrNFLjn4xhB0SaDw0uD59XNge60iiypsa75RaLq96KkB
	SWP2shPlRiUlbSVE5iFc2sFzoVTUc4O8=
X-Received: by 2002:a05:6512:3b10:b0:5b2:a21a:10e7 with SMTP id
 2adb3069b0e04-5b44e311101mr395018e87.25.1786521071119; Wed, 12 Aug 2026
 00:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811130310.3867697-1-richard@nod.at>
In-Reply-To: <20260811130310.3867697-1-richard@nod.at>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 12 Aug 2026 09:50:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLkJF8ZPVtHyZ=A1KhRPtYgXHjCDBMxh1LJasQ0eothk6A@mail.gmail.com>
X-Gm-Features: AUfX_mzke1iT-khzbAfSekVtleGRjvEH9SklOmIH_9M8VPeyL2EcqGq5F2y-hY4
Message-ID: <CAD++jLkJF8ZPVtHyZ=A1KhRPtYgXHjCDBMxh1LJasQ0eothk6A@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: Use device name as chip label
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-omap@vger.kernel.org, brgl@kernel.org, khilman@kernel.org, 
	ssantosh@kernel.org, grygorii.strashko@ti.com, upstream+linux@sigma-star.at, 
	Julian.FRIEDRICH@frequentis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 3:03=E2=80=AFPM Richard Weinberger <richard@nod.at>=
 wrote:

> Since commit 92bf78b33b0b4 ("gpio: omap: use dynamic allocation of base")=
,
> the driver no longer statically allocates the gpio base.
> Having chip labels with the old static allocation makes no sense anymore.
>
> Use the device name to have a unique name such that gpiod users can clear=
y
> distinguish between gpio chips.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
