Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C882E401
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009261; cv=none; b=EAbTmlAuaUXh1ARS4bHBmWEDVh67Y7ZatyCE1l4sDq1L1qpWmwZM8CFaZ2JGFo1Jh0Js5QKbyIGKpKnw0klVQiFmyiUzOlJVMQvUOwQxOcS/CMVQqImx56PXEXYRDxR0AIEctKszZDRo3H9tYiJbzEK7fTTBqA8OFS8I43UilOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009261; c=relaxed/simple;
	bh=5z7j4OzTHPgUpynvi7uFq0cr8kPfrW8/dszklOi3nVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsDVtH1Gx8Xd6S3racbgbYU+DSnJnv9f/uYFHNANIIvdTbBMI0Tn6CtJ5OJRuZM0hexVNl34dvD4FvpYifoao7eDgJwyJ0McNm1fe6/4yl+ZIHcoH1L/JWe/2pNCwt3yrrmDs+BFvkgOl2FvMldpzxRD9EhkOIcGEWRwpstEiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJjO8WgD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJjO8WgD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso1484965e9.0
        for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2026 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771009259; x=1771614059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sapC28wGLkNp2EIPovx9wYrvEx8pCtzRMVnlm/Q5eK0=;
        b=kJjO8WgDD28p3HGclLhpCFpmNhQzVF1El2ox7h4SyzNGec0padrgCHqtTKW7hwTvvN
         0+EmvQPQ3UpELgKaMAAgFfVg+fGoXH62Tvo/9hNjz8IPwMiwqGlBLYGUoM7jrOKxxJWb
         JbQVpb6TRwXTmEEQKB7ldvkpj2W3fHj1GqgajrSHJ0xVo2NhXaoPGE622eeBgmAvZ5Fr
         kcWytC4zQxBLXLmMutam2Ehx1Ocu9oWlawpu7NRBAnv7I88tRzMPd8euUTtYNr75zzOe
         0YRzU1TUZhkZVgtBXCsdwJp5KOaZ58/hRDU+z+zgsvgYFRgC1ZDBQC+td+PAvHgII9RA
         4ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009259; x=1771614059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sapC28wGLkNp2EIPovx9wYrvEx8pCtzRMVnlm/Q5eK0=;
        b=D1EPHoJ83Fy/zDCkWZar4AkPTb9dag/dJ+nW0sawIbjVbQtI38a5KsmmkRGnsLlYAg
         MtkMwTsbsokJ/pKuQOQRKMLYCdfdTLa+qx/+wlEcY69WsEdJg+m8g1UI4AseNdRYqfUy
         oNYWL41fSDl9m8TfzQGNqIkybiL/64btuUpuCLcQl40Tzu+Q2CgwXrdfTVt+7pqm0wKP
         qAJ5U2c8ccqS00yXNbY1/Ug7+GoMySMckR8AgpWSshwRAJHLMdZvwp4TUl9UPGpIDpuF
         8NtkVewlaFHgQtJmADQuDwtSVaR9ejsVd6FdVoDDtL2RJNQe3ORzCG6VfH/fbkICipRU
         zEng==
X-Forwarded-Encrypted: i=1; AJvYcCWX8TFeA2hU1Sg8/8z/Y2ReE4a4u8tl90bwmSGZl+fIJ4/Wfmdn9Pk9YSvQnRKJ37BmWLOYbXI7Aqqr@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjvnQs2GFrC76O01ER0HPcWEaRqWoRamSzrVGiInpITwC5uJz
	lygSsT6PpvaOf/WrclKIwOu/aDtNU5tiv86G8l0aM1dDWvmWHj3CtHR8GoCOCg==
X-Gm-Gg: AZuq6aKlYrQgR/M0gbDNiV+cd/DKzwKe6/eL2J8sqS7YhJ1lYQB4cOo9Ea/mlc19fZm
	8qYe3g1Zp2bMMXhVkqq4LtjHd2epDdFIIYMt5msOjox2cOAY+RSXKhzzatBhOgVOZXisQTpA8aO
	xScMYbrRn2FhOpBr5FEKkvi2MxnSVym5XfxIhjyvbp7QiZFvfTiOST6h5QmTtEruVTdpES9/Kyg
	3YKdYneQCi3Im/g1KugCrzfckeXyCb5RX0wasgy3e6jmETwXB14+vUQW56OlAYtsZQmSFGp2oSS
	g36JDkzpC/XkpfgKLOFAergbgOCkUd7VKTg3L6PDTjeiwf8qUuxNBbPoTpy+pBdZvvo1syUHtaH
	MDjcvwaUtt6cgOQlsuV9GmSmtI2WsU27L7P67LvTGSYUtDHLSYYjtij8h0f/5VMz27uzc6XsDsj
	HS9KbbRUJYcSGIWyF/fG+sIN4VFw==
X-Received: by 2002:a05:600c:474a:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-48370cce47cmr34850165e9.0.1771009258323;
        Fri, 13 Feb 2026 11:00:58 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:34e8:30f1:fec3:9b0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b2d1sm8491744f8f.4.2026.02.13.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:00:57 -0800 (PST)
Date: Fri, 13 Feb 2026 21:00:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/3] dt-bindings: phy: Convert TI OMAP
 control and PIPE3 PHY to DT schema
Message-ID: <20260213190054.ezblztj3blmhtywr@skbuf>
References: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
 <177021985530.133434.13436195442562231016.b4-ty@kernel.org>
 <f60156a6-58af-4548-9dc3-71c71b822343@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60156a6-58af-4548-9dc3-71c71b822343@gmail.com>

Hi Charan,

On Fri, Feb 13, 2026 at 10:06:16PM +0530, Charan Pedumuru wrote:
> On 04-02-2026 21:14, Vinod Koul wrote:
> > 
> > On Fri, 23 Jan 2026 15:39:01 +0000, Charan Pedumuru wrote:
> >> This series converts the old text-based DeviceTree bindings for TI OMAP
> >> Control PHY and TI PIPE3 PHY to modern JSON-schema (YAML) format.
> >>
> >>
> > 
> > Applied, thanks!
> > 
> > [2/3] dt-bindings: phy: ti,phy-usb3: convert to DT schema
> >       commit: 62c9ff8fc20d23c0dc36be1330734fdafb3e8585
> > [3/3] dt-bindings: phy: ti,control-phy-otghs: convert to DT schema
> >       commit: 7878306d182a1750583a325a29e5ccab9ce0235b
> 
> Hi Vinod,
> 
> You missed to apply the first patch which has DT node pattern changes
> and now this dtb check fails in linux-next as these YAML patches use
> the updated node pattern. I got a report of errors from kernel test
> robot.

If there was any request formulated to Vinod to pick up patch 1, then I
also missed it while reading this series.

Usually, dt-bindings patches are picked up by the subsystem maintainer
while DTS patches are picked up by the platform maintainer. If you know
that there is any dependency then it would greatly help if you could
mention that upfront, or even specify how you expect the patches to be
merged.

In this case, I expect the warnings will get eventually resolved when
Kevin picks up patch 1.

To avoid warnings from being introduced in the first place, you could
have
- requested all patches to be taken through a single tree (requires
  maintainer coordination with ACK from the other one, more complicated
  if the files touched are under heavy development)
- requested a stable tag from the first maintainer, to be pulled in the
  second tree
- send patch 1, wait for a merge window to pass, send patches 2-3
