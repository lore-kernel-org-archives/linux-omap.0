Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF882E3382;
	Tue, 25 Mar 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912573; cv=none; b=DoyxOx4NjJWbaq8b0uCWs25Ev9la1vdVbOyVZPbAI3gFQ6tBeC70vip3gWHNDwPVFRAvrxG4Us1lqPjl1bb6a4wITKOYFj557IRG1HN+XBWbsPIs4dkBVbzyagCgqpa4TNII9mXBsHfn+qjupwxrySBgvQ9phFAH6Kd16hseDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912573; c=relaxed/simple;
	bh=cIosO7of3lmdJBxKDMDl6BY2Xb4nfrwmCYSOZUUVZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/vJyR98amysZAmaRvoEIBJJBERxuvok/j+eMzhBWf9qrJUQWPLkOBcyRi7rJx9vxTtbWZ4NG81wdlvllQStB+P7gG65mDIJQCYyI1+Bv6uoXbrKxrJ0H+aHopE4/pVbFUt8k9wH95NKyofJpfDkeShXtRVGgcN9FNlrwGdJWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRo+1BCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRo+1BCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ADEC4CEE4;
	Tue, 25 Mar 2025 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742912573;
	bh=cIosO7of3lmdJBxKDMDl6BY2Xb4nfrwmCYSOZUUVZrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRo+1BCsoMuf+3MNUTibh8AYQONGhGazbaigbkOV8jiO2gpTaFYPD0mvaks0i2z7G
	 PF3gZRCygUia9lxJfPAmlaZXnyb+3XMJWDvhKytPljvXL8cZEPPecmZvD9l2hchTgg
	 jj540yhMO2ZPjo3pxEPsaUuWd2hoyqhOQet3uAWbjU8ADuGEkD9/2r5cV/Qd6BoBYD
	 5NEr5RKc39YyRjs7fH5ylf333ePiW1AtzsTYfCrbaZbUkA+eJOhSvgv9Klyf/BTopp
	 ACYrMv9Z9SV3T8spW9t2FugSXfSC0IJSZ5BHwnBeUJvues849/iIaAaA7pW3ukFkF9
	 +CHH0sqxAWDlg==
Date: Tue, 25 Mar 2025 07:22:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, danishanwar@ti.com, srk@ti.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] net: ethernet: ti: cpsw_ale: add
 cpsw_ale_policer_set/clr_entry()
Message-ID: <20250325072244.58340f12@kernel.org>
In-Reply-To: <20250319-am65-cpsw-rx-class-v1-6-2bfded07490e@kernel.org>
References: <20250319-am65-cpsw-rx-class-v1-0-2bfded07490e@kernel.org>
	<20250319-am65-cpsw-rx-class-v1-6-2bfded07490e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 15:38:32 +0200 Roger Quadros wrote:
> +		ale_idx = cpsw_ale_add_ucast(ale, cfg->src_addr, HOST_PORT_NUM, ale_flags, 0);
> +		if (ale_idx < 0)
> +			return -ENOENT;
> +
> +		/* update policer entry */
> +		regmap_field_write(ale->fields[POL_SRC_INDEX], ale_idx);
> +		regmap_field_write(ale->fields[POL_SRC_MEN], 1);
> +	}
> +
> +	if (cfg->match_flags & CPSW_ALE_POLICER_MATCH_MACDST) {
> +		ale_idx = cpsw_ale_add_ucast(ale, cfg->dst_addr, HOST_PORT_NUM, ale_flags, 0);

Try to wrap at 80 chars if it doesn't impact code readability.

./scripts/checkpatch.pl --max-line-length=80 --strict  ...
