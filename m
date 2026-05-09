Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC5352C5B;
	Sat,  9 May 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778329692; cv=none; b=YLJz3mbg7noAHu2D6bJRQpktgFegkYKPHLGhKhWJg9aWWiF+RI4VETOxqL0qhDkclPyziPdHWLwBHQlohcotJFH0j9XrAq3yPZQoNbwtwg20mzPUcaFFlRw0ASS7n6M722IHZY1DA3+GYWyzKXL+WA1IRN3CFztyClFx9nn5F3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778329692; c=relaxed/simple;
	bh=enKnmKJG1BMhD0dmYdaG/Wqa5SthFvi94GWq2O+thlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlCY+YLmn/MLsdsSsGxKL3HDkte33+09viHD/4+0lTSlfLKsXKPbKDhyH0EOCM0oSJirc5DRKfGOXPsng+64FL2+xhp6GzVndXyI3/U7vgnOue+2srpAcPl73f4oToReU7G4nzBlditXoaFPipILeLR9xP6y6rA9v5v8HJt8DSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=nSajCUtY; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="nSajCUtY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FsqNm0bJmcwdEoLxZmUOsjZ+klKp3JNtbOBnMIyuc+I=; b=nSajCUtYsReTRJlWSm3/1aaR2R
	yU71e2fAOrG1O+NWaVFaR5hoXLIY5Qe2TRBsymorhNnVGObEBg4xF856RMqIC+At7UGzO9WqLnkFX
	YWpfaQlsfX3R5GJvYorTFjyQOe/0dHgzJhIpGEGUeza8C0qPetHmE5sBYa1I414x/kl/n3kIFprtG
	eOAUFmhK8ppqc8cFZtiAy7bgBCiywfK/VWF7JPK40rV2S/QMQm322BmiWnHLzuvrVHyhjX7EFlWn+
	ta7sQUUujLeZsaLXAWdlwU1/nbQLGOZ6v6LijVY7u90CGCgDJgJ/UKwv8cyOZkA86aHrV7P80borB
	LQC1n4WA==;
Received: from 81-197-209-194.elisa-laajakaista.fi ([81.197.209.194]:45264 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wLgmx-00000003TSB-3LRE;
	Sat, 09 May 2026 15:28:07 +0300
Message-ID: <7249653a-84d6-47f4-8aa4-2cc734c42b8e@bitmer.com>
Date: Sat, 9 May 2026 15:28:07 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ASoC: ti: Cleanup locking code using guard() helpers
To: phucduc.bui@gmail.com, peter.ujfalusi@gmail.com, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260508103837.138142-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitmer.com
X-Get-Message-Sender-Via: wp23.hostingpalvelu.fi: authenticated_id: jarkko.nikula@bitmer.com
X-Authenticated-Sender: wp23.hostingpalvelu.fi: jarkko.nikula@bitmer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 08/05/2026 1:38 pm, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Hi all,
>
> This series converts mutex and spinlock handling in TI ASoC drivers
> to use guard() helpers.
>
> Most patches are straightforward conversions to guard() helpers.
> Two patches include minor cleanup changes in the process:
>
> omap-dmic: Simplified omap_dmic_dai_startup() by removing the
> temporary return variable and using a direct return path on error.
>
> omap-mcbsp: Modernized omap_mcbsp_request() by using __free(kfree) 
> for memory management. This ensures that memory is always freed on 
> error paths after the spinlock is released, without needing manual 
> goto labels.
>
> No behavior change intended.
For this set + Tested-by tags for the patches 6 and 7:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
