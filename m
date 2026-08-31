Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B4399000
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218621; cv=none; b=U5PtBzz+Enum1gsBBQFPWSvGiIJF1aO4vPyKr1Y10gye482FaE45mbqqYaT/gk8can9nT9QjliimdwgGSs6+GDVP77Pdr5rhxR7qn/14jw3yqSjbozdcSD0VvdenuFTk4CwqwPWD3lDfe0c8BN/VA+PQS4IhPPk5isV+61S5V6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218621; c=relaxed/simple;
	bh=lhiU6/DDjvbnzvWKv8+M0o5FcxAg1VP+aI6rjwrIbvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OrTjQoBSzUxZZ2EJC7IjCZVdoLa+53Wzf0pCjwZPbm4ea2ZftDSoy8KOdQPTUktadijEnTrLUT1QTFujdeTZfq7VUvTSbKKMOqJ49o997p3BFRGB5nwSCMSn2hqHSE7QSvtfq20nxZcf6X7Zdtc/2w3SOuX3KPI6c19LiYJ/zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGXgTqXp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGXgTqXp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38f57e312ecso935296a91.1
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788218618; x=1788823418; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1wPQaEPiJFpIFKFk5jJg7O8BkD1EI/fdnyjnPPYqLy4=;
        b=mGXgTqXptEEojfRQGJybiYB7GxZxudJ5EMLdZO0mHR/dR0j3YNtzBljzsdkCbKG2H/
         iteIpTVjfC9TR8mZsYcIgwAzXWkgHlFhT5v+cG8L/ee6w0YoJw5oIZTNfOFZOTc67ffK
         KPENZLZIWeb0QHF7QTYMg6gvNR/B6+5udXjjOcWOGGnt6L6KFlnlu/j/x6jEjVCUpZ2s
         tB34ib7QjIee7qsSduY0dIXq4dlLzqYlDNsjq+phqZY2kHdviRD48YFNQxQCD0XzktlS
         XOwVCXboDbvjwC2rvX0jSKM6mtIhr3rasE16UR67iTBA7de7HrNXHpykOJfACT2xgRPU
         E8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788218618; x=1788823418;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1wPQaEPiJFpIFKFk5jJg7O8BkD1EI/fdnyjnPPYqLy4=;
        b=O49qZOkJ4dzZse9oWywOPc5uIGuD8AYDxLUZ2sTNbCLq6B8yw4BMgR6vN7h8rOPlEw
         b+POl7Vp44SVELf3UAh0Da76xXWUnv3kKO4kG6m+jGteQkT/Dd7LxYjPqYN6cZvkwEsU
         xh2V8sxQ8c10kWdsuyJUE7sx0g4QyloYUh9wH3/Qw7s7HUzXgLCxRVO7HNO3JcAU4a8M
         73Hb1ej1/lvyfdxwoUAB+RHLlrva+xvrO7yw9BW52pVWM25JDTb0KihhE+n9hLrR7nzG
         oA7WdHhUzZRveLOpbp9pKXGpFBaFZwYIZyWhd4BOi91Zsbo/lQ7T7LitCMQkYohx5lK7
         iq7A==
X-Forwarded-Encrypted: i=1; AKwUvByY6qGcdOP08FkQJZFfnrzHWERFHKdGN6uChU6zrGhLDeNscNPraiEo1ft8H+WVWLkeTswvOoxbau2z@vger.kernel.org
X-Gm-Message-State: AFuF++kASJG9nh7czcQ3cVKc0RmNBPQ33R1xqLDHwcLgHGIXlbFi38N6
	VaRwARmsvALqvLXfpp8TzZPDSr2AdoacziL2N9pOuvtu7n0nK55WuKfo
X-Gm-Gg: AYBFou0VxFW3ZOGyeVb0zq+fubhZwA6BZA+wW2B+Uw864tbFkz/e7wWmdnjaOfjq57Y
	OeP8fSnbs3RRlrrwyLJAj/a8zFftdP4EJ+LwNbe7C3Ovp7XK6u5b+D4j+zOAyOtY712u50a9u3e
	zPQGL/dD4pgi3TdhtZ8hG2OG3a2ju8NCLq2I/kOYDECU9+hS5vooNhwCe2sHoViJ53N0LzhgIRP
	5f1MmIm5U45NGiiR93zaW5d2j01/8EZ5NAhwHyb7BGmsOrFrxRHnLmcTP2v+adzBVyTcpFvqdjg
	vxJpKF8PwgZzjtC3+rZUfYChdYQ15+XM0virZgRym5YkoYOG1NgUmY+Ru9/x6yLR5K4W5NsKG2q
	JBsQuV1mdsFfGGDJvRQmibKpehCEYLKlY+iyjfo9t6vcl5eGTtdmcwCuc0n8ZbZVdA06pIdA2by
	xIaaJSEkOKTAl09Sg2rne+dlmShKuPuAnloMq62csHNwJ9nyQt41cXtK5vIBRwV//+GzjyLphbF
	e7ayLALEg==
X-Received: by 2002:a17:90b:4fc5:b0:396:63a8:699b with SMTP id 98e67ed59e1d1-398ba94e732mr16798419a91.1.1788218618239;
        Mon, 31 Aug 2026 16:23:38 -0700 (PDT)
Received: from [10.60.78.252] ([2409:40c2:5002:4362:354a:8f21:7ceb:c8a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm1963213a91.12.2026.08.31.16.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:23:37 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v3 0/6] dt-bindings: usb: ti: Convert AM33xx/DA8xx MUSB
 bindings to DT schema
Date: Tue, 01 Sep 2026 04:53:04 +0530
Message-Id: <20260901-ti-am33-usb-v3-0-5e15c617d2e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBQFr0K6tqaUthRX3sO4KPRXvhEwLTQaw
 t2lGBPduJzkzbyZBPAIgRyymXiIGHDoVyh2GWla01+Aol2ZcMYV03lJR6SmKwo6hZoKKbTjIEs
 GjqzG3YPDx1Y7nd8cpvoKzZgSadFiGAf/3O5innafsv4px5wyqirTSFdx64Q8XjqDt30zdCSVI
 //j8uQqZ4WwSmkuvt1lWV6M8tOs9AAAAA==
X-Change-ID: 20260817-ti-am33-usb-4548f2e570ef
To: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrzej Siewior <bigeasy@linutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Bin Liu <b-liu@ti.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788218595; l=2585;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=lhiU6/DDjvbnzvWKv8+M0o5FcxAg1VP+aI6rjwrIbvw=;
 b=pNNAoj+rP+n/nEWEzXEGqCUrp2oN6vGvO3dNkhf2xDdgx0FhG6t9HscKUjc8CMsqsvZqseUAt
 ks3qntcjLbWBADCMN/ZSv6/JducXplpgz4IXe9mqCtqFJbIYaJLl3tk
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This patch series converts the legacy TI AM33xx, DM816, and DA8xx
USB/MUSB text bindings to modern DT schema.

The legacy am33xx-usb.txt and da8xx-usb.txt bindings was historically
structured as a single, monolithic file that documented the entire USB
subsystem (the wrapper, core MUSB controller, PHY, and control module)
all together. This series converts that monolithic text binding into
proper, distinct DT schema files for each hardware component.

Patches in this series:
1. dt-bindings: dma: ti,cppi41: Convert to DT schema
2. dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
3. dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
4. dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
5. dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
6. dt-bindings: usb: ti,da830-musb: Convert to DT schema

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v3:
- Dropped patch with dts change Fix redundant interrupts property in USB
  nodes.
- Rebased to latest mainline.
- Link to v2: https://lore.kernel.org/r/20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com

Changes in v2:
- patch 1: add interrupts as required property for am335x-cppi41
- patch 4,7: add pattern constraint for dma-names
- patch 6: remove deprecated property ti,hwmods from required
- Link to v1: https://lore.kernel.org/r/20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com

---
Bhargav Joshi (6):
      dt-bindings: dma: ti,cppi41: Convert to DT schema
      dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
      dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
      dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
      dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
      dt-bindings: usb: ti,da830-musb: Convert to DT schema

 .../devicetree/bindings/dma/ti/ti,cppi41.yaml      | 109 +++++++++++
 .../devicetree/bindings/phy/ti,am335x-usb-phy.yaml |  49 +++++
 .../devicetree/bindings/usb/am33xx-usb.txt         | 200 ---------------------
 .../devicetree/bindings/usb/da8xx-usb.txt          |  81 ---------
 .../bindings/usb/ti,am335x-usb-ctrl-module.yaml    |  38 ++++
 .../devicetree/bindings/usb/ti,am33xx-usb.yaml     | 103 +++++++++++
 .../devicetree/bindings/usb/ti,da830-musb.yaml     | 113 ++++++++++++
 .../devicetree/bindings/usb/ti,musb-am33xx.yaml    | 113 ++++++++++++
 8 files changed, 525 insertions(+), 281 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260817-ti-am33-usb-4548f2e570ef

Best regards,
-- 
Bhargav

