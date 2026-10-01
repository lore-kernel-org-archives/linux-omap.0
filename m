Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2D4CB8C0;
	Thu,  1 Oct 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846001; cv=none; b=icKGkU+ceAqPlqG9o/J0agazqxdX2WynSqAFEuSErnJm91VsBAahkZS0JfS4luN4EepyBpvKxJoF+tuHmhyhsVvlkVo47evKXFZalUf6Iyzm3c7G4ykzdHJZoR07AdfYuHCGf8UeK9+shNDsEvWJlkw92cR/cS7wc4yHqo2EPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846001; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8L0lIzQJ6hRVEI/T15k1zHk01RWz9iwcznSfC5Aen2U2kmpojbj3aVdgBrt++YAqRANNoyvVRgHMkZ3VuHWim8vi/novmABPYWQKCl/pZm6yRjdSl/uPpDot87DsT9Gh1rVnzA9ijgdtQIpiQn229g+PletQgZngYQ+gcfB5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTPngBIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTPngBIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93A21F000FF;
	Thu,  1 Oct 2026 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845999;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTPngBIy0FusCGL7ZltkQ8QtLyBjiZ4SdLchb+CZ6GHIWTD8dKoSphCqrEL/gYsMi
	 sgkxY+AhuJcR3ShwSqGUC1G7dNZ/aiEJpQpOTONvOPwJZPmYU2KvWuaJDFgEKaXBxF
	 j4QiQo5WqNTkrUmvOq1zogHXSqf0+yDbl9NYWq0mYUYD5FfJ2JH9vb+uI2CPpFkL7t
	 kMapa9/xic0T3xTgvAoUAmG96Qeq5vTx8xeyJULwe5h0DTQtkBHr9keKPhiMEn6DMc
	 yqm8Qz8OsImqpCu1c+xWH6TN6ByePFrChc5Z/LRoociciuqcvvVMHF+V67cZBeQnCl
	 R9lTv5UVCGoSw==
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
Date: Thu, 01 Oct 2026 09:13:18 +0000
Message-ID: <179084599831.31693.11273065705866823199@kernel.org>
In-Reply-To: <20261001090820.1605711-2-danishanwar@ti.com>
References: <20261001090820.1605711-1-danishanwar@ti.com>
 <20261001090820.1605711-2-danishanwar@ti.com>
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
