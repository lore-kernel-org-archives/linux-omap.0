Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7125E469;
	Thu, 14 May 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765292; cv=none; b=RJqvElfQeFQiiRwQan0DZvHSmhiZdhm21XRGxlW1mMHu4lhx8Hw+RAgfTmFC+yPF84pSl5ZReggL+IkYpzPyf3uiWkrg3kfD3oW1CSeRfGEINkNo42PxODXCuXQDeQCis+fdE58VwA6MOc2ZmKf0v5SwOBPndEJwIyLBn8/PwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765292; c=relaxed/simple;
	bh=QOKxVATk1lSkThYPeBDT+AKJKBhQQ11hi6JKq4CF8pI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XBZPbi+XV0QQAXbXd7tg/JkfGKYCZgugUnZvNW5r3v3lH+UbmyPqqkkLOylax3yk4RI5dKMgSf5I05rrlJL7d3oz/l+igLLyJdd21PS+x2MrR+V0WFsnFsjhEo1WAegOaCSxLFU6rn2rrbY3BB07EJUdVPoU5sXzDqdPkLEZ368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir/0scgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir/0scgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F592C2BCB8;
	Thu, 14 May 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778765292;
	bh=QOKxVATk1lSkThYPeBDT+AKJKBhQQ11hi6JKq4CF8pI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ir/0scgKcCswn2vlF+8pA7CeyxZgzMTmC6PSdj+k9D73m8vY35C8JcbxDDpbsiHOs
	 te1cZXShdQFUdNi15N36qQ/Aa9IPQvoUEtppsJnl8oIwp4C0o+DQAeJwX+PJuiZ4k6
	 PIkDbcszehBZ8PZYaCtV8Pu1CmvQeV6YT7R3fXBkU/GRQT/IOWKZvN9z3otPkh2fbk
	 7Tg3hJdheoSiA4DCZCESnwA4VND/yZTk1Uv23tNWJ0yagYHi0tVKrs6oMn93lhxBwB
	 Ycv+mCyzXGNURIdPJQXuEP9g/U+vfcpMsRXPMgFM8lTljyjQcAJbQ2/G5VOjvZp/bt
	 yWn84I1mwgcsg==
From: Lee Jones <lee@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260505114543.159381-2-thorsten.blum@linux.dev>
References: <20260505114543.159381-2-thorsten.blum@linux.dev>
Subject: Re: (subset) [PATCH] mfd: twl-core: use i2c_check_functionality as
 boolean value
Message-Id: <177876529031.2738421.7743203807478505501.b4-ty@b4>
Date: Thu, 14 May 2026 14:28:10 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 05 May 2026 13:45:43 +0200, Thorsten Blum wrote:
> i2c_check_functionality() returns a boolean status rather than an error
> code - directly use it as a boolean value.

Applied, thanks!

[1/1] mfd: twl-core: use i2c_check_functionality as boolean value
      commit: 9d5664df0221e8529b06d71d6bdc7d4a214cba2d

--
Lee Jones [李琼斯]

