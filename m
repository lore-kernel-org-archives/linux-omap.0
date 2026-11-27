Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809788;
	b=nYN1FmfTUaDS8cTa+qziQS1okfnj0NeYVIB1sPea1iu1ourzbYh5LHkOREpYtUUeiNjx
	 hMbKQMGE/ofNioOu/wB5X3OnkHu9ZRVwzl+IMKuBLBGbhdAjCb1Smy2QPYKX5xDnN8C5o
	 giCHq3bxN5OfiX01eu3afurNg7f8LdF6J/u/Of56BmoXLl2KkcN9aG0+JbZ5v3LJ3ybnQ
	 jWcK+nhUkigdVi5oOTIzgY8+vvunUtM8caKN80cHFfU4uTPBUVMhfpXs/SbXoIwvPNjci
	 dxGEAOAUOpsvywtCnsfFHosGcdJ3SmMxYQPrlWe96HeI/t7/MBtIlE/kbZHK0SWadhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
	b=GKPH2cbtoFWYm0w1LwPrphlVeVl5QCrQFq8qcmj7E0SPQsoOSeYTuWR0DkoI9/viSZK/
	 qNZ507yw/FSNH+cLc5gfRiWqA4DUzp8UFMvHHIK5b/2PlH33MVD6IlqAjfh4TEHd6wxaz
	 QEgVkxp6w6yQpt28NxkfNAyExoktkS5HQV1X5ig8XykFeUMvRiaHHXA6rOersDXKzW2cQ
	 bzCDzAsQnWvCj1IG1vI+tNiN9M1nbIykNInq2KKLRCYmSrNwe/ePiZBK608NCQiVWC24K
	 VLttx6J4WZtiWzLtvjyzP5GzZRrSR30vQ64RXWkzsUWoskYabmOd7uo+2smTZlho3wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n2R6FiKp;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F4606A31C
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2026 20:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n2R6FiKp
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so1355518966b.2
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2026 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795809787; x=1796414587; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
        b=n2R6FiKpuo8g8obEOm2WV36wL4nr03F4a4p5Nyd0b2wdtPQbbdxheWIYRfJxzmZb3+
         O2uuDZi0uiaRR82uvCRPvAceWhP6zDVXz1OoocXKjcgBdfGYu5+22YfyBooVCoPKn0vb
         r3D8qlvSHEZrhAGWsfmzXQbzDcPYrHAIRTqsZ8RA+mGo9ottqiGedVNrCrZjIfpbMUbK
         daqNU1T6ZxAeN6QzRxvkmpuSn/9lf6SmQK+ByQ8IC8jIHeNICeMgIr5qlFtzEkXyQDnP
         aumrrQUn8yPuqlr1pakQcTxfinAX7L31iaQpgA14Yqa4x1BmedsGkQVWOQm/ejRHzr28
         OTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795809787; x=1796414587;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
        b=uhxCsBq3rpFgXKklMcDv2z6Omky2UfPmnjs/xWwAOC9GAYCSi7TyW/5GN0uj8mHEhc
         0J5sIU/QnkNn/yGI6G23VEsbsebdFDBNSyaExEA4nxSvE6iNGyMGc58Vl+ouU64pZDyW
         BQpDwrPJKJJRUtbcpwwiWF2FO49ZIISG7mhJ42TaA81lYzbw3PTPYuElLhy+nblJjZ4i
         M8Da1GimTzHs8BFwMV6mR1utW4Wq/cQPHKyxCWgXrw5cGHVRl88T1dlyR2V04Em9NUbj
         ZwcyJkoQ+ikquk0RbTR/pJ0QcnI+vs6R0PAmbqdnan+krycp+K2EFbXQnG17+67nAnBn
         CODw==
X-Forwarded-Encrypted: i=1; AL+hErEofD2hklEhrh5l27LkS2dMq2SNx1Y4OhHNMzV7kMEoH+rrLwOz5o9AziaUAgkWgnM9fJH62B4kVYLC@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ky7WpiVXXTp1LdDkcsXfaR0wLjZ3UR/PbrdQw/JFHLceZ+nHM
	xymed/1oG5J9URPb4xML4RaejobYGJSMaXYJ+31iycsX3u/sQ4GTJlLqzGSP194xl5w=
X-Gm-Gg: AZFdTZd6cucCOWgVp92ixy/XOHoxH1SW+Ibz7lzi6XR79WNoGRe64nlmiOchNr4gafO
	DoHykXg0dgUfLE304mxdeQf/FXJVuqWPryECtiGS5dl37HXeBXs4mYjk+VYU/c2cFmwAcFO8YKC
	/PahPSTdkqIbE7s7w80tM9n6ewqc2B/A6d2AMR6TPcWBr5XSUah7ECQRWTmPt4lXtg9ZjiZ6m3/
	RJ14fWIhOoBtt+SCFMNkJ9oRTjMrGSZsP3/BWLNgqsrCO+V8OfIH2EMGi5J4kxNLuwF7nEG7fzP
	D6PKP0vJjDRrJa091JYpN78ice6j7fcIZqatlx30tSwFjY6FXRJPDxpfWjFNyr2H9gjkFzXTINy
	78VfnY7iIKj/IIF7aFUT34DawDOx52D5JHgdn7mmOUU0ywa4PKc34u2cXQRfd7VhTgOKyD63yBV
	B/L/WFt+27PYF9jEedH4OCqc8qX7Z5SOp57rgK/m22SaBKpAMVVBDO32/0CL31fLB9IOHjUnkMl
	I4ZGaI8XJRXFDsJEXcBch4uKh32AVG+Txnpp/G8pNynNYwqUiuvfituUEmom6DxDs7UPVU9ebzX
	d2bqX8MQCQ6PsS4p7QGQS7SzKWdvbsO8VrCWIXCkTUX5UI5C
X-Received: by 2002:a17:906:5908:b0:c3f:d8f2:f08e with SMTP id a640c23a62f3a-c513aad1aa7mr1591096666b.44.1795809786817;
        Fri, 27 Nov 2026 12:03:06 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae661b3sm897861366b.16.2026.11.27.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:03:06 -0800 (PST)
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
Subject: Re: [PATCH 2/6] clk: Add dev_clk_get_from_provider()
From: Jerome Brunet <jbrunet@baylibre.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
Date: Fri, 27 Nov 2026 21:02:59 +0100
Message-Id: <179580977969.3028968.47907747276860033.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=576; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=w+BoHiPo+P6YGPZSkRwTWt/kGI08hfYqlVrPoLWDzrs=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcD781zBdazCsg9lL/zber23mznz9vt33xqqNRSyql5
 9/lP4XqHaUsDGJcDLJiiiw13NXi7yS1vsyarnMbZg4rE8gQBi5OAZjIejtGhnPrDj/t/PYpMF4p
 5/BazfN3D21QT/A6eNT9yBfJZ1dZop8wMpzYzS/A8uDOTLmdR+uChb9oSs6TL/Rb7JC9947joo3
 LLnMBAA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On Thu, 19 Nov 2026 14:40:35 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Clocks obtained through of_clk_get_from_provider() show up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> Add a new variant dev_clk_get_from_provider() that also takes a consumer
> device, so callers can provide it, and consumer's name will be shown in
> the clk_summary output.
> 
> Reimplement of_clk_get_from_provider() on top of
> dev_clk_get_from_provider().
> 
> [...]

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

