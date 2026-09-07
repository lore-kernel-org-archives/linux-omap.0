Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707752F1FDF;
	Mon,  7 Sep 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802733; cv=none; b=d40AqgAK2KxU7ndnMnJsBR4RtrtHpn7dbYZlbUQau4UfM57PXLdmV1rh29RMy59N/IoqC4NVkzxd7GaktJtp+keiza3HJdUrxgnVthVvHM1JOlPXTfRTo40ckDEkdbsOSEIDPI6zDvj9wmVncvT8iwKJAeZfoMV+bHQCMS3Fm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802733; c=relaxed/simple;
	bh=cwMC9G7gnwaXq64yEud4524UTE6Mb6KcXo34iuocqkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vnyd4A9oTVd3HrgNBUf7Z2BE4RFjJLznK7nEpQpoic1vZYtvTyKBcL59jQON9fN3GjcMA76VS7/hZIsN92KsPFaIL98Xgg08LqXVTJgxKy52f5tp06x4B8ymOwxB8iys/8DDXPvxZJGGTYVFScb53DPY72gyMHyc2MrzfAtF9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E79BYnA4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E79BYnA4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TOFA0MqUebHWi232H8eweG4EROiQZqrSU1VKpFmiZyk=; b=E79BYnA4tnCNFSPtUys8222Hrm
	j9DIHfNJqdB/f0sQdEpO2ACeMgcO0/lAIqB8tFzwXBiEbJbDSXnzrOiJTrooZ2OCTqfyY/S+RilOI
	67d/WqSBMcGXMHzjggvPbi6q/vZe09e0JSuLQ7uWMW4943q6dP8tzqb78Nz6dr7yXj+dTOKS2dQon
	pBeDcj0nxgZK7Wqe/WsHc0cmFBEW7YJM2VBykHCwRD5yT+Kn19w3MdRgHpnCQXChxmQ+yRfT5wmb0
	F3lNjwMpDx38pzQM3QxTmW382yL6oS+0SRkZYl/fcXEscFEuw93+SzZLDGJGKoCNV9WoYtRAVd+Ab
	gUtsrSMg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3dIu-00000007Vak-1Fe5;
	Mon, 07 Sep 2026 17:38:48 +0000
Message-ID: <0cc406f6-10b9-431b-a958-9b3713cf8acd@infradead.org>
Date: Mon, 7 Sep 2026 10:38:47 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] driver core: fix typos and repeated words in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Eduardo Valentin <edubezval@gmail.com>,
 Keerthy <j-keerthy@ti.com>, Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/26 11:47 PM, Hemanth Selam wrote:
> This corrects 5 misspellings and repeated words in comments.  Each is a
> separate patch so that any one of them can be dropped without touching
> the rest.
> 
> Nothing outside comments changes.  Every touched C file was checked by
> dropping its comments, replacing each string literal with a placeholder
> and collapsing whitespace; what remained was identical before and after,
> so the compiled code cannot differ.
> 
> The mistakes were found with scripts/checkpatch.pl against the list in
> scripts/spelling.txt.  The scanning, the edits and the changelogs were
> produced with Cursor running the claude-opus-5 model, from a request to
> find and fix spelling mistakes across the tree, and every correction was
> then re-checked by the comparison described above.  Words that name an
> identifier were left alone deliberately, even when they read as typos,
> because correcting the prose would make the comment disagree with the
> code it describes.
> 
> Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
> is clean.  Nothing else was built, so any patch touching code that
> x86_64 defconfig does not compile has been read but not compiled.
> 
> Hemanth Selam (5):
>   driver core: fix typo "sucessfully" in comment
>   thermal: fix typos in comments
>   tools/thermal: fix typo "binded" in comments
>   cpuidle: fix repeated word 'that' in comment
>   ACPI: NUMA: fix typo in log message
> 
>  drivers/acpi/numa/srat.c                    |  2 +-
>  drivers/base/power/clock_ops.c              |  2 +-
>  drivers/cpuidle/cpuidle-tegra.c             |  2 +-
>  drivers/thermal/thermal_core.c              |  2 +-
>  drivers/thermal/thermal_of.c                |  4 ++--
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 12 ++++++------
>  include/uapi/linux/thermal.h                |  8 ++++----
>  tools/thermal/tmon/sysfs.c                  |  2 +-
>  tools/thermal/tmon/tmon.h                   |  2 +-
>  tools/thermal/tmon/tui.c                    |  2 +-
>  10 files changed, 19 insertions(+), 19 deletions(-)
> 

For the series:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
