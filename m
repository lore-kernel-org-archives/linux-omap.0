Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720E1EB3E;
	Wed,  5 Mar 2025 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138200; cv=none; b=XmlCEsq6FXrA0MWAQl4GSeIWRWOmTUv+OgCbT47bXBUQuWlgCLjvzgwadYU8An5abSleMR7FVUHbJmcgBfykTMllOb8Yh/cLxmfudLsvrdMt+8qzVAj/giQplHebr2Fm885D/LgWKQN3dTR5deeBpQplvDOCIpdf8xkFiYq+sQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138200; c=relaxed/simple;
	bh=NUZjngEXeYxpimSSSAeNij0pHTgmJHmkCNjSjzSFNuQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMU0O4HOdcDEV3AvI8zdaGTwnEAB9Jb1xrhmEXbWSiP6wr/Lrga5yn0yVwLRZgauiWXDDGtZ4vokOlKRjpPe5XRpfB/I8f1CT9pJGuP6BGVUYn3gaJiCM7oRGQgsolermTQNCPLqTZD9CCuR8j1+n60uCghQ28+fiWT1Gl6Rbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLG9cOuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLG9cOuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B783C4CEE5;
	Wed,  5 Mar 2025 01:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138200;
	bh=NUZjngEXeYxpimSSSAeNij0pHTgmJHmkCNjSjzSFNuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iLG9cOuIaakOlu2hRE21qWRn/jJ3pmZMSM0Bfz+5sVDC7R1DqW7AqGxuHmVHFozTg
	 dw0ol+06V34DiEAmIgpzOCuoQgRd2Wcaef7u5TJDIefX2+ZQlkCvm8dl2QO4ZrwUna
	 20g0+w3VceCixzTboaveBmAzXtisl5aP1HT75B9b4ZxcgRt1ZqWk1VATxcVv9lISF8
	 2xhyFZYx6pB+fuGxzcKvSIrO+Sxn4ucTGszeP+Ud/eDRs9dedMOW8UWatcUnLLefLe
	 Xtzgh8fqvPLJpwgkHlSAzKMMm+oU2K1YWNq2vmPM5PYxLoDba6+tj/ncDMslqwiviF
	 YRE62Vm7DZy5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7109C380CFEB;
	Wed,  5 Mar 2025 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ethernet: ti: cpsw_new: populate netdev
 of_node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113823325.360063.2190869561934533102.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:30:33 +0000
References: <20250303074703.1758297-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20250303074703.1758297-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: rogerq@kernel.org, netdev@vger.kernel.org, s-vadapalli@ti.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Mar 2025 08:46:57 +0100 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> So that of_find_net_device_by_node() can find CPSW ports and other DSA
> switches can be stacked downstream. Tested in conjunction with KSZ8873.
> 
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethernet: ti: cpsw_new: populate netdev of_node
    https://git.kernel.org/netdev/net-next/c/7ff1c88fc896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


