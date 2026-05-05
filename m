Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FF392C28
	for <linux-omap@vger.kernel.org>; Tue,  5 May 2026 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956329; cv=none; b=foeKkua/4yk6l5tnUqKkBjFxgEFynndHAVSmuy6+aU1gPsVNVp9yPItUIHZS6wC95qCGM4979E+kQK/w9x9HmbilH217Bb5yAiNhMPIqQcrcNC9ChnflMNhKBaUc5qCAcSZp1cfbX58tHxs5pdDmle64P5W7L0WsiVhQhqZwKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956329; c=relaxed/simple;
	bh=QlNQ1CHW07FnLlbPXvDmNwAFbmH5P+YPv/EZqeHbcAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWqULsaGbLKVDzNP4w28tAKc6/WxFG7zeCEpqTdBU2ww3T68/wSJPnZVMJ7t2Sqo4odotI7JATqw5L2rJZLv/cRndS0i+dIGuXdv3b3HLuJmMibWSuneqUPe7v8yXPtTY75S+Fu2cqX2JqWAv9WUF5zJof7Wb9HELgF1xdnEE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+bAjIEh; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+bAjIEh"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f0ad52830cso3284384eec.1
        for <linux-omap@vger.kernel.org>; Mon, 04 May 2026 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777956327; x=1778561127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc0Sy8vq6FNzAEiI6/Rmeu/zFs4QicwXo3tqvVWtkD8=;
        b=g+bAjIEhB1SaZf26lNKgGUzuHjpN5QKWnsNc+o+o61AHhQTaUm7dfpypcGplgRZGuo
         +/cVvSK4YzlrIZrTLnhg5vKPJPgC5uJzyzI8QUD3FJTzqWfcaUEXBLOe2FEMWROVSkGL
         ms6D5timZBcSAezIC9j9otElTJ7pMqTfkS9yjQQIxCAZQ7yjIvoIi2E8Osi5tFcJdZAx
         gSfYER3d7mrixvGSmLFchmmM1bAOQLJfrgJe77enSuycVmkodt/vT+tc/UtL6AnlGVoM
         Kw7ZVCWNI37ZQCzaG+9PwDDu7MZjWto2AdBMV09fwPuY1jrwLF9B7QQP+op0RGnqt1LN
         DmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956327; x=1778561127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc0Sy8vq6FNzAEiI6/Rmeu/zFs4QicwXo3tqvVWtkD8=;
        b=B2vRVraUB9sS0W0IrrWsBNVp3+RMXVw5OAATQZtG20ccuI56Ve7vfm+4e3hhxeoEC7
         695PI3uP3NChmLUAdKRsKx1hGIJ2kWfkfupUGj4LowAobZvm6bn2Sb8UdFpeY1BJTiZj
         1CuzCCKtDehEs1C6esH5KprUb+z3tTHzHwECsIiH6nGllOUYkttebvP3LnJh1IhdX3jY
         139KMXbLRDl6sHUGiZ9G9uQ6qjrC+lLtlILDGysjvUqt6AVEbWOjvhgnmnn25t8toEsX
         0Uut4tu73ulCCQiPwczCwZTsh13CKurUI9WKvOQhZGTr1Yh9a6zvcDdU7OtHernTB3La
         BC6w==
X-Forwarded-Encrypted: i=1; AFNElJ+buftgM8xzuT1u2xGld1l11Z41eBc4/fdi7Pk63dF1rS7ZdoChGE1iMCufjf76B6AUIe6yW7q2RziQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+Qp8uOfGfdm/RePM2BEsjdbHzC340LrNiqJD7uemRUdmA9ap
	33vG05OpK/balD+i73xJlTjoAPgK4d3d6geIEf7WG/SJRLnXsQhsukOQ
X-Gm-Gg: AeBDieusFrp3eVI/zy8GvYvhwt3+Amy3LoGDutQwKKDD+sbi35FdQSK1BeT6KP4UjbM
	kDJMki4CjFCZU23p0ZorHGSqaqnvJFQK/yiiGyJ6qy4h7IwKxAVOtTGO2TbvUSfsU8K3HnDSp85
	v7wsiS3KQXXTNAV6KVy9ec5rRoccpF5lbcBQtfcb3/ABY7ejQ923oc0DeFKk+9brzb0PSUfkawL
	uxMUnlQz4ktsDxaDbaoE0lPieaz6zuTzjV/6Bomr5HdRs1N8gdVXMBxA8jQYZ5SvMX14amxAA1J
	XIxkX62DC7RjvcWSG6YXwRxkRZhMJhpx7FNkAZ44tcWYcf4YIIbCF1dF1CFd2jhCj5JupSCAgws
	Gh2Qzua8+GFEqOdd0B0JaFiJQ7msMDEBGj9LLx3JjZdhkDmPyE2FPR0qNl1qG7VeFVfERLprbgX
	PbR6eePyoc6CWWxroNBvbdDbSf2j2OJeW2oD++R6OFRoD87f/0hkeHc314JAMUY86mpGcGtsOnO
	F0=
X-Received: by 2002:a05:7300:5b9e:b0:2cf:28e8:d784 with SMTP id 5a478bee46e88-2efb9c84f2emr4962937eec.19.1777956327189;
        Mon, 04 May 2026 21:45:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f3bf67cf8dsm3627254eec.6.2026.05.04.21.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:45:26 -0700 (PDT)
Date: Mon, 4 May 2026 21:45:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: ads7846 - restore half-duplex support
Message-ID: <afl1zxCOyzd-al-N@google.com>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-2-aaro.koskinen@iki.fi>
 <aeVu2-zlzl-fn1dN@google.com>
 <aeZ_M7jjisCExva8@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZ_M7jjisCExva8@darkstar.musicnaut.iki.fi>

On Mon, Apr 20, 2026 at 10:32:03PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Apr 19, 2026 at 05:13:56PM -0700, Dmitry Torokhov wrote:
> > > +static void ads7846_halfd_read_state(struct ads7846 *ts)
> > > +{
> > > +	struct ads7846_packet *packet = ts->packet;
> > > +	int msg_idx = 0;
> > > +
> > > +	packet->ignore = false;
> > > +
> > > +	while (msg_idx < ts->msg_count) {
> > > +		int error;
> > > +
> > > +		ads7846_wait_for_hsync(ts);
> > > +
> > > +		error = spi_sync(ts->spi, &ts->msg[msg_idx]);
> > > +		if (error) {
> > > +			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n",
> > > +					    error);
> > > +			packet->ignore = true;
> > > +			return;
> > 
> > Sashiko recommends trying to power down ADC on errors, what do you
> > think?
> 
> If we want to re-work error handling, then I guess it should be done the
> same way for both full and half-duplex modes, and belongs to a separate
> change set. This code has been in use quite a while, maybe 20 years,
> and I haven't seen those errors in real use anyway, and AFAIK there
> hasn't been any bug/problem reports by others either.
> 
> Maybe it wasn't so clearly stated in the commit message, but the patch
> just restores the old code verbatim that was working fine for half-duplex
> mode.

Fair enough, applied.

Thanks.

-- 
Dmitry
