Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F41D5ABA;
	Fri, 23 Jan 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175850; cv=none; b=Yk70AF/OCHO8Bw/bF3mWvjJQs/pYrH94/DpzbKNqGDfRYP6gFNxwI/xF78sKpw2ZUlroNToNwDNUJWMrPohmN92xI5W0HWMLAe/W8eVXle0krQK7LV8fV51DSTma3kU/GwMBRDJqjr0ucUdOsJZwg3Ckh6Fwvjg7X+6599ZyX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175850; c=relaxed/simple;
	bh=rXE/aBYuAX4Ta/Z3d+WN3DtmhafTuRThZ/pBZ6ZyjEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PuWGMhlVFk4bRYcQaTqQZf8qH/Lg56/oPnwuiUJEp8PVZ2HD8CtuG9Tvd3QNR+60v6JXIYtzEnKP951iQMP7sLR9DEpWTWjn5AQQ2bJ5Ip1bHUHBIx5pYjoaq2vfPPDFhG8OjxhEqwlpW8RFxXEWHeMp9+qQZUcWi2fFgxyVxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gau9yVXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gau9yVXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9631BC4CEF1;
	Fri, 23 Jan 2026 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769175850;
	bh=rXE/aBYuAX4Ta/Z3d+WN3DtmhafTuRThZ/pBZ6ZyjEA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Gau9yVXuwFDUImqj5a2QJ7z+JtFUyD6X7NfiOt99DFJJl0x0ubV1+fw3c+UY0k8IU
	 3iUTUJdPc/YPaXMucggSVbccInyjw0T4WxjdaANHetMEcrVDkl3AWnoU0K292vYerr
	 vMsodfk4EwpHtGH6Shc2m0yIGa7eX5F3+v0QbZi69MBpiLa+Jh8NSqlXJRUFeRQhd6
	 CxgkxBOUuqFuajhblWIz9X8k0CDQrV/yoC/JHElL73vthR0umgKDWpdBD/ZSH7hZqX
	 yxYDXQPn9WfAYaKIfPChOEzGct46UmFq5KJFFPiQn6ULtKfshT5pUn46hcwdsl8wKC
	 f7VJaFaksDPHg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 14:44:06 +0100
Message-Id: <DFW0HVK6AF0G.TW6R157R8O27@kernel.org>
Subject: Re: [PATCH] gpio: omap: do not register driver in probe()
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <broonie@kernel.org>,
 <will@kernel.org>, <grygorii.strashko@ti.com>, <ssantosh@kernel.org>,
 <khilman@kernel.org>, <linusw@kernel.org>, <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260123133614.72586-1-dakr@kernel.org>
In-Reply-To: <20260123133614.72586-1-dakr@kernel.org>

On Fri Jan 23, 2026 at 2:31 PM CET, Danilo Krummrich wrote:
> However, for the purpose of avoiding the described potential deadlock in
> combination with commit dc23806a7c47 ("driver core: enforce device_lock f=
or
> driver_match_device()"), this patch only addresses the driver registratio=
n
> issue.

I.e. unless there are any concerns, I'd like to take this one through the
driver-core tree.
