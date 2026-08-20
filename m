Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6D415B99;
	Thu, 20 Aug 2026 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222839; cv=none; b=nOHn/0gY9yI7ine3BStlVSmu8zc1zn13F3PpeUau29CktHHeK7M+bV9h8GMwZERWUA6z3S2agEQy+wqIlJtyMwkXJCTmCHbt8/J2i2UIerJ5xpfGW9X6H4+Apx3/TvxFqiFrPAgk8t79U+fGTWYM5W/OU/B989FklySWC3V8Q4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222839; c=relaxed/simple;
	bh=wDODlF+/p+M1DkhN86AF0N+ShFJqfEtkmqFWfsenC8g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BZJAgAnE62Fa1vZzppfuEg2mg/V5ay3Bx6MO5OSWd3umC6T9RJ5a0ElZ9FFZNdh0HSWv12U5mLWgNErYavuVnnc6EAxNIEmESta0wuaAUX2wCDSztbVCs3aFAPTi8tFt9HxqbMx71FbAyhLcdviJ572gy7GnWvIasCxKZbuM2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BTegt9/p; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BTegt9/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787222835; x=1787827635; i=markus.elfring@web.de;
	bh=wDODlF+/p+M1DkhN86AF0N+ShFJqfEtkmqFWfsenC8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BTegt9/pGZYMpz9hMfsZ4nh2Gsrfo6iGX/0aHn6fmsWQOzLxyZDnvXd/xIuTQbwp
	 eFgr8yWUzRgyxQhAvRmFtXGnxMtt0QJ4d5J8nFXeuVBk0Fjn3uJJzjMihuv4uIqQn
	 CVDiBgZCoMARPfDdKiZVPT4UN3KY0TycTeLPKiub4LN5fv/mMo0GJ6dzCdK1BPzZx
	 52Oz7Uxl80Mw/iiQUtLE3dndJAS3KwOfFQ0YjG/gJzzUSS8p6HojwsDpUzhSL/ZaH
	 4bcmGdTJ3XKg9KnM2RX3WQj0WAAZzGOpnDGMz9aFQEO/bx+YsrOIUtLE0jdsKDb1l
	 piF4ivXv/s0WDjuLog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Igl-1wiCyD3q0V-010HPX; Thu, 20
 Aug 2026 12:47:14 +0200
Message-ID: <1352405b-7bf2-46e6-9aa6-df1e60bc096c@web.de>
Date: Thu, 20 Aug 2026 12:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: gpio: omap: handle clk_prepare failure in probe
To: Andreas Kemnade <andreas@kemnade.info>, linux-gpio@vger.kernel.org,
 linux-omap@vger.kernel.org, 1298662399@qq.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
 <b610718b-3c9d-4417-b1b7-69f0ac15dae1@web.de>
 <20260820114843.1b50783f@kemnade.info>
Content-Language: en-GB, de-DE
In-Reply-To: <20260820114843.1b50783f@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WqfeFVCLEISuRBcnmQsPSkHdARjUltaQJC+8w/cnip8ee8gBs/Z
 YiplWCcbz2P5wjF0R5fOeWhBgsAvK9/lcdaWir1kOk0AhcHcc16aJ9KVpDiBAJnER+GKDdC
 hu4R5saG1g/qWrXci87awpd6keNyQWvgUMKsXdqju6NlHyM7tD1RCBOizn0ya3hwiQUOW7l
 5yFjUUkzfy4pblv1n17HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bTQk6hzc0Hw=;XygGNdDsFWMOEueTdg1bQbg8P8+
 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

> About adding this to stable:
> does it bother anyone?

I imagine that it can be safer to avoid return value ignorance a bit more.
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
