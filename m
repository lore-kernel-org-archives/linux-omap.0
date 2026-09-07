Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202761FCE;
	Mon,  7 Sep 2026 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748512; cv=none; b=IQA7t2SSBnH/rw6zNrJ13erUXTyzQ/w7M+l6JkC0EHUBbfPf8/mTRK7ix1F7MK4+k/x9chbaRodTbR8sFXjnyMd843y2w58507x/eTQHtWDoGl86vP+EcZVhmJGaFQo0qSk+/1SHKPuvwFe76WwR0cwS0deizyabwtgceoBgWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748512; c=relaxed/simple;
	bh=/n3xihmU93G11KDPuXpxUGjTF/aZtrqDlguEa+obsXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dYWPRRvKZCjr7BvOaSj/COVItThgcKi19y1DocWtCsjv9bly1SAVbtePH8Xj96vPdiAdqDQdjffcIsCecv9sTaQK3IP4VdH2QmU7CdkV/UKfMVf7yoKSk2eGFfN11sxv306t3cbJdUqrI+s4nRS9i38ANhEmabxIABiDRJ7VF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=GxCkksjY; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="GxCkksjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788748492;
	bh=/n3xihmU93G11KDPuXpxUGjTF/aZtrqDlguEa+obsXQ=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=GxCkksjY9QSu1j724vj4L5cIYhn+weJWoDDJfKVb4du5oPW3kXx+NoGp/fgmQUrco
	 4v3nL11D+YIgUqyHnTVcgWZ+s8uNLUbk5Rp5bcD0xQJzpX9C3yX/9dPQqDDxWlsF9O
	 dgWnCipG60qs6j2b93klLpr4qnwiZhotHcqPG9c0=
X-QQ-mid: zesmtpgz3t1788748484t9bf26c94
X-QQ-Originating-IP: 7jcO50RqRIZxPHY/moH8hgYnotivvrpyVTcywJ9C5gY=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Sep 2026 10:34:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9707735077275929228
EX-QQ-RecipientCnt: 59
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c3446b7a882d909a1fb5e6c3d06e6abafc7af191330f8ccc8edf46454865;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 07 Sep 2026 10:34:37 +0800
Message-Id: <DL8QEYABXVMN.2CF6XXBXZ1X6U@linux.spacemit.com>
Cc: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-omap@vger.kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH net-next 25/33] net: spacemit: k1_emac: Remove comma
 after sentinel-entry in match-table
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
 <mailhol@kernel.org>, <msp@baylibre.com>, <florian.fainelli@broadcom.com>,
 <jonas.gorski@gmail.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <kurt@linutronix.de>, <hauke@hauke-m.de>,
 <chester.a.unal@arinc9.com>, <daniel@makrotopia.org>,
 <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
 <ansuelsmth@gmail.com>, <linusw@kernel.org>, <luizluca@gmail.com>,
 <alvin.sipraga@analog.com>, <clement.leger@bootlin.com>,
 <justin.chen@broadcom.com>, <dlan@kernel.org>, <rogerq@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <rjui@broadcom.com>,
 <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <opendmb@gmail.com>, <andrei.botila@oss.nxp.com>,
 <wangruikang@iscas.ac.cn>, <amadeus@jmu.edu.cn>, <kees@kernel.org>,
 <tmshlvck@gmail.com>, <c-vankar@ti.com>, <horms@kernel.org>,
 <vadim.fedorenko@linux.dev>, <daniel.zahka@gmail.com>,
 <nora.schiffer@ew.tq-group.com>, <v-singh1@ti.com>, <oss@vassilevski.com>,
 <haokexin@gmail.com>, <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
 <lgs201920130244@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-26-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-26-s-vadapalli@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MMgPz8MirN77HIyzHp1ahfW3FEkNnOOVFbJ5/WFX1TRhdcNMqGuBvXYc
	JZ+G+7a/pUpoInAiMLi2eBtOasfCpvN3trpZGOajyLKAhi4srDsz+cLzbQ0LsvrBB6l9nTX
	VO1ZggVEft0dcSq2Tw+GIzci2TgAXSaJsbPhpXxtLd98VQYINWREGy3DDPOdOVpwupVmdGA
	ymQ6bXCX4i1lwSKvZKVAkObe/ZSo6w8ERtzIgGz7Ci5pfVsTxtsXR81WFC4FZ8/qQgQWD1q
	76TIZuBU+3lwluYzrtWdGULsFpS+ZiQMSOb14J1iuouDYkLOwW0+aiEWavie4rWjgFajEBC
	I4wUQCZPKPDdtgcVHvvoOaGXHj2IQgFLigQmsITuWoOQ+E2Y1SYxINPyb9SQf7ap7xCULgz
	OL4JG3fzfCOfsx8kf47d6tpMqrLyCqeeW8sT3J5mcSXfo6bJNQxS8QiZwKGN58mmHmX3VHn
	+o8tGsygyVX+y2OFQSpsr40MnnB/lwVHK7OcxG/OPFzf+hr4yKhwmp64v9nVLoWGJO2KsLD
	5YPLQcGTpWGGHe2B94qDaERmLRozgGGIWwWxU8ZmKziTmu05n+/ZHSVvS0i2VX4FuYpTtd/
	SpcbxGI8i+GVExaxBqCQoriL+3HbVEJMlerDfILtXnoJNaWgjyZWAq9uBRkRB9PgGTYH9TD
	tAbtOiItPD1aA6KTmuvdMqu4K0F6kBZ2oRizc4mbJyxVrK0pSFdHHdYyZUTjLtdzIqsbGKl
	LUAeKkUNJVGgWRzsgNgPeeZY/zcQadq+jxD7oE55YLw4pFLHGAUKYFWrIZ7eLHK0F1n+jPs
	3cK9nZ8OHKk9OmXBL5saY/YLwry+mkuGUBSeCpU3zfCcsfpr7NHtBEq/k0ODe1xMwDRspJ1
	rk3BWOXkqoqG/siWL+Zg2zQgynFiy8TRbwki1wTFNWO8UlqRnd8y69pc7H2geeHKW4Kh1ha
	53vOEck3i5QUz/Y/gIBMTfKSMy/NT5hi2FhwIk3cUNgkrdfXa3NNtMHcfLawTD/tP/W6use
	RUDo3Cu75myzOE+h0GCY7NsO+UULlwRsAngH/ib6qhPq18KzsTaXjUzjQFHZdxh2V+kv/aj
	16vGbMw2WnV
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

--c3446b7a882d909a1fb5e6c3d06e6abafc7af191330f8ccc8edf46454865
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 4, 2026 at 12:36 PM +08, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

--=20
Troy Mitchell


--c3446b7a882d909a1fb5e6c3d06e6abafc7af191330f8ccc8edf46454865
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCap4ivQ0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvrKoA/jq66no0m3AM6WPip5A8SiOQeVPyie/PjbmRqO4w
PamfAQCtuus+o1dOGS/PPW44oBGtqifxJT5WcMspAw/AJH0KCQ==
=xCA3
-----END PGP SIGNATURE-----

--c3446b7a882d909a1fb5e6c3d06e6abafc7af191330f8ccc8edf46454865--
