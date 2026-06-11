Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1698367B9E
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2026 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163603; cv=pass; b=enEUPefW5JmvoquxeHrA95dLKrBuNQS61UvAz5CmoEYZVSb9dqAJ/d9VPNrNF9gI1BFEY2FLWu15FPNEjsYSgFLwlkv9LgIB6OgI50JCzQcliBEvYlpJVqnnftL2N8YzlS+77eWEXtanAnJtCNeb8JDJI96972lKQ4u73aW+gbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163603; c=relaxed/simple;
	bh=DqwtAUZefULDn81NhMEIAultwLucsCv4pBvCaZeWSkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ+Kedq7Tn4VpvVSpgY7CBB6RGoj5GmhwNuSbVaYOxQfS3Ror/Frvz+OckxuwChYCO+Gqe4GqMD5xy2pX8OlSHN1zki2C7BpyAJarMEg85NmjltaI5ZV8oRIpFMZLYly1pRhXn+iE7ZpWQgPIOeHRspodUjOhPLCF0utrrM2pmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGwr25bE; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGwr25bE"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68bd4aec7b0so1279571a12.0
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2026 00:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781163600; cv=none;
        d=google.com; s=arc-20240605;
        b=FZR/dvuz6G2YHB4syyXfL1nPC37BEmEfZt83burUDeQ22JCGYXSmipL3QjWiflcmQW
         LlVIVRvFB6OK/o0Arlg7k3cfQZ197VVJ9J4eGYbqO/xNY7GZ9wVCgIoSUnrmbBksB6Ff
         hHVVOSsAPqA2HZx5BSu1AufUdlquwoB1BhFkylWWlEbzyi95aWMtvIQAdTR3O2zIL/cy
         X2jm+RQVPbSZXMv0Hao7rAFdqFxV28zmLYOvFGleJdtyb3TpP7LBE72SBs8CAXM61/0a
         xJI3kiiebF0Sf6hov1m5YPHKhb8j7FJBAp4utwMjcH6Ff1OhqUd658mGv2WgOveqU4o4
         PsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcLbt0g9UahGsRa1yZT+w5QDURoUxnNAFREsUy8fM3s=;
        fh=AUrL2zNPIrRoBbkuL2wMcMbm6jqv+Zf6uJCV/g/8/9k=;
        b=buqPH1xbJBIkcGyH9KTXsjbqNQHvpRJyWl5K+RuO+Zl8k1zFy9qyVPwCezGv9xwokz
         vvcsMsH99TnBTLfWSLs2rVmYEDxW4Xyt5bfU+uPmaqn1B4bJLT3HUUR3WkZNgKD4v7Pu
         /qTmQTe59p8XCmc0GMMnFpZQnEZGCXWz9ENfRSNtb3Jy7plSy3E/spGrAC0jcPdx1Xrn
         vQKosWTmMQYnWzbTtL5vrebhu0a02eNrf6nMbhliEEkyVALVGSUPMhi5/WAa+DYT15I5
         9KkZ04XukbR3wgETpPn/gZvMDfAQwFnPDa3CpwFRrCqOpAh024PHYK1Y6CNLWBC+b+qu
         ytKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781163600; x=1781768400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcLbt0g9UahGsRa1yZT+w5QDURoUxnNAFREsUy8fM3s=;
        b=rGwr25bEjq034cRetv3QNx/Z3kznfzQ7mmzSFoASBMG3S8oExo0LYmB4FyBdtJqJga
         wvYCD8iBaWAQwKbYOeEsh9EOhFVachPB//wrLLYIq0N40LjKZlqI6ZtsGwdl3BaEvn2q
         wWXDA45Mpm9SXchaqPTtfnEZYV1/y2WX4kpW/9BdDv1oJqzDWO9P/HKv9OmlRjIgXtLl
         fmMVslqKcFIPoyk89CkHaEq+EFWvEctTTZyINliDCImDDeEuspozC5WgiRggTKFgQBuh
         alfMH1RxuZ9dWIK44Ss4BgEaXPsXlujxoEIVVi+el3azvkL1xr/QfsURz6A5DBw8smy3
         ceQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163600; x=1781768400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcLbt0g9UahGsRa1yZT+w5QDURoUxnNAFREsUy8fM3s=;
        b=eutWJUW+5fVABdPj+WG7/3Z6zSHG5nC1oTTRtAmnt7MWMRgiqJEXEucGz+tj/dGzt9
         mWFYAOTFQsh6mJF8b7rbS/qLDn8lTAxU1wz+dXaygSAxsv/lTEFO3kN4Q2Ob7UPawuLM
         fMOQpnLOrX0x6hLJ/jIql7ZbAx8nOciHrYva9VoqCLlFlD6bUS9XqQZY/jS2dAi7p/lF
         xOlC1rrvr+PsWFsupUMBwBkl9HNowD854F3B1v/mBcd0oHLZHYg9feQvyQlJ5pSm7ce/
         F2FxgEzH0d/eih2KldP8GHc3KI4dHjrcogcPapUgx7xFc1fSafWUcJ7OWZw90mWmz/D2
         NV2w==
X-Forwarded-Encrypted: i=1; AFNElJ/bwPr5/ZbnsRSb2fJe0WBuJkc+0Hnakkjjrup30KkjxcDN3ZHUtevel7xZ/Nww2VzsWNHkM23Z2MQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrEVWYiFPfDamn1N7pH1eLEyRFg4vVIYbr6YZQAR1X416mtZz
	WJimJcgZCHxatk1BKSZhJwiVJcMsI12esDgtEQzFGDR3e4ST0FNVw/pSGzcQYH67evgdZvrl4Fb
	IkTDacuaqTyeFqa3Jm2kwtXOYRdP9pXQ=
X-Gm-Gg: Acq92OFh0TsfCs0XzTXf27wlxbOF6kDPwA5tLs9TQGV0fkCd1Tq/LPyGG9UKrYUf/fo
	KYvNIQIwLUsBxISTQ8FjejnZk6zss+NhjVAv8oSpD28+wRO6cXA7RltGvUgy5ZFPfjimdn6Ej0T
	TXkm1DyR+CS2DcO+j6rON/IxMg02j5b0Q6ALYA17/LStviFzkvBs6/y/zOUsOEdVjUH7O4tr9PE
	/OqVquH6lzDyrgwmwLUSQSsRxre2q8myOqiwAB2kaO+H17JUjPL98JbbHGvb22NjBihBiSv0qB+
	oUyptvb4kiPomzj04Roeyu2ET+Hnko7r4ksTLcvHcUFZnuxDDy+V
X-Received: by 2002:a05:6402:388a:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6930e27297cmr366088a12.2.1781163600105; Thu, 11 Jun 2026
 00:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
 <20260606-crossbar-v1-1-f67f7cb9ee50@gmail.com> <20260610195658.GA702518-robh@kernel.org>
 <CAOWyW_4kRcZWCyOjJrWvnZ8meKT-ryJuGozuPvKJgPSUStB3Pg@mail.gmail.com> <CAL_Jsq+G83JxXLCL+4jhjTsTKpDSqNde=X2Yzjsg+VSS2iGxtw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+G83JxXLCL+4jhjTsTKpDSqNde=X2Yzjsg+VSS2iGxtw@mail.gmail.com>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Thu, 11 Jun 2026 13:09:48 +0530
X-Gm-Features: AVVi8CdnUt3uOjKqkJfLs6WOn0yxwHv2m9rjL3Rv0loY7VpF5HQWmcaa5aK8fcg
Message-ID: <CAOWyW_7L46_MdPGHHrVzdsVKugXnBuXm8qkWE4sUHf-vi7WP=w@mail.gmail.com>
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

On Thu, Jun 11, 2026 at 4:32=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Jun 10, 2026 at 4:12=E2=80=AFPM Bhargav Joshi <j.bhargav.u@gmail.=
com> wrote:
> >
> > Hi,
> >
> > On Thu, Jun 11, 2026 at 1:27=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Sat, Jun 06, 2026 at 02:26:10AM +0530, Bhargav Joshi wrote:
> > > > Convert TI irq-crossbar binding from text format to DT schema.
> > > >
> > > > As part of conversion following changes are made:
> > > >  - Add '#interrupt-cells' as a required property which was missing =
in
> > > >    text binding
> > > >  - As irq-crossbar is interrupt-controller. Move binding from
> > > >    bindings/arm/omap to bindings/interrupt-controller
> > > >  - property ti,irqs-reserved is defined and used as a array but oth=
er
> > > >    binding ti,pruss-intc.yaml uses same property name as a unit8 bi=
tmask
> > > >    which causes erros in dt_binding_check. Update ti,irqs-reserved
> > > >    property name to ti,crossbar-irqs-reserved to resolve duplicate =
naming.
> > >
> > > Defining a new property breaks the ABI. We will need to fix dtschema =
to
> > > handle it. What's the error?
> > property irqs-reserved is defined in two bindings with different types =
which
> > causes dt_binding_check to raise following errors:
> >   - File "/lib/python3.14/site-packages/dtschema/validator.py", line
> > 522, in check_duplicate_property_types
> >   - print(f"{self.schemas[sch_id]['$filename']}: {p}: multiple
> > incompatible types: {v['type']}", file=3Dsys.stderr)
> >   - KeyError: 'http://devicetree.org/schemas/interrupt-controller/ti,pr=
uss-intc.yaml#'
> > dtschema version: 2026.4
>
> I pushed a change to dtschema main branch which should fix this.
Thanks, error resolved on 2026.5.dev11+g0d16008e3 , I'll send v2 without th=
e
property name change.
>
> Rob

Best Regards,
Bhargav
