Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215013;
	b=tJ+RbN274ox5tZaUJzdtEByVvMitemP5NARh+IQo+8Wxr8G9239ublXlmsn8c1ysLhK4
	 yc5ISGG9q2/S4aomb3DItKn79c+H4NhcKijXNOt3KlbCuYQbRHDZR2qy0SKPqUpzZNfz7
	 FdxSQiYbsAXfu3AVV3dfTFjK7CJL3s9wdoNZotioWPWEsJ6VRoD7XVWH/Ns/PGnOs4BJI
	 PBFO9ZlV9kZc/CecS48/8nT0gmzjaFqdcMKWp/uFuRRxeXX63zEa6uAFQ9bUJ/jQXBTIT
	 eQogtLPVmJB//Ttw1GetUhPxmlcx8TVvFyygl4lrFN8JnM8mQerC0XG0jRkOQDFOsog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215013;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wqNWBCsndisgX4lcRXrNuSI/oi3Ees/aVl5C9Q8zm+U=;
	b=OWM5xUWDRSSHWBuQuL5748wvLLzhCn3NeGend6t/qM5UZmn4MbPiTWrJkLJVI+IhyMz8
	 k6Q0XbZo5MSnRGGjAvweVbTkIg+GYZORuplDMdDWhYTcLLQS1tltseYbPQW6/+erKP7c/
	 kd3UfVQKdSfPB7U7Q2TCcjbRS8ezZKo2Yu5A+4qrGt5hPCEfF2cCmayheTjyZlc5IEBB8
	 f81EZemKa8zLu0Dv9ay/7yY63fg5nPlRmzLYogJBjEodObWs3zkyqVjngOMZAIsbzP+tv
	 wWJ1ZTJlBBroNrCRKQ/NP2mzUvEfkXU1vaIapu4kkE20gqtmd6g2MF3jggHDLf+I7kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ZF0dME74;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7742606A322;
	Wed, 28 Oct 2026 19:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7742606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ZF0dME74
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wqNWBCsndisgX4lcRXrNuSI/oi3Ees/aVl5C9Q8zm+U=; t=1793215012; x=1794424612; 
	b=ZF0dME74wp4iav66C85Cttc4fik8Bv5xv/H/FMAkK/3C18Q6642Q8I9X5P3o/6c63uSD3qAy54j
	j1AMcTIJf9VENHRcnwVpguW0T51SQIvD14t1SkXmZaVEHLYj3SEo/sVaeRBehNX1D4nLlwkYXTjRo
	lwmgh4yxh8vMHMBS4nNRLD3FHMCSRmhd8yKW2Qhahv+jYGkk/qPoHqR/OclDqG4uKm7PAe2j3O8vk
	Ck4HwNNLrF7g9knBDXV3J3jcFrSxgIAmj7SHPn0XwMTZk4ln1PX98ECWDaEGTZjIsIGo2548i/DIe
	azkNwqmMG0cx7GHiBUS9keUSqUrwt53w5FQg==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] ARM: omap: cpuidle34xx: Fix unbalanced
 cpu_pm_enter()/exit() and cleanup
Date: Wed, 28 Oct 2026 20:15:10 +0100
Message-Id: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
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
X-B4-Tracking: v=1; b=H4sIAL5J4moC/yXMyw5AMBCF4VeRWWvSzsLtVcSiajAWJR1EIn13x
 fJL/nNuEApMAk12Q6CThVefYPIM3Gz9RIqHZECNhdFYKTlkQ0Voa4uuptKMkNot0MjX99N2v+X
 oF3L7O4YYH3hZNQtpAAAA
X-Change-ID: 20261028-susp2-e2a9a2c9e71f
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=654; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=LNDW6Cp6A7t6pOlJ0sLQRvudT0nQe3f2z0UosvyIAs8=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq4knArntyhwMIQ5Rze9gZxm3Ygnj0qkFy90VL7
 aH+EX9W6VSJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCauJJwAAKCRCEYUX6QCjc
 8fm/D/9Pv4Hlwg8vSDUrw3D6P4xKf0kq+BQ9UvDH7FIRfCfeJ4aFP2YXCLgiW8rEC7hplHEPDmB
 YYBdz8o6adGKcOj7vbWWG4qVckFXBxB6qDpRnHRl4dQrCEULDyjr0NU7LHucVsqBcNXNJz04RLb
 6GMiLAgwqI/40482eg7eNArkDH9lgQYH/uDUU6DBQFLx58c7kMArSjrqoDFYgGT4IGqJG5Uxvaj
 RvXzrviwohvfr9mWkEz54AOrTaZ27EnbRUTX6scRNCuX6LoO7PzXynBWl8D7eEQjWdHNPkIvWzq
 LCvHrFr2YMhF6xoEhURUkAex7Uk4ZxNzj17xNeR77VakHQ1n3hMX8UCmwtId1OUxpfBzl7no7yb
 pbZjfzF6rUSNwxQzLbOh/gmUb00ZrAwa3SdEycOssr+LBXBKuL86bmsBfICDVY+/S19CgMdc/A8
 1YZLyjacFbejadA8aG5OAonZM7ox+bLjIVPUqBQvCDQ8Hm6R6ecj9/p1yjOYuqCrlb2KSC9rjoy
 1eBKP8gRZAYkYvJSnWMH0a9/BDlVHqgyQQHA9v8c86GDtCVoiGBK6w0nqhbhpFLZc5p6nNnsz1B
 PBX7KU6AW+TR3T7vjagfwTTy7Q7XAYfWBKT6+WmfAzJnh92BtfbXA1D/TbpJV7B0BuP7dzkz5eG
 pOL+pVYndNoZvmA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Fix unbalanced CPU pm calls and delegate the question whether the
cx pointer contents could change to the compiler.
During research for some spurios FPU issues, this oddity come to
light.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (2):
      ARM: omap: cpuidle34xx: balance cpu_pm_enter/exit()
      ARM: omap: cpuidle34xx: Constify state info

 arch/arm/mach-omap2/cpuidle34xx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
---
base-commit: 5fd8fdf561e0e6093305b6c993ee9b7c25bc8b51
change-id: 20261028-susp2-e2a9a2c9e71f

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

