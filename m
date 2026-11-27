Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795753013;
	b=qIm75XATiS/wn7qqPHW3CGiMnx08opjK8KlII3+z/PAOLpUNLmbQ3/4u4+qTkj/MZKdQ
	 Fel0j6ksZo4AB/HdD++Dyi8tFAVTPfKf/wWCLpgFYkmHC4jUb4paUwvAIBjC8mgXM6pN6
	 SihAliiu+mYD0iPIpZ75uNBF3j1VpL99a5lNvqRRR31tWR06Z0DdUkmDpvzaHVXaegA3Z
	 iW15WCsMqNGmAMqOZq8TGhtDhA6Vwjzzt3rsUwda7tBryrgfpVR+ET7YZ2q0vf6DhA62R
	 kLZSP+QHzwgy/GIHtcxFz7flj7xfw5ToodgU5e579Cr3FlHCQPRoop6/AbW2ZwFh/bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795753013;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Tn5AlZp4PbwQpF51ff+Tfn5KuY+NWZUr3Vs73pw+2lU=;
	b=T+gTDtwjCdwuuUZpQ7+d0/KxZ8GoVuAIEQaPSFIS4/lH95/IO+OGjLRauTJRxYjOVu0S
	 pG1VX2q0R1qpNLBJiFtXbm+Yju2bSOnyOr1cyCnnKfnffdgDwz+RCLQhzKrsRcmebKx0s
	 ukrFjsjodXjy2Dqnf8SHmsZA7EukJmubi8GTQg2Ygi/lz/WTuaTG7NTSFmpi/mRlQci2S
	 l/S9KS8bbou5tzOVsdTqDieslrMHm8ZFORUbO8IlPK9X6KrLRXdVPtqAAuGTWc+BYkCaB
	 IcpN3HF9++p67Qy93P73CSttFxIswH3ej7PRog4nOR195YCgSnF5q0trp9eAHzFu9iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=bytlcDWN;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B767606A337;
	Fri, 27 Nov 2026 04:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B767606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=bytlcDWN
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jbKqk47kTz4yjjG;
	Fri, 27 Nov 2026 12:16:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795753010;
	bh=Tn5AlZp4PbwQpF51ff+Tfn5KuY+NWZUr3Vs73pw+2lU=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=bytlcDWNiVzSw1uoXLuaFFeNTwuAeJtpewm1xwcWS7OQtY3yaDf27t8KN2Pmwu3jd
	 SM1Y93OR3C3WZyr0NtxcfTvUNrHMNcQCVPHh3Fz5mtyfvfBT1CZ0OsJmIa8WBdNa5Y
	 DvMUSl6YPHCIDHG9ObuApk0of5vV+WI33/31vxrZVn+YEBCAw1ETMMw7ttQwvoRRd2
	 CxbndtpGTXuxXiHkTlRAxUv8CALKMJgRYJtuV7+HP2QKjJDDP7mvAjSPUQWN4vzhRQ
	 4rTz/SwJX1k1JAE42I/xIe+3R+TMH7qjoos4aXbU0Qa4/BWA33jEZcx963yydHaiQx
	 uqL+qZOePZKLg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AR4Gfk7090025;
	Fri, 27 Nov 2026 12:16:41 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 27 Nov 2026 12:16:42 +0800 (CST)
X-Zmail-TransId: 2afa6b09042a974-da2be
X-Mailer: Zmail v1.0
Message-ID: <202611271216428215iKcoBY8ZqGeX3UOjPGid@zte.com.cn>
In-Reply-To: <179442121138.44545.365837636476170108@kernel.org>
References: 20261107160747079LomNfOJeeu6knwkNqJYTx@zte.com.cn,179442121138.44545.365837636476170108@kernel.org
Date: Fri, 27 Nov 2026 12:16:42 +0800 (CST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <lee@kernel.org>
Cc: <mfd@lists.linux.dev>, <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <tharvey@gateworks.com>, <support.opensource@diasemi.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzVdIG1mZDogZGE5MDUyOiBEaXNhYmxlIElSUSB3YWtlIG9uIGRldmljZSByZW1vdmFs?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AR4Gfk7090025
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 27 Nov 2026 12:16:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B090432.000/4jbKqk47kTz4yjjG

Hi Lee,

> Can't this be called after da9052_request_irq()?

Yes. In v2, the driver requests ADC_EOM first. It then calls
enable_irq_wake() in a separate statement and records whether the
parent IRQ accepted it. This removes wake cleanup from the ADC IRQ
failure branch.

disable_irq_wake() needs a matching successful enable. irq_set_irq_wake()
warns if the wake depth is already zero, so exit checks the recorded
result before dropping the reference.

Thanks,
Shao
