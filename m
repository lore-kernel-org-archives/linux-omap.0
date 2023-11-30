Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="k5bhQcCF"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44A1BF5;
	Thu, 30 Nov 2023 03:57:53 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 35D6A6034B;
	Thu, 30 Nov 2023 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701345472;
	bh=cP8eSb8jKdfgJGwJRQtVpwSbgMvX8Br+LyBBn0EHR2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5bhQcCF84gIRBBurvlXmR1Wd1qeBmSi7rLN8alTMxinFOjc5w366P8I0ANKE848L
	 ygNfVf/NSPZetc7k5tv03AqumVQhGrtVNqX/iZLeVard2oXoH2GCbBZTf5j3RnNFVv
	 d6irNYV8157bYt8oOrWtE6ctKiNZDX9Y1q0KVxgO6YgEhtYdd3yri63a3lLuBDQthZ
	 1UJRT1IdTDWSD/Mp25PVe5mctf+0FpdQ+Nx/9BKMAaej4O3iSBjkiEsHSFNyillvub
	 Dyl5H994hD7tui3n1AODZ4MMJ1WPQzLoZLCyJ5J/0nPTvTBeel2TCQ7RJZAccH7c4B
	 Cj8C+9IPmZDoQ==
Date: Thu, 30 Nov 2023 13:57:36 +0200
From: Tony Lindgren <tony@atomide.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: linux@armlinux.org.uk, ruslan.bilovol@ti.com,
	linux-omap@vger.kernel.org, kunwu.chan@hotmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix null pointer dereference and memory
 leak in omap_soc_device_init
Message-ID: <20231130115736.GB5169@atomide.com>
References: <20231123145237.609442-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123145237.609442-1-chentao@kylinos.cn>

* Kunwu Chan <chentao@kylinos.cn> [231123 16:53]:
> kasprintf() returns a pointer to dynamically allocated memory which can
> be NULL upon failure. When 'soc_dev_attr->family' is NULL,it'll trigger
> the null pointer dereference issue, such as in 'soc_info_show'.

Applying into fixes thanks.

Tony
