Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECE24634F;
	Mon,  2 Mar 2026 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482657; cv=none; b=twVqCcXfMrsvwCGCeNWM817RmuXAO0kXsUoeEAGypRFZxP5UPExbM07R8bJ8qnsEe7kGUqV4+ZU5lVVcrAo5jDhc8Lf+nHxXzg9YjQl8bxe/d7lul3pq31eHI0qlSRmZNL1h5tJp2pYX6JNLkQAouteTGYcUcdoBU7BKfR/UkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482657; c=relaxed/simple;
	bh=Izhfx7NCscbbDkD/cKpFpegVES/+oPeLbYegJaqUVJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS4PgdagtLqYW8gcMR0dC/Jg4rRyzjPJgPE2pK4m0EnreEUTifDthB7NC8A8U9pLGSt8KQlSiB9zAISVRAB90M5E3uzeij7iieu/oTdbpgljwc5DLPWxkFywrgwso6U68KK1KP7KY3L8VASaDvb0BzspopZuEYRB8wrTi05xg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=9lVX8Zya; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="9lVX8Zya"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C3kxPJEt4cJ8y1NMNMWFluFd1GagR7mhGNBFIBB9s88=; b=9lVX8ZyaYVe0yqHdn7z1QKTNbc
	1Il4c7rJn9R+9hGcDJipPGwCgFD6qCu+Pjv0SCZ6NG3hKWK/7fL40CY4TwEH6Ufg/IaQ9LzUzmvjO
	+dx+3Gk275QOV3+8XPNZBw4Q+l8VZaLn97q25fL0xkDjYfOe0FJ2fk4/t6kTXb1mjmXXk2ZcC9wxT
	pwRgND9gSKApUjpltQ2DVcRDMVBlVkDFsMY5IiCkyphwY19CDGymRSxl1cqdnXEETpAhZ8x2bSCH/
	FdkJ59XF0wlgvtoRbUPKj7JbZfEUtmhsxl3a2kWBEdXbrU38HraJ3C1kn1SWouIKp6PZdgtZjs8TY
	XjlXt2PQ==;
Date: Mon, 2 Mar 2026 21:16:13 +0100
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
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 3/8] dt-bindings: display: bridge: lvds-codec: add
 doestek,dtc34lm85am
Message-ID: <20260302211613.3d272218@kemnade.info>
In-Reply-To: <20260223134941.427-4-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
	<20260223134941.427-4-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 08:49:35 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Add compatible strings for the Doestek DTC34LM85AM Flat Panel Display
> Transmitter
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
does not apply anymore. Trivial rebase is needed.

Regards,
Andreas
