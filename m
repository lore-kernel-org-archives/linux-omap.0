Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B83DA7C2;
	Fri, 24 Apr 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040964; cv=pass; b=TyIjsJugV/8185Pp5jzCFl6E4KE7kJ9SWCCNH6Hq6RUnsmVXlFw0yWph7VlvwAizteWfrnzwHZKwNKGQS7Np2E58hj7lZsOA2e/45G6sLW9QjsoCbKO4PCOWSTjNDKe8JGstDF2AD6odyAHlrkoj4qMTkyYSNRv+lIEv4p24bkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040964; c=relaxed/simple;
	bh=UF/fHOpKUtfD/18IuQaTa5NrsTDfEbDXOc7XpHFNzFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jECW6c1yjfo19YY/9P9xGN/xFYxn3mJ6oVyFExVB5Zlue4R2Ur6F0+Vd6Okd5hCvqBUus7POI6PSWxyC+qe2knvh5XILd5CPsuvNHrNV3DrxcxrdTNhMAqC46+DoWa/hv7CG65yIk60smFh4frmDKgh1XeY7MT5MGXMBk/EtiLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qwQDQBjb; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qwQDQBjb"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4g2FhV0LpYzyVM;
	Fri, 24 Apr 2026 17:29:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1777040954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fMwsQXgFs4m3qlLNw/toiRnwqncp8Y42U18B4PsNAg4=;
	b=qwQDQBjbWfJSCP4k7G61Rjqjz5S93y2pxCVCgJJMAvFvnxXBuz0YlKknaMW9VfkKbt69W/
	K/ObdL9OTXI/GY461SuhA+/6QauEbAQy7b9+kGjuWESWfhipltUDRYKYw+sJVSl2+vDiJ2
	11O44EB1xfkTAf667lve5+jDFiwipOM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1777040954;
	b=CYLYSXDdjVzW1pWXlVAiLaXM+8WRf6QjviIYHZws+qrlqZheRiEK62mNZNzXx1433Pi6LY
	X5BWAZue+UgNr5qoP6J/I3c0JNSZ/wLFJn/JFdHBlsZfd4WhMSnmnwJpzZIBdE/tGMoZ1S
	TALo4KrDjJvA6GktYIK5MOgboN+jxfA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1777040954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fMwsQXgFs4m3qlLNw/toiRnwqncp8Y42U18B4PsNAg4=;
	b=f/vpRq9glew7YhRu9hjMdTxVSB3WZJusL7De1c+MC3G0MhscPRs6eJ6jn9a1D1SHbLGGth
	2R8s2qwxB0cRybw/c7FhaeteUqGonoz+GzN3/oWfA4LC4N9CtLuwOrVjpaUdLDjxhhUpsZ
	HGkO/vTI52NDzOC0eMS2RObeONfpQbE=
Date: Fri, 24 Apr 2026 17:29:07 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Ginger <ginger.jzllee@gmail.com>
Cc: edubezval@gmail.com, j-keerthy@ti.com, linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] Potential deadlock bug in
 'drivers/thermal/ti-soc-thermal/ti-bandgap.c', between
 'ti_bandgap_write_counter()' and 'ti_bandgap_talert_irq_handler()'
Message-ID: <aet-M04R_R-Y0JHn@darkstar.musicnaut.iki.fi>
References: <CAGp+u1ZRvs6UJDRu1041mO93DsQvM1dkZ0CZRfEEsVBAVPvKig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp+u1ZRvs6UJDRu1041mO93DsQvM1dkZ0CZRfEEsVBAVPvKig@mail.gmail.com>

Hi,

On Fri, Apr 24, 2026 at 01:32:39PM +0800, Ginger wrote:
> Potential concurrent triggering executions:
> T0:
> ti_bandgap_talert_irq_handler [t1]
>         --> spin_lock(&bgp->lock); [t2]
> 
> T1:
> ti_bandgap_write_counter
>     --> spin_lock(&bgp->lock); [t0]
> 
> T1 does not disable hardware irqs in acquiring the spin lock. If T0
> (i.e., the hard irq context) occurs after T1 acquires the lock and
> both happen within the same CPU, then T0 will not proceed because it
> cannot hold the spin lock that has already been possessed by T1, yet
> T1 cannot proceed because the hard irq runs disables preempts.

It's a threaded interrupt.

A.
