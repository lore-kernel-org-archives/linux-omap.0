Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215013;
	b=cyDEe8BanhInj/ZPgdoH7Ex1kq5YZ3CrbOrDhz7RCX1a4I1H5H1RncXsasR/4SyXwtZU
	 wpgwm1YwO/FVSvvlWb4aSdMi0v/tGvhUFiklXEG/ZrIAJllGe0nYSoJu6XxT+aT7T2XBD
	 DQgicD2lVKsCybb1EcnzsHyTnqk1LB9Uqr/RindYiejiQIHwW7D8WmzkHzvG/yIAS4k9y
	 MNO5TS4UkD40OnUJzwmus/3BuJVwFou5R/Tmwjs4YFbFbmFpSrMs80C7T21UtrG6hKrzX
	 /TWrJjHigtWMHUP43zj64hHwO06oZfNyQMkI8C90kRE20VFLKh74yflSgD5i52Zjw9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215013;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Qhg6qVfP+OrKVzTFTCDbEiFCVzMgrQLLwSIrUvrN/sw=;
	b=zY5Big0Sm11tMX/KDph71m+mHuxP/vDlm2rKRRWZfoBWpVkv+t60gREDEdPrH69ZddMb
	 nHzTTwc1bXtttQGs4fN5C+AldWcKadzSJHGnGe5WMvzbhJTpkHNkYtwVFOjP+E5oZ7bxD
	 nSQQ4t1PJ44rOaOXhZFH6JrBJgwpEBh/eWbgV9UPp6LG9NvgB5RVNa0k26FYIZdPxo4PR
	 hP2rsmPHneFTRdfer2dx9Nj/B83hpDInWHz9EsSpmV1tZfd9+/xpXcI6wKYwODdMKLDli
	 UpI+skV04IC4a+2ibTvJGmRDKytwunH12wSpMlb8H8ie7qyXVnqMSQMJ94qUPmp1r7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=3inq33Fl;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C6606A31A;
	Wed, 28 Oct 2026 19:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D76C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=3inq33Fl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=Qhg6qVfP+OrKVzTFTCDbEiFCVzMgrQLLwSIrUvrN/sw=; t=1793215012; x=1794424612; 
	b=3inq33FlrTaMbEqzfQacDgp5PxTVIo6dsnhpbLWCHS+VH8mHJ9HnU8mw1rVWWhj2W7Z9Elnqqvw
	XSdPNXs89Y9I+QHHCZqMgdXqTvClW58f8ZB6XMR4N2iw+OzXU5EET44l3WcpgZ19ezEowcuky+MeS
	5jULASLhs56LTLws28Et1Sfa/Yq+uRHSskwcI1JPhSvIM2vRkMKhY+nyaR9rWQh1CZKUjq/IEnMUg
	PDBFvsJV//tpLQ00l3H+JWX25cHxqsHJ93fiVovuEMAwaVKzFO652828to7NsluyXNGfWAPkMm5mW
	GGn0bOMo0ik1p/qoC6qnw88MRuz/pNCBW0TA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 28 Oct 2026 20:15:11 +0100
Subject: [PATCH 1/2] ARM: omap: cpuidle34xx: balance cpu_pm_enter/exit()
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-susp2-v1-1-174b52857d89@kemnade.info>
References: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
In-Reply-To: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=R7GRL/JPbnVUdDmvZmTFKL9hbrDXzgpie3WTHAN4OxU=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq4knLJKv6u8SOZFcFmtL3ea0T8w4PY3i9hkD4/
 M6FFuznZcKJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCauJJywAKCRCEYUX6QCjc
 8UptD/9WC/pwZ/n78cSwkwE8nfv6kQpN82JYWM6RRYa0LPzz8IC3Q+c+CfINnwr93Z5WImLYQ6h
 oRDDvnhNPsBgP0jdmdgF07pYxEMxRJPvdsNGW59YxgOE+EBH3928/Df6dyZOzta9woYkpb5JX9q
 nCPfgU+atq5qHMUCJFJTcHX4A8XJzYFSN+/OCE41imd4uCZpg+/PtFPhGLLqbJk8MMo+HL7JIu0
 IEpXYSDKRv2dzdcvkTDebljab3dbjJcZu9wdrRyCrIy5inGIRjsh8eRc5S4kPVBg40kRjHAblak
 R6YsSR+qXbGPb7d2sxSVhD6G8zpA7Yl/ZQnjfZjqVLXPP8aevbdyQKW7O/W8MmL3DP1iznmw85E
 XND8lEChVWms8XUrIBaNKlB6r352WO6RXdG6bDPXkdu43uIVSy7nGZfCmg35eJpPZYkv9PNS/Yg
 f6NGQhC6CaWoI9uvPWf9palweyQEfMtcGQfkJ9jfGhRj7cETyrKEfUGWnbSniCyPK2eCxKBUQtp
 Yei65FYg/iuCp8tgYCJfgYRTk5LuhePUAusNNEcZSDqtWAWvY28taxn8eZy4RmCkmWRd2zfviXm
 46SOCOVy0YwT1khLk2zgRnwTBYrBjHk6N/LJiRRruO+LIsmrqDF2d15m0I0uu4uEwxTdk9EbXXx
 N1IX+IHhp1vCBfw==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

These calls are usually done in a balanced way, so allow notifiers to
assume that these calls are balanced under all circumstances.
Seen some spurios vfp issues probably connected to this.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/cpuidle34xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 2ab5dcbfb7f6..e42dcf8c03a3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -139,8 +139,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	 * Call idle CPU PM enter notifier chain to restore
 	 * VFP context.
 	 */
-	if (cx->mpu_state == PWRDM_POWER_OFF &&
-	    pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
+	if (cx->mpu_state == PWRDM_POWER_OFF)
 		cpu_pm_exit();
 
 out_clkdm_set:

-- 
2.47.3

