Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD238C400;
	Tue,  3 Mar 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572117; cv=none; b=axtFenFd91z3ANfQ4mup3p0aOwmphNNg08r+52/GLlfvPji5I+LEcAcr+NnFEmJJQ8/Zro1uKYy+V4xbqFE+5mPlOjKpkumDbCXhO7id24L+B3V32RYFe4LSnWiqYNWebunJVYGcyq9L4W5azILhPoaXi/jKLKsp8xLPybNE05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572117; c=relaxed/simple;
	bh=niJe4TAD3KcisdFG5W1RaZhkc/dd5Y0JgAllfs62j8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc1WCDGG4ttITcI8f+EExCkaYJ7SXx7rmdzczAoXAkE/8vQ8xDDUIyxLJzU35KNRsXYFOg+1wBgNNO9AKBuDLeHidQ3NOEe+i+uqKbv6pgZkvwwa91s8ePShblQ2Y5qGuL3Azc34flyxk3GLQ22qpj5je+GXOTBRTZNGAV7Zek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ZGgkwcyj; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ZGgkwcyj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TVTPBO1ETB+TbDU3IdtAxLv4+MUduDzo1X9SkDOAYoo=; b=ZGgkwcyj3oNZe0jPuSP6JdXLpJ
	rx+NPQUmBlMYvL4qKtX9KkNKZCdxIOpXX7pQY6DNqp8MPaIg1bLyHunlZcgJiraae0kujQuIxScm4
	JNOqiLAH1mvo3DuV0ql+LTOQTXV+XFB1nHs3urQYEC7hL60f05o+OxjN1zpQ0vt7mVvqFSfk+AaE0
	d9uMUZ8h9ANiWrTNdeMNaAS0MBgUOO6cdeU/5o6OgzOvr8fJWU824EDqiA9Hw4gLLgRH3tChco2nu
	oqXaGuD27chMIdU8G1J8qWVC0O/uBTqOxIjYFNYwxwCjc3FYzfweW98j8LPRTsmTjupagJBAyyLGB
	u4+XiNvg==;
Date: Tue, 3 Mar 2026 22:08:24 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Mithil Bavishi <bavishimithil@gmail.com>
Cc: aaro.koskinen@iki.fi, airlied@gmail.com, conor+dt@kernel.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, khilman@baylibre.com,
 krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jesszhan0024@gmail.com, rfoss@kernel.org, robh@kernel.org,
 rogerq@kernel.org, simona@ffwll.ch, thierry.reding@gmail.com,
 tony@atomide.com, tzimmermann@suse.de, andrzej.hajda@intel.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v9 6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0
 and 10.1
Message-ID: <20260303220824.334f7965@kemnade.info>
In-Reply-To: <20260303203017.511-7-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
	<20260303203017.511-7-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 15:30:15 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Add samsung-espresso7 codename for the 7 inch variant
> Add samsung-espresso10 codename for the 10 inch variant
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
