Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BB372696;
	Tue,  3 Mar 2026 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572444; cv=none; b=E1I8PVlFeYVRHuF4ihoEgih8HfDYgJYay4YZgieSR/2MuGIDFkjD9ZRuV7/nERsJ2EkEwF60iyQ5Z5N469pdlShARfEeCKXC8vkpC8w2O9D62jYn/kJQaZaaaNhLVzCZ3QQi1dtd1LxicPOcdq7g6subrACcysokoRoLeY3y/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572444; c=relaxed/simple;
	bh=3aGsr1O1v8Yfv19uXSqZY9N+X44Nud1v732j8+sc4NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuNuyH8Agh2LSpJVeTg4ZxEfPpyfaB7SSQ/yc2E6xcHaAYq8bfw4/v6iS4MAGW1cGsWzgrnDagVgHreWRaS2aUsEg4EMMC8yUESBeQlcGXzEcnTMikhxDgHjqLntqsGCPtMXBHfhSZCE9gEK3dM0qwVsLADKsUh5A4Lq7IPonhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HUnoudev; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HUnoudev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZozOu6mtqeOddWbGdXN0JVWY9/U7zgvGG6rUO/m8tNk=; b=HUnoudeven8R/m88IUoqubxF9j
	ExWXZstarBlHNFYQL8zqh+K27H8kW/agFw9Way6qBhv7MoazZ2uzsNSkWvoUBJZufCMB75gcCMOVy
	9D77AIYrZauDniGcme03LfJvD7IMKl6l66UXm2AfjouqzOr9dEkKqFgFX0aOZ5jxg4bR6gQ3x5RVN
	0LqoidvmbSkf/TA139jO+AXCBh7RKP4KrIz9ILYJh3Fa8NR18aWx2TX69POZBTQV63B8uo7hzh/ev
	9T0wkQlQi//EtrquXqt4YArS38ajkHhObqmcAFZZX5ZIl34KN+h0A0isq0uBh5lGE/WKsjnyhHLiE
	LLKs9OgA==;
Date: Tue, 3 Mar 2026 22:13:52 +0100
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
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v9 7/8] ARM: dts: ti: omap: samsung-espresso7: Add
 initial support for Galaxy Tab 2 7.0
Message-ID: <20260303221352.10f6df4c@kemnade.info>
In-Reply-To: <20260303203017.511-8-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
	<20260303203017.511-8-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 15:30:16 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Create a device tree for the 7 inch variants (P3100, P3110, P3113)
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
