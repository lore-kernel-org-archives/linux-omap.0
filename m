Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FA4F054E;
	Thu,  1 Oct 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846020; cv=none; b=CZzSDEqateTQdZlNUrnXBE0PC9ubaafSZFwigVnn3p6EMKVUzxGc/LiJD8Lq79kPWK77FqoVNnm3IgObJDCK7XXM2YHzLjGKhkXARVhFepJ6bMR/VNgpQOMnD0fEMVRdf+4XxycKDU6n1pxMKYGaumb3P3Ogs6Z2gjg/wG2cQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846020; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXsJut/dR2Ra5qensitivMGTpLMiplrH11ZJ9GnK8ZST31XPVT5p0ys8XkMbDtmLUXP12aJIvdrwsgYwYPWqFQeyLg4ltx8C2k+XLjNbtX66VvyJKaNc+3gFrDg2+b4Qtem4uNdPDmK5+n3+7Qo7mT5vxD7wZU6pp51PdPoCy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdjRM6PD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdjRM6PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8943F1F0089B;
	Thu,  1 Oct 2026 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846015;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdjRM6PD/3uWG28GPr5ox6IvkZvA5BOLPaxbRHBpeWHGvgNx7EWRofaNosieYhMAt
	 /riE7kVBOGbOAYH5ekDPJOvFC3EhIQxCAoGSShsMG852xtjdd2AdGETBmjT+j14e1w
	 tkuMfF7HEvk8CScak68OycL9DVd2qCxRyXigBzBmofksXBzFDcgK1SHHGwVnVKkiKr
	 bs3qrqmZlOcZxSimfMj7Um+HOOXojLkDqrho+FU+1W53zmQ+N5kCViM2egVS5RtefZ
	 lXhBLJcYgWtafHwmj3qNQ/afbKgQLd2W79bmPsVK2A+qSZz6kGEb7mdGTd/Ogws2QU
	 E9/pLPgV16Mpg==
From: netdev-bot+sinfo@kernel.org
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Kees Cook <kees@kernel.org>, Stefan Wiehler <stefan.wiehler@nokia.com>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Chintan Vankar <c-vankar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH net v3] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
Date: Thu, 01 Oct 2026 09:13:34 +0000
Message-ID: <179084601411.31693.15138599168021166167@kernel.org>
In-Reply-To: <20261001090820.1605711-1-danishanwar@ti.com>
References: <20261001090820.1605711-1-danishanwar@ti.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
