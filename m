Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C331159C;
	Sat, 11 Jul 2026 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749914; cv=pass; b=ag4eZ4dYdyjRME44BcrvESBH4ZIwgmvfaIDpwLPWJcY+FrXnUlpbZMNdnOKwf6ym07BzmgIDcauwYzau6nGd8KoXqa0TO7xDlUygnkGpTq2F6T0byZxqpHhe8hqJmuk2oC8+9VKFkM1NricuTkgqU72dEORMUuJsRMhvsJA2qNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749914; c=relaxed/simple;
	bh=Q8ShPXJJbkie1XZ9aPxZP9g7/79FhXw3B/IJX9O5rLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICLLHZwXrIBrzuHAWyvAFhCui/qleYnKCEBn322mXw7ZT50c1CN/k1YekPmKNq56b3o8vr0RvsbNwQw77ZyKdGOe1bTPHbuTmuqwodJqMMsYd0DRv8TlTntQNfxnQWCTY2LkDwse7S1z1ygQC4gtuAciguLblhIdmMNP1Zn+rRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=p/xvyqSZ; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=m+5PvXgf; arc=pass smtp.client-ip=81.169.146.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="p/xvyqSZ";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="m+5PvXgf"
ARC-Seal: i=1; a=rsa-sha256; t=1783749728; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AcgG7Rib40rrNR3mFEY7DHvrOLVXjaSkOl6m849kJGle8CqgRcZynCqA1SRsWzAiw+
    pszbceXN9Y3FXgq/c91kxei9DQmp+LE6ioeyRXyabhOacofEJDlyMTxCFLrq7mmXEHHj
    Un3ADiU0rP3Zwo7V6Da86nlA2btM4+jxs2M7+HXbRAH7be79vJG0NkmdRhlLCmDuhPQD
    hmgBD94cBn922nD9xVPftDJUUQyg5LPiEjIEKK2xgCaXLOBSXRHWx2Rw6cSgwheP2fFi
    I+pgzLr6nZexennFQWkczJfo3UHn9AetGsnNz4CtURE2bkX7ZzdxwehDXl5H/LB83Sl6
    lPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749728;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QXR5Qg49Kg9ruecbogfudI2YBbpJhxt31ZHIrx9WnZU=;
    b=cyR07WQYwivBNVI5PZc7/pMiuxlrC5ioHhl0kQ4PkTYddWwoYbJvOYfhlP3Rbm27c9
    tlumJkt5ZSI3aHnYoUv62PDVHM4kO0LkAatG3uBaF9JOYN+RVXaLHQYJH5NA5VUNFihg
    k0MtSVDLZAOq3DA7rh0/jbBElYEEAp08eVjaOYCfDQbw3p70qZj22RzGXYxbhKju4lXu
    R26dYUGKB6UiJz8rmSWX/2jhxRTcO4nbgY1zdReulfWLd+ymsSTGhUUnzMyXtGkmebxq
    sWPfOb9ApIz5ukpCrJTGc8SUAOtBbMz3Vvc9974wjEqb65ICmDXohyFAJxbI7WnMi2gY
    fx7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749728;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QXR5Qg49Kg9ruecbogfudI2YBbpJhxt31ZHIrx9WnZU=;
    b=p/xvyqSZp5epJfPeBZNYTZOluSU9uGqiRFNq+G8iHffcdGif+9CipG4pS8TBQ0SXyw
    z3gq8dto40k92lPZS1n/vmYDZJkrLsiYwF5k54z6akd8ugdCR2XcCIJTVbgCfl3rp8z7
    WsK5EfMemVpC+zIrXaop5PHLYyP2kq+lcms5V7Aq5snurT2neHZMOuRCkp/BBSop6F0R
    hUcuY01PYjgfkaQTlV1Tbr2Pltu+oRcNjn4VVR2Yr/Ic+rLXpfBUTqHKTUeWtccBDCZF
    wNkVRdJ2OMZ7sIrJQ0085dmOl0svaNIrrwG3diECs/p7r5YcoGmO8sh7DuRezaT2/TXJ
    KNTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749728;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QXR5Qg49Kg9ruecbogfudI2YBbpJhxt31ZHIrx9WnZU=;
    b=m+5PvXgf0ms6g80KPOtqTg3UPfv+ARI8gG/NdH8CV7b/IdiiyD7Vs+YFaOfvGiO5dE
    a2xAtOZLGBXI7S4KZaCQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B626Ghl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:06 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>,
	Stefan Leichter <sle85276@gmx.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com,
	mfd@lists.linux.dev
Subject: [PATCH 01/16] dt-bindings: twl-regulator: Add bindings for exposing ti,twl4030-regen
Date: Sat, 11 Jul 2026 08:01:48 +0200
Message-ID: <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Grond <grond66@riseup.net>

FIXME: not reflected in the bindings

+Reguired properties:
+For twl3040 REGEN signal:
+ - regulator-min-microvolt:
+  - Same meaning as in bindings/regulator/regulator.yaml, but must match
+    regulator-max-microvolt.
+ - regulator-max-microvolt:
+  - Same meaning as in bindings/regulator/regulator.yaml, but must match
+    regulator-min-microvolt.
+ - startup-delay-us:
+  - Same meaning as in bindings/regulator/fixed-regulator.yaml.

Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/mfd/ti,twl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index 9cc3e4721612e..183fc015e40ad 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -46,6 +46,7 @@ allOf:
                 - ti,twl4030-vusb1v5
                 - ti,twl4030-vusb1v8
                 - ti,twl4030-vusb3v1
+                - ti,twl4030-regen
             ti,retain-on-reset: false
 
       properties:
-- 
2.50.1 (Apple Git-155)

