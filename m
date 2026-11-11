Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423224;
	b=cpfD9XQnzMGZUScUzKzpzNWxDUocgkHsCIDC+XPFTTdpCJxO0zPshOv4h2aPGZv3vvEz
	 WSvvB3OKw9YwcnXL8hEi0P7oD6JOYdqG5ZOfL7ysD6ygWfda2J5gZEy7MRga/5WQ/O0UA
	 oa5Wfo31dayFbVqwHeW8eNRfHhIdLYWeO0RcqA1hTyYOC2cOoEqYqH5QC2zy+qf7xeBId
	 Y6RmK1LGwJOfu/vC+1omQvHvAOT3b095DmMDVwBrqHEmwPrBp8CPa8avVcK4KcAy6hZ80
	 SxAjEAEo5ndd+BY9b61FA5VEZIW6hte7ZGA7WpjDIGOy/mkzzg5RUOR9jsn12Mph/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423224;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:In-Reply-To:References:Date:
	 Message-Id:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Si23Cdw+88yw6pqUR/7fsjr4pWg2ZSaJ05QthoDW2mk=;
	b=Q6pa/U3IkjQVGXSgxBN9NzjHu1t2k0BIAcvZOZfRl/Ay9yILlq8vkZ5xBGortA3fj13G
	 /XsdTq1xOua2XKGzVCLvgx2xe3ZUaOtX3DsyCNIFiei5nu2JM0QqSlfBAMJJ9HuNvITI6
	 oM+fPQLgIztp8xxhsVnd47qE3wUQPWiVtujaeiC0g0tzZziogBVdxf5mIlNE0ZquqpXQX
	 YLdNY3Cqofbx1TEvLK5fwacMdb4DtGG4W2m4fQdR5IrWoDbLh/SpzyEZe6UCpbSXkcmO3
	 aRc05lmFHKJZF9/v4dDYPjT+Kl0jOS2qCY5Gz30JB0JcvXQiBb/sZGngV7JXKn3Ht9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdP5A8QW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50D606A333;
	Wed, 11 Nov 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdP5A8QW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0351F00A05;
	Wed, 11 Nov 2026 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423224;
	bh=Si23Cdw+88yw6pqUR/7fsjr4pWg2ZSaJ05QthoDW2mk=;
	h=Subject:From:To:In-Reply-To:References:Date:Cc;
	b=MdP5A8QWIXv3Xnz91Fb/2r1dtKWDIU32pPPNV516cGa/2g31ZyYXYHI2K51JYX3Oz
	 BPvRlJUdHosTAAKsd5qm2Oa9lWbd2MlHt0oF0Pd9qyU/l52Wh3wklME4t69oaQh1lw
	 b7pEaDGRk+wboDUgsyYQyc+/C2jN54gjsqHXrQ+X4QSbuVit27utMTFsJQwvnQCWqY
	 TfYIWaYZ2nfB7E4+bEiCGHVdxCPiXRuSmf/eh+vlF6nGxC3ApuX7Kf8jsNiJEtsz5e
	 CI2s3TN7EjnI4OhHD1Y8y6qlfbaAmmVdCg3aT1mHLsz+/4LfAnkx/5Em2nIXuBlh5M
	 Gnpf9j/gUSbSw==
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
Subject: Re: [PATCH v2 4/4] clk-816x: add sys_ck clock as sys_clkin_ck
 alias
From: Brian Masney <masneyb@kernel.org>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
In-Reply-To: <DMI44C1VHP3L.1B6WSA5BOI6BY@linaro.org>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-4-dc6bf0fabae4@linaro.org>
 <DMI44C1VHP3L.1B6WSA5BOI6BY@linaro.org>
Date: Wed, 11 Nov 2026 13:53:37 -0500
Message-Id: <179442321741.1131744.1980930320808367339.b4-reply@b4>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>, 
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=lkHq36sWshuuYUsEuFbk5jFkEQeEYcWdfbZNyg1FZqE=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK+7Nwo9SfEZdU1n95l0V/Pb4qYfMhYu+jhiw6Lxyr7e
 6O+/93R0lHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEpL8x/A/M9WPrTg9K8Qz5
 7ykrW/yg/OXtLQv7nNef2lL8242zjoOR4YDwZLlj/Kanoosn7QqWcePco+Cw185hxynZsEWaUQG
 GPAA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Ettore,

On 2026-10-30 11:48:58+01:00, Ettore Chimenti wrote:
> On Wed Oct 28, 2026 at 4:53 PM CET, Ettore Chimenti wrote:
> 
> > This patch adds a new clock alias for the DM816x system, mapping
> > 'sys_ck' to 'sys_clkin_ck'. This change is necessary because the voltage
> > management driver searches for 'sys_ck' in these systems and fails
> > without this alias. By including 'sys_ck' as an alias for
> > 'sys_clkin_ck', we ensure compatibility with existing drivers that may
> > reference 'sys_ck'.
> >
> > Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> > ---
> >  drivers/clk/ti/clk-816x.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
> > index 3b8e483aec92..fe6f66fc5a05 100644
> > --- a/drivers/clk/ti/clk-816x.c
> > +++ b/drivers/clk/ti/clk-816x.c
> > @@ -57,6 +57,7 @@ static struct ti_dt_clk dm816x_clks[] = {
> >  	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
> >  	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
> >  	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
> > +	DT_CLK(NULL, "sys_ck", "sys_clkin_ck"),
> >  	{ .node_name = NULL },
> >  };
> 
> I'll drop this patch from the series. The proposed approach from Sashiko
> seems sound and I just sent a separate patch that implements that.

Will there be a follow up to this series for the clk subsystem? I don't
see any. I haven't gone through the other patches in this series. Or are
just the first 3 patches here what needs to be reviewed / possibly
merged?

Brian

-- 
Brian Masney <masneyb@kernel.org>
