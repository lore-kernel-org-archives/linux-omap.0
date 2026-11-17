Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.217.193.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942899;
	b=OBdyc0Ae9mGQAQTInN5pNGhOGDAhoJ8FZo/4R6wUUGtf6g0otb8AAZ+4yAqAlDQRWZDY
	 4nq6HTFIXtbpPCOxDwdkLxiLdroU4LCmT21RD9D2MgyR1xKgWVjfJ3KMJop5Vl8iGi01T
	 /0ZAckYfBCyEe5yuH5obUBUAJkIV8Np16xIuufL+t4BXuzrGHT7uSPeVZndLyc/yZMup1
	 Zl+GTBiwCG0i5jAAG1fHR4xOZgK9KtlLYSFvS+y1UQhSycOG8lv2Zl7MLdKt3xmfaSChH
	 8JjR2I93AnGPere6/uIP+UG7TBh7jeiwWcthciBQp1EnpTx8g7flVxyPmPkajS1yTZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942899;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:
	 X-Hostingpalvelu-MailScanner-Information:
	 X-Hostingpalvelu-MailScanner-ID:X-Hostingpalvelu-MailScanner:
	 X-Hostingpalvelu-MailScanner-SpamCheck:
	 X-Hostingpalvelu-MailScanner-From:X-Spam-Status:X-Spam-Flag:
	 X-AntiAbuse;
	bh=MM8UVOcHmL2MRTreb8kFuCzOb6vqab/wkeY7bKqiKLE=;
	b=tG9uv0yi+8R4HSFWfBYda+jHoS4zLEPN3iptflHGrYhoKqoyPtdiOigRMoL+0opPVJKo
	 EYA5NK7KU5wIVFc2PY+jD1W02T6LsPGdT32YladPk/zkwR+BKim9GIQL3Qxn+QgAENvWt
	 6TWH7OzDI6a85CI7Y4YFp6z/VqTSnZ2d7W1beHUo8q/J6pBQMtDbuL8aZ2Y1lx7XeBuyF
	 dDasimW/aX6iOp3R0shOBCi05w/ajzVGYbxg+I1yF3VCj8N6/XM/cO65rZo2LUTnaofqn
	 MiHxU9BBLawx56PGLywH32XQyCsvKCSjM/GZS3Jj5H8gyjUqyHATjSQ+hjaNRgYg/fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bitmer.com;
	spf=pass smtp.mailfrom=bitmer.com;
	dkim=pass header.d=bitmer.com header.i=@bitmer.com header.a=rsa-sha256 header.s=default header.b=IbKuYOtn;
	arc=none smtp.remote-ip=31.217.193.162
Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B61606A31C
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2026 19:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B61606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.a=rsa-sha256 header.s=default header.b=IbKuYOtn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MM8UVOcHmL2MRTreb8kFuCzOb6vqab/wkeY7bKqiKLE=; b=IbKuYOtneCgkjTU6wV/15i4flH
	cSh+pMebMxlayI/CZ5WvPs+oxjd23YFEwcZ1e9XnmFYNhXD+eztxZJjfmni014ffjitRY+uli/xT2
	V55058fPxuR4l2//fIooIH8KcPdBCXLTjvXfxvic9B3hWmCL2pxRqcfcUWIbutOA0LW1W5ewDLn+y
	zxs+do7dhXKAacOedkPz/20KTGQLvQbGa2IdjYuez9M8Ruu7rSTCL/A7rD0FJJVukYqRtTXFBBDnQ
	Y7VnhB7hbY/q+G8L83Ew0QyiJKR3NT2/yywQhQd8RC6lMVDtgiy8kt8b6x7BtHafdMW1blDRNvQbv
	PvqVSvQw==;
Received: from 91-155-183-156.elisa-laajakaista.fi ([91.155.183.156]:59008 helo=[192.168.0.14])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1xTOdq-00000008KHH-2V6J;
	Tue, 17 Nov 2026 20:14:54 +0100
Message-ID: <65ea5216-9c1c-409a-9a67-7053bbf07cd3@bitmer.com>
Date: Tue, 17 Nov 2026 21:14:54 +0200
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: ti: omap-mcbsp: Implement set_tdm_slot
To: Joseph Telaak <joseph@telaak.dev>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
 <20261116-omap-mcbsp-tdm-slot-v1-2-6c9f7aa45a29@telaak.dev>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20261116-omap-mcbsp-tdm-slot-v1-2-6c9f7aa45a29@telaak.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Hostingpalvelu-MailScanner-Information: Please contact the ISP for more information
X-Hostingpalvelu-MailScanner-ID: 1xTOdq-00000008KHH-2V6J
X-Hostingpalvelu-MailScanner: Found to be clean
X-Hostingpalvelu-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.711,
	required 5, ALL_TRUSTED -1.00, KAM_DMARC_QUARANTINE 1.50,
	KAM_DMARC_STATUS 0.01, KAM_MANYTO 0.20, TVD_RCVD_IP 0.00)
X-Hostingpalvelu-MailScanner-From: jarkko.nikula@bitmer.com
X-Spam-Flag: NO
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi ; Original Domain - vger.kernel.org ; Sender Address Domain - bitmer.com

Hi

On 11/17/26 12:03 AM, Joseph Telaak wrote:
> As bit clock and frame provider, McBSP sizes the frame from the SRG
> input, the set_clkdiv() divider and the rate. Only a machine driver can
> call set_clkdiv(), so with simple-audio-card or audio-graph-card the
> divider stays 1 and the bit clock runs at the full SRG input: 96 MHz on
> OMAP3, a 2000-bit frame at 48 kHz.
>
> Implement set_tdm_slot() so these cards can ask for a frame of slots x
> slot_width bit clocks with dai-tdm-slot-num and dai-tdm-slot-width.
> hw_params() then picks the divider for the rate, and startup() offers
> only the rates the SRG input divides to within 0.1%, the IEC 60958 level
> II clock tolerance. McBSP sends a frame's words back to back, so
> startup() also limits the sample width to the slot width and the
> channels to the active slots, which must be the low ones, and refuses
> I2S or left-justified with other than two slots. This applies only when
> McBSP provides both clocks; without slots nothing changes.
>
> Tested on an OMAP3630 board whose McBSP4 drives the I2S input of an
> ADV7513 with no MCLK, with 2 x 32-bit slots and adv7511 taking S32_LE:
> a left-only and a right-only 44.1 kHz tone each play at full level
> (96 MHz / 34 gives 44117.6 Hz), 48 kHz (0.8% off) and S16_LE are
> refused.
>
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>   sound/soc/ti/omap-mcbsp-priv.h |   4 ++
>   sound/soc/ti/omap-mcbsp.c      | 155 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 158 insertions(+), 1 deletion(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
