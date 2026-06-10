Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF281217659
	for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2026 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132523; cv=none; b=HO/4g8BfGKy2U3obsBuxr4Qrv7f7TFV+DNjMbgCSdNqShO0ZvsT3iQaBlOg5Eh5bRPCW+0fHJGWdpgs3z2VWXOwvpkj3/JpGeuGr3IQCCHk/aNxThOltQXDQLu51INREh1rmG1GCbtQs2fkbpzJTddX2ePy8c63qV6CpWX7KWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132523; c=relaxed/simple;
	bh=FooB85FN0eEaIGhjHVGfQM2seucuYsmIQfrk/8uXAZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/D9NYcOdjUowEM5yuhuHodvOZLzZIomaHAj0iU/ZzEcX6cTajjmAPppNdQrNMqH6jzb4znRGr2gZqcMG47uy6S0MsF2TYBh+nfbtBHK2NrVZ/w9PD5Blk64A30L/x0qXo1Ng1i4MCSLoeB9KNiVBs3jQK76osFA8PtispcYCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zcuti8m4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zcuti8m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3C61F0089E
	for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2026 23:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781132522;
	bh=VjAZ4+QycwjZawI5GowYZjIjW6ZtWHV+9RmG2eokDHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zcuti8m4wWEgnmklLh3I9xKGHVZyPPOaT7Zw/4m7zC4kI+yk+GiOHjfPtawzckkkv
	 hDHu6CF/dFK/u2JZ0Ogz5n5YQYU3tNKsiwgTlQxlycIOQJo6BCOPcqNBbLBtpvmce6
	 ehVPtyyc1UI78FRPuDRjb5YF5zPAEk2zxiKgah2jypVKioUCEGeEbsfNx7vC50gxFp
	 K7/Q0XO5fERmwgmm5hz80xpc/C4Wm37PKAGjwcP1YkVg3bORVeTNH01k5JuWvGlWA2
	 sH2quZZhUT60lf9TdShbhYl7RWPWz8SQvERJpWm5w59qY6SlIqY843HzIHjvDEoNxN
	 qZ5DgMs3C+zLw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso1474915166b.3
        for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2026 16:02:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8rf7w0Uhwh/643gMuUHr/UUgRFGbFFLiDuHHqJPKDxrKgLd+ld5Hd9GgeQw1l4zA0VEe4BDFPecfjV@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUojQjLXFydX+04es3T418FvtgaMidBoqUmJd8iLe5X2vM5wH
	PmrPrLoLbu8GLGNNo4g8sWjHCL4Lv79weCl1+Nyy4KB695Y0jymP7VK2+DOeSRLMx1sNHM57C6U
	+rmdA3h300liZlDSlvpxnueYdAHUXUA==
X-Received: by 2002:a17:907:c0e:b0:bee:e07:3f0e with SMTP id
 a640c23a62f3a-bfc2a1b623cmr48151566b.2.1781132520885; Wed, 10 Jun 2026
 16:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
 <20260606-crossbar-v1-1-f67f7cb9ee50@gmail.com> <20260610195658.GA702518-robh@kernel.org>
 <CAOWyW_4kRcZWCyOjJrWvnZ8meKT-ryJuGozuPvKJgPSUStB3Pg@mail.gmail.com>
In-Reply-To: <CAOWyW_4kRcZWCyOjJrWvnZ8meKT-ryJuGozuPvKJgPSUStB3Pg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jun 2026 18:01:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+G83JxXLCL+4jhjTsTKpDSqNde=X2Yzjsg+VSS2iGxtw@mail.gmail.com>
X-Gm-Features: AVVi8CcuDlvNMDlSr9wFuOfQAk8_fF0hNCin0y2m2BtAmxWkGcVgYjKrwkgPpMk
Message-ID: <CAL_Jsq+G83JxXLCL+4jhjTsTKpDSqNde=X2Yzjsg+VSS2iGxtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: ti,irq-crossbar:
 Convert to DT schema
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sricharan R <r.sricharan@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
	daniel.baluta@gmail.com, simona.toaca@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:12=E2=80=AFPM Bhargav Joshi <j.bhargav.u@gmail.co=
m> wrote:
>
> Hi,
>
> On Thu, Jun 11, 2026 at 1:27=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Sat, Jun 06, 2026 at 02:26:10AM +0530, Bhargav Joshi wrote:
> > > Convert TI irq-crossbar binding from text format to DT schema.
> > >
> > > As part of conversion following changes are made:
> > >  - Add '#interrupt-cells' as a required property which was missing in
> > >    text binding
> > >  - As irq-crossbar is interrupt-controller. Move binding from
> > >    bindings/arm/omap to bindings/interrupt-controller
> > >  - property ti,irqs-reserved is defined and used as a array but other
> > >    binding ti,pruss-intc.yaml uses same property name as a unit8 bitm=
ask
> > >    which causes erros in dt_binding_check. Update ti,irqs-reserved
> > >    property name to ti,crossbar-irqs-reserved to resolve duplicate na=
ming.
> >
> > Defining a new property breaks the ABI. We will need to fix dtschema to
> > handle it. What's the error?
> property irqs-reserved is defined in two bindings with different types wh=
ich
> causes dt_binding_check to raise following errors:
>   - File "/lib/python3.14/site-packages/dtschema/validator.py", line
> 522, in check_duplicate_property_types
>   - print(f"{self.schemas[sch_id]['$filename']}: {p}: multiple
> incompatible types: {v['type']}", file=3Dsys.stderr)
>   - KeyError: 'http://devicetree.org/schemas/interrupt-controller/ti,prus=
s-intc.yaml#'
> dtschema version: 2026.4

I pushed a change to dtschema main branch which should fix this.

Rob
