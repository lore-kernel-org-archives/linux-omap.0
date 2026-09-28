Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30573783C4
	for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617182; cv=none; b=LiJrheE7kvF2hl6gx3B9gr7bRShNQF4lpdzZO7diDQD422+nYfjp7sumlEQRpFzXCjnaxA+RhmHdkEr34PvMncuoUmK2YvRvvOvRTntWDtVgrnBHhkQ/FmCoQk7jXrLfMYchEXrssOczVD0Pyjxrz7SvGQ0CJ53KsIcOVrtYphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617182; c=relaxed/simple;
	bh=JyI1uQfKUkOzEB8Vx94OVELkLRvhB+A8B+iLp/uqpV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s/5OZOl64Xyjg8eIW2rRyLIGmPZ7pPjr/lzLNEdLus5REC9mTue3oCKbI9pKMvpfZatpSmlp2p7DdoN2iqqVRCO97zK/jS2zfk9/Tsj1PHDPw/9YAWKzK32XAYbQmodUhgsrzzT9UxN7r//SWrm0QI3DzqKX8wp6ms2r1Z7tiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hlWE5YwM; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hlWE5YwM"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8805988a200so2078875b3a.3
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790617180; x=1791221980; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHHkl+PrizyhmQl262VvRoaJ4qE1pvxLqUjujb+MLVc=;
        b=hlWE5YwMw3iZVjvZsroB9k2I++v177QL4d74hxho2unc7ewz63+fMWCrsQRBEgnZwt
         IKgrdxtD0pSCeVsvCOMRALM4uYnp8l58Z1qcMU91Ga9eH90Zdwm1ZCiPyUEix+VbTD25
         S1sD8J680vQjJPStTSajHyBklgknyCY0KaQJrAIvcvHhtDjWdeCi5bA8hkemJSerd9dV
         BZAFIGCKnMMW7Gtw7zktgD/ZdjS6J6WKTC1iZuznGtq0ZV0WHXjT6KtyUteWxB/mBIcj
         93+Ws5PqfzWWxkTMLWjNeUya2zmgQ/7i6ol+FWqKT9+3INGcwxGSqgjKjRsdgXuwk2cc
         5tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617180; x=1791221980;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tHHkl+PrizyhmQl262VvRoaJ4qE1pvxLqUjujb+MLVc=;
        b=c+Y1y5KxR7bDkrboPzFHGGT28gs2DloztkbRSoeUap9BZIwHVexUSescl+lnYAviUK
         bOJzR7DezmZKTg95B2l5holk9z6qmuC5cZdLsEYkj4DzVXwJJKLktt3yjo4+0gYmoOvd
         fHeJmTxNulA4Qj2EwHZvM8aLkj6UZc8f9ZmbLJMG6uns+mMjipAoWADAMLx63K2+z+0L
         FVOTiDjsGcNJOL1FL3qkKzkT83nj29+5GHDvXx8Gwv2bvdNWrolozeMe75r04tC8Nqd3
         LRRpoAdUJPhN+z2wxiY7iMd1WLpdlaNdb3YPsmZC7yc5vPpqAnK2o4XWpK5IlnZffaiz
         9Dhw==
X-Gm-Message-State: AFuF++ndVci8rJS0NFt2V5mvinKjVPK9bFsLyjNGLDV0rQskChuV77nz
	O/oxD6M7ZhEiEiLOWP1bHPRFpnHPvTNPKSx1wZgw6/oimroG7rdasdueAqIA6FxgMdI=
X-Gm-Gg: AYBFou26GFB7H029gSB/tZdNU9zK9PW1XH1ZP+5Hwyu2yblA6PLSWGit1bwJWMQKinr
	61yzs2QMlZI14pc0LHwIDNU0NpJJ2d7pmh/H3edU4+i6sp1hdjg4anhSusuB1dpjL47VWC++n12
	/gJjcgBJtugwaUdEqABqyx/yvv7f/ttpKjkPsaDBIkkvODmqh6Wx/hqhha6ZSP3PNjloLpFixrz
	GutXrxrIa3bWgdaeY/lWoW7T34Uu7Z21GL8Td9+phTiRsS/zxkM9z2F6BGUdFMqma/joYOS45Qw
	WDp6NdaWycvH11Ao2a10Mk2ekydLcXhKZoJGOPQc4UVg91KiI9KkB00iQ6RAgHl2Rouq26Smnow
	1l51GaEfyzGtGtazh1mhNhP6r4vb3lNkFb2VvCh9ZT0YRNP9rDbRgIErdhYvzecDYw7gz+oKXQE
	JHL5ijjUg4YlvMXs3X6lvuljYyDUpORJNbIJZDUX5A3NkuFrgSBFcUOylujXcmeofY9Cc=
X-Received: by 2002:a05:6a00:a90:b0:882:359f:ef17 with SMTP id d2e1a72fcca58-88235a00258mr4914774b3a.12.1790617179575;
        Mon, 28 Sep 2026 10:39:39 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-87feb97e845sm4583378b3a.54.2026.09.28.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:39:39 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm: defconfig: OMAP related updates for v7.4
Date: Mon, 28 Sep 2026 10:39:38 -0700
Message-ID: <7htsn99sx1.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.4/defconfig-signed

for you to fetch changes up to b45c06f362ee5ce9ef6402fcf57077a740cf1063:

  arm: multi_v7_defconfig: Enable SND_ALOOP (2026-08-31 11:09:59 -0700)

----------------------------------------------------------------
arm: defconfig: OMAP related updates for v7.4
- Enable SND_ALOOP (omap2plus, multi_v7)
- Support for compressed firmware (omap2plus)

----------------------------------------------------------------
Andreas Kemnade (1):
      ARM: omap2plus_defconfig: Support for compressed firmware

Sen Wang (2):
      ARM: omap2plus_defconfig: Enable SND_ALOOP
      arm: multi_v7_defconfig: Enable SND_ALOOP

 arch/arm/configs/multi_v7_defconfig  | 1 +
 arch/arm/configs/omap2plus_defconfig | 3 +++
 2 files changed, 4 insertions(+)
