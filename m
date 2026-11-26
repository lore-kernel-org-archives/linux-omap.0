Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699689;
	b=M7QV3yw1f1bPBb6d6DirU9/NiPbxeU11YMtz9iwy4DcKFCgD9fHvQ9ZmU2EQlIdFjath
	 5rZJ62krAId89Huctp3gwyDzjHpCwsHHffm4RntNaSvVlFFxPzjLiZ6jJvpxa8leXFD63
	 qfsyXr38MRDOSVYcgaJObTLKi/ssgyNJ80NAIWRuId9JSRJxkVgnwqp1mJwP+dq3e54jf
	 NFlNfj26gwPpC/suzBiJXmYnB2XwH8kN44b2EBNcfhbE0yBbsQBUHDb4vu3+zbaA4Vjno
	 zf1oPFgjR1EXDyP7iUwZ9RH4M8Ouq+qIya/qwN5At9kn2pkcolO0vxlei7R+IHySj/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699689;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=A7U0p07mSQjHdlfkkKjfj2Q1Dpcjaay0LcPO70PEIsw=;
	b=MeLPgzRoFE2pGQHFxfj3hj1phzlE+AzSlbc8ebX8wiL2Go/gxS0juOQYZFbGjTGrgwIO
	 X9WFULTSE+jnNNQyaLDMA2BboNHSGy/FBtPeyscjTWpIWU5ZYjS831pjMJJoaNmiM6JdC
	 ebojLtEKSrBDuEfrarmKl8sspoXRycXS0M9IoQ09Wpjat6BniTHLg5xN8ISSz7ZTwb6HU
	 xoeO0GH6pr+6P8IwMUQ4rV1SmyuYOMKytR6gtLDn2vw7f9DUrQQ/ONfxXt3U0gbDsXv6i
	 8S7+YnQKDsJu7u1mKXa6tb4xtkv/iyNzoGiF+zwvS1p/iyjA13gWga6dZiG5ikkYDjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XCxYiaRA;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D37606A31C
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 13:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XCxYiaRA
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fcb3;
	Thu, 26 Nov 2026 21:28:04 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: lee@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	j-keerthy@ti.com
Cc: mfd@lists.linux.dev,
	linux-omap@vger.kernel.org,
	liguangshuo@mail.sdu.edu.cn
Subject: [PATCH 0/2] mfd: Remove LP873x and TPS65218 child devices on teardown
Date: Thu, 26 Nov 2026 21:28:01 +0800
Message-Id: <20261126132803.4091137-1-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2180ab32b03a2kunmf8b0a91135d952
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhhPVk9MQklMGB8eSBlJSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=XCxYiaRAbROw7JBAXl1x5Q1+M9w36CGQtdJcoMxgV+jy7uvCAxuCUdThCiVBEJDCzUxPetDtzK0/3b5I196j9IXxuMdnD8u8bgM2nOsZwcxDE9GQoRFmLiv+9nmHmuGtJFYPrxcL719ctDLRiioIE81BYJ35zdFb4e30zJ7Glko=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=A7U0p07mSQjHdlfkkKjfj2Q1Dpcjaay0LcPO70PEIsw=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Pair child device registration with removal in the LP873x and TPS65218
drivers.

Tian Xuechen (2):
  mfd: lp873x: Remove the child devices on unbind
  mfd: tps65218: Fix potential use-after-free by child devices

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
