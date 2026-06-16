Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FC36C9E5;
	Tue, 16 Jun 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632543; cv=none; b=Tn5o5iOQmZw5nCwPFof36cVfEQT0zux0X+UU/qAM2+WD7M/nilq50NIfWgzuBPM/LXd5yO6hAYv70DRo94bprBXPXIGiSVJQqs5VO62QxCbDn5vjOpkZ5Gtb/e7/ZdjXNvGrY01fJygRxcIqNTkAxmXgB48GKxYgANM7YzcQsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632543; c=relaxed/simple;
	bh=zdjSOMKnco/aG9kBqsfRo0Fz1Ss0AJGwwCFNcoS5sO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDw+ymc0JinO1ByQdf0EgqvBYvTx6qka38oItJv/KU7I0GUVwBXPxupVDpHOj+/aONfKyptVmlx30Mqf+azX+0SY+dmfguY8SSqIUOlwRXO8plYcQOXmz8zII9UFlR12T/5c1ctqO/IUBD2FGHcvRBP6jccznGpbqp3abG47kB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Bx5BJiPC; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Bx5BJiPC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=h6sdoHjnyX76h+7ZFTTASiFa/+YVl6v/E/uzSTt1+bA=; t=1781632542; x=1782842142; 
	b=Bx5BJiPCTgL1ktzvHI8BedmtMoZOS0o6tD5mx1uCNLa78XBSi1jlhf78+j1MAx3gWKTCWqzBthj
	VsB0k4uCJ1STQWmdvY4mbmgcYHE1C61DjZxSVmoEYQmKnL2xpOg5io/D2g+L4rs/6SbDliO1P4ALj
	LatJgoqFnWVP8MW7WofWvekZSxbSCqDRwdJzOBWs65JqvltpKYap5DBP5kYvBiMgXdZB7Un1wvGzZ
	qS2tsIIqONZPg+gikXC8QyqR7CNTStiBOemcm4elKXgnVsb51J109dv3m7IK4ZjPKpP0vep4xe1KL
	MZU9DrQypLLhaw2zuMEFw7hMBRKW4BzsCtDQ==;
Date: Tue, 16 Jun 2026 19:55:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] bus: ti-sysc: Fix /chosen node reference leak
Message-ID: <20260616195537.46810219@kemnade.info>
In-Reply-To: <20260615200540.770205-1-dbgh9129@gmail.com>
References: <20260615200540.770205-1-dbgh9129@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:05:40 -0400
Yuho Choi <dbgh9129@gmail.com> wrote:

> sysc_init_stdout_path() gets the /chosen node with
> of_find_node_by_path() to read stdout-path. The function then overwrites
> the local node pointer with the stdout-path lookup result, or exits on
> error, without dropping the /chosen reference.
> 
> Keep the /chosen node in a separate variable and put it after the
> stdout-path value has been used for the lookup. The successful stdout
> node lookup remains referenced by the cached stdout_path pointer.
> 
> Fixes: 3bb37c8e6e6a ("bus: ti-sysc: Handle stdout-path for debug console")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
