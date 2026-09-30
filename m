Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D936B933;
	Wed, 30 Sep 2026 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746173; cv=none; b=ShNxiE042iET8nuAdNrM8n0UuMOH4yeueF81lqj7taJj/O6SQdVd6kf5aBIdKr2wU1cYevvtIUiZj8vStNGQ02wIsZ4CvhAFvhpULcZlsym8zZctXJPCbK5ykDrn6lbeEwwhWI+bH+mWIfkGo+Ek35UBGrTeYQobBf5c6Gp9VHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746173; c=relaxed/simple;
	bh=bb/h/G1KkoN/bGMe9foM1wamD1apmUQT9PDmReJcscw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tETVAIMtl+MfPod1NKvBsAgcKTpbEzqp5tLxYzDBHCGIpefnt0Fx7/2Vm0L/+FmLyfwcFDlHaUjErvEgh2EVmvQi0djIv3ik5YDcr4twp6AWVsZdUjjnQNkHFlXimxMs3JnGTN22jkM61zVw7cZVxQNtdXbOivPNUV0xvh49yrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oHRT/aAY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oHRT/aAY"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27513C24;
	Wed, 30 Sep 2026 07:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790746055;
	bh=bb/h/G1KkoN/bGMe9foM1wamD1apmUQT9PDmReJcscw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHRT/aAYwkWLSfPeJrODtyMplN4MehCOvHaktDFV3qtB7or8dg3khp+6AxKrWYONp
	 ATJGbNDPUdhNiEvFGaYqZVUXHURLOTsbCcQ87SQHCCVpDiHsp6gx3B/5wBhqOw58zN
	 4VKbWPhq33rnMcxSBbtlQo683jA5SFZQWiC1k1i8=
Date: Wed, 30 Sep 2026 08:29:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-omap@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Tony Lindgren <tony@atomide.com>, David Airlie <airlied@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti, tpd12s015: Convert to
 DT schema
Message-ID: <20260930052925.GA931211@killaraus.ideasonboard.com>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
 <20260916123210.107841-1-quchaosheng000406@163.com>
 <179028680032.1886779.12172352669683602550.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179028680032.1886779.12172352669683602550.robh@kernel.org>

On Thu, Sep 24, 2026 at 04:53:20PM -0500, Rob Herring (Arm) wrote:
> On Wed, 16 Sep 2026 20:32:09 +0800, Quchaosheng wrote:
> > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > 
> > The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> > and ESD protection circuitry. Document the two ports it exposes between
> > the HDMI transmitter and the connector.
> > 
> > The tpd12s016 is software compatible with the tpd12s015 and is listed as a
> > fallback compatible by am57xx-idk-common.dtsi, so accept it as a fallback
> > of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so a board
> > using the tpd12s016 must list both compatibles.
> > 
> > The gpios property takes the three CT CP HPD, LS OE and HPD GPIOs the
> > driver obtains through devm_gpiod_get_index(). omap5-igep0050.dts lists the
> > DDC SCL and SDA lines as two further entries, so allow up to five entries
> > and keep the property description focused on the ones the driver uses.
> > 
> > Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> > ---
> > v3:
> >  - gpios: allow up to five entries. v2 claimed that no in-tree board passes
> >    more than three, but omap5-igep0050.dts passes five: the three control/HPD
> >    lines plus the DDC SCL and SDA lines. The three-entry limit added in v2
> >    therefore broke dtbs_check for that board.
> > 
> > v2:
> >  - Reword the description: the TPD12S016 can only be used as a fallback of
> >    "ti,tpd12s015", because the driver matches on "ti,tpd12s015" alone.
> > 
> >  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
> >  .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

I don't think the binding is correct. The two additional GPIOs seem to
be a mistake in the DT source. There's no rationale in this patch to
explain why they're needed.

-- 
Regards,

Laurent Pinchart
