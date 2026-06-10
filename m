Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C23D8918
	for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125944; cv=pass; b=dNFU7P1UMGpXnnHBThfeeNYNqkitbDetzOje3jST/8yw39fpmcAU05JI/WPer6C1X9W+FMDMr4MjaSDnIjPhmPrxwaHvRQ6l7bgzE5UXlBw9ecXs9tKNmX1OGRfxwyBdMWjfCTT+Mw2HIzoc78tVtb3EEOfAwSlpp8g24eZwvMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125944; c=relaxed/simple;
	bh=7GakpWUTN+DvvDPX+8K92QKUEmgH/oZfFMnDt02q+8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1Geqxr3v7TtZwd3qlb9ihZMjsjiqzCjTzDgfS1IbMtUk8GslDom/TC1UENpHtuKBrJDYLCu1haCGrlN9GSV3NmS8Lp3Oy0rPYRj8OKDpijkAF/Hj2aBmd3B/qgyJWmppvTGPa3ms4RC3OuJ8C8lwKhxpjOf1U1wOwQiKo6j0ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxZoUS0T; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxZoUS0T"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68cebdc1723so1015787a12.1
        for <linux-omap@vger.kernel.org>; Wed, 10 Jun 2026 14:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125941; cv=none;
        d=google.com; s=arc-20240605;
        b=j/BGZf9yIowFN99XSY28pTuUEOadBS5avcLiW0uZGX+R1CsOZjfeJvvfo1w+x7vmO1
         0tjnXhMcry8vUNMHPv3WywdOkLEmi6GOGvb7fWDuRuSPT3lzE8K/mmvjS3tAumg5MoQ2
         8jZu3Sop18qiueqFg9w61M/UPQBZPTUo0WZu8SE/0UNZ/epwh6/sDeOwNBGHC3b+2j1T
         MaAviNyAD/yZ+X7+eFx4RIJT4oKSskW0i0wV/lw9uuz80oJl91ElQ9Rsrr8hnG+JPMzS
         Ewr/nb3CIK16Hvw2FS4WcD+WK1CZcLFWmE2/nACMB8qcWLvKBTdLySdyfwQ/hB3Z7Lr+
         0anA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NSQVbV6qKdOpMrqmgIPaXzJ8axK82K25SvobF+jZDw=;
        fh=eqviv85Bs6TlelU1eVIvmWmCLXdQJW0ik1wmnHdUUb4=;
        b=A5YYbF7R2EP3agVa+P6G07Wnw+XbhzkRH7GmG8T9wR8N7lgb3g+g+fCRYWO4BEXMaF
         WUHSHgjoxyIjcDdJcmyR2f2Mh7HpXMB5p3AQtF/HjMw258wYVMkNP0ceJLTQ2H1mjg74
         3ltJi+vcBzYtSy01dxflVL5sfqIbBIpZrmfENK3TwgjK4KjHo1oeH/faIf63h7AfrjhE
         rkfewLDj/mpnFGmDzZy7xMUPaeInQO2pt1wOeiPjZsS1//WQx9z81O4atb0/WZcZck9s
         vkWkqjL52ToSkSAQYC9GEPVnQ0GrmCa00iKqFFJbXRpUd9wL6yaw12FFYEzU3SFYUtr8
         jNaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125941; x=1781730741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NSQVbV6qKdOpMrqmgIPaXzJ8axK82K25SvobF+jZDw=;
        b=AxZoUS0TBGu3L3KucpFZpdsv2+pCvRmHS+sUqkj1voq+3r9i/VvVbpWJ6qHhDbfhii
         5TByRqyB/pWDKsf5cnuoCxtyg2Y4nrcSPMkQ2L+WUJCNITaZez8xsl4z0hR7iDa0AEge
         1L/OvZnlVKNt6sjzTJYpgPhGUdsYfHQIzoygDm/9/vyA6Ubp+5r3ImunUhmmfbhWfELb
         CgJxrR4AHL5nfVrVxmiqlJt7d/7TY2f2Lg+RiMBrbKwmPFVbtKAbk+yNTjjWKtTyaFJy
         Xw7ey7cDjAR1vrpDe+5GqgnZI7UwUWTVIP8CPOBbK/iAMiz/GYmZ5DxtVlExKYkSbsco
         Bbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125941; x=1781730741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NSQVbV6qKdOpMrqmgIPaXzJ8axK82K25SvobF+jZDw=;
        b=tS2zOSbn5FOIKT7/g8kD3h2zAUwtBxB5JCn6Zp+mwOnz+4K809sKHYfDvGPMt2F2ps
         sMfIUyUv+7Gqff3TshUstuRNKY3gbLFiuMpmXxam0guMP8UPkjLeowl4HOjAiMinNzpM
         Rb2TSUKR5BglUaLpdqYrBFkLtxJ/Hero0FWqJkunxBbpdVd0mQ+7Jf/VpcQzbCJE/SML
         IizHTzvjW6zmRXJZjqkhSPj07gADBriaXKKdkI7vs65PhFq/B7D9TehmGA3XPdzHGtTv
         Ws5mfAw6iTII+s3PRIf/JhAf0qUADJS/RXowtOfCeLiGXQ4VhtfUQQ6gWOxCeDovFIHL
         Ue0w==
X-Forwarded-Encrypted: i=1; AFNElJ+z2Ave6Qldg/q1XhcwXLFkhD9gIwmKCtq/GckcTVrNAlMYEjCGI7NDPP40eGfioi7qzOR1KzRrvTCE@vger.kernel.org
X-Gm-Message-State: AOJu0YxncZj95dJ1IYUeQZYCUZATfiLJ4znfLPlx9/0cfKpDkrkIbn7o
	/hlYpOYZfEjZWsJywoTwNUOI0ySTWcNBcq1EFj6+3gKMh+IamUG1wMiQYKDGKqZ0d3rltqX0tKY
	HaxpgGoUSU0AUtnJ9ocGUXTqwy1PEy7M=
X-Gm-Gg: Acq92OHYs2OBhSU1AZU5uWUP35p/9+frIyb/eQRZ5JO2NiiVBkAbSZCum8ijrIR4kT/
	QNwVnxIj2nQXivoylogeBfZTP3krZEFHBh6SZOdHhXm+D33xhIqJ4t84qYJQYv0RtUW+MjbYqjB
	g4Vjj3AXaFkgJQWVX7HzCWoqUsPoyb+rJEPPsnjnuON/CPwvOfB3YL8IgkBEMqpwcJd90b9t9Kv
	qd2iZ3C6pUpod9YmDG/NmaaeVJRUyhzjSRyBP9VAE7UgWZhN18Vx8BH8ngKIq1vSA9JCUe9S48K
	s+nBbTinKNW482oA4XKeqS373ltP+p1eW+LAAJ0ndS5hRBzwU5Go
X-Received: by 2002:a17:907:9405:b0:bcb:d018:30f with SMTP id
 a640c23a62f3a-bfc2fc83016mr10319266b.5.1781125940955; Wed, 10 Jun 2026
 14:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
 <20260606-crossbar-v1-1-f67f7cb9ee50@gmail.com> <20260610195658.GA702518-robh@kernel.org>
In-Reply-To: <20260610195658.GA702518-robh@kernel.org>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Thu, 11 Jun 2026 02:42:09 +0530
X-Gm-Features: AVVi8CfDeCrjalrRCyX2-0XZyrBQzRMMTBze-qG9_UentJXs_J_WCBPjfHZhG-g
Message-ID: <CAOWyW_4kRcZWCyOjJrWvnZ8meKT-ryJuGozuPvKJgPSUStB3Pg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: ti,irq-crossbar:
 Convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sricharan R <r.sricharan@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
	daniel.baluta@gmail.com, simona.toaca@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 11, 2026 at 1:27=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Sat, Jun 06, 2026 at 02:26:10AM +0530, Bhargav Joshi wrote:
> > Convert TI irq-crossbar binding from text format to DT schema.
> >
> > As part of conversion following changes are made:
> >  - Add '#interrupt-cells' as a required property which was missing in
> >    text binding
> >  - As irq-crossbar is interrupt-controller. Move binding from
> >    bindings/arm/omap to bindings/interrupt-controller
> >  - property ti,irqs-reserved is defined and used as a array but other
> >    binding ti,pruss-intc.yaml uses same property name as a unit8 bitmas=
k
> >    which causes erros in dt_binding_check. Update ti,irqs-reserved
> >    property name to ti,crossbar-irqs-reserved to resolve duplicate nami=
ng.
>
> Defining a new property breaks the ABI. We will need to fix dtschema to
> handle it. What's the error?
property irqs-reserved is defined in two bindings with different types whic=
h
causes dt_binding_check to raise following errors:
  - File "/lib/python3.14/site-packages/dtschema/validator.py", line
522, in check_duplicate_property_types
  - print(f"{self.schemas[sch_id]['$filename']}: {p}: multiple
incompatible types: {v['type']}", file=3Dsys.stderr)
  - KeyError: 'http://devicetree.org/schemas/interrupt-controller/ti,pruss-=
intc.yaml#'
dtschema version: 2026.4
>
> Rob

Best Regards,
Bhargav
