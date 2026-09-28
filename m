Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE449159C;
	Mon, 28 Sep 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588833; cv=none; b=Dd4w8MaTfFCJnDlaw9NY8hhkbiv4HODEgjdfWcm96VYdndfCKelPGPYa0qfVZ0XQIumRqNveNQiu5p6k9gIUcwczuHCv8Bc1/+Vuj2taUPvDK4Qw8n3aQaUbZ6MIT+4qHyDoNI13km4LSBPuFpzR1BR3NA44FpLXcwZa+WIY6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588833; c=relaxed/simple;
	bh=mAZlA2tafhOljyq/iP2+iZ6K6iZpBw3rq6QaFjrSbiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgHqJHRHa/zjdi5gu2Dzu5x0TKW/cZz/nfygnU4meJ2pip5HlJawkq197FBuRoWbilLCWeid7SJVL8ce5hHCBNcEKxQMu5m6saNJtmFitP71plQky+QJurm3rqxTOGxtc9DMqVrAoW255MaTNU6NThx8tJ5FEynxz9PEK2lC1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j7t3mA1D; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j7t3mA1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nN
	YAy905/eGCkrb6hwdLmwg2oEZ8qaop0g8gQHQ/JLo=; b=j7t3mA1DXWngluHkCV
	xbI/Re8xnNmNJwgNkC7EZhuV5CONnWXDfv0yLiw6GWkVIWXi4xyNlpgpohCVSgvT
	Oe3T7A/62Lx6kJL1ADW4b/prWIkwfmxJd8ybi7Zq5iMpcy1J6MSyv2/XRUNJr7Wm
	GgPlSmMvU6jin6tM6AMEfb6eQ=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X0WIN7pqt_x4BQ--.13130S3;
	Mon, 28 Sep 2026 17:46:49 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Mon, 28 Sep 2026 17:46:47 +0800
Message-ID: <20260928094647.2021321-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916123210.107841-2-quchaosheng000406@163.com>
References: <20260916123210.107841-1-quchaosheng000406@163.com> <20260916123210.107841-2-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0WIN7pqt_x4BQ--.13130S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1DJF48WFWrWr4kGw48JFb_yoWfArXEga
	s5uF4kJw43Xr4xKrnrKr9ruFZxArWDCFWUCFyUWr1Ik34FqFsrJF1ktrs8Xr1Iqa43Kr4D
	ur9Yqw1kAa47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjvzuJUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wk5rmq6N4lEqgAA39

A gentle ping on 2/2, which nobody has picked up yet.  The binding half
(1/2, dt-bindings: display: ti,tpd12s015) got Rob Herring's Reviewed-by on
09-24; this half is the two-file dts change that drops the unit-address
from the tpd12s015 endpoint nodes on am5729-beagleboneai and am57xx-idk,
and it has been sitting unassigned since 09-16.

Two questions, whichever is easier for you to answer:

  - Should this come through your omap tree, or does it belong with the
    binding, through Tomi and dri-devel?  The two only make sense
    together, since the endpoint nodes carry a unit-address with no
    matching reg property and the new schema rejects that, so they should
    not land separately.
  - If the form is wrong for your tree, tell me what to change and I will
    resend.  If you would rather not carry it, say so and I will drop it.

No urgency on my side - I just do not want it to sit unowned.

Thanks,
Quchaosheng

