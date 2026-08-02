Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F503921C8;
	Sun,  2 Aug 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674932; cv=none; b=G/e8PBzE5yZuujabIgeyRjdeZkNW2XDWXIeMyoeWDVKgBt6q4B8nAQP48cBrvlPiiNZwT3n2vGV+kESojT5Xd4V3Dz3ZRUm/D6a4oR9J1BCo0NX4oIo9Dy/pC2lMYAU4EXxhQ0sZkoRpi37r3/FvjodDxjRel0Tw9XKJOu518Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674932; c=relaxed/simple;
	bh=fcUesJ+cbxqnRcygxhmx9F4LBKQwSfB+AwEq9xDY9b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8GyH+xfat3oxlg1LidyPxrU9Ovk7jCpZs+E85k0a6D+cI3r4WyxCh0XRa7lM+b/YbTczqruRgBTjYvTrTN88zMZksgYZUbxiT64ij294k0/AHMzLcTG+vzX/pvbU7Qym56rz3HjLaV4OASAyiPK8++X05JGv+1RZdhz96z4G4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY8O5WI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY8O5WI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20041F000E9;
	Sun,  2 Aug 2026 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785674931;
	bh=OUxOKdVCoV/OvXn2db5tCOTNvZIU8mMbmKrWBDGbzHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lY8O5WI3kuLJY4QqwBLkgkse5x0CcYbWFbGFbYGXxDaXtnNtVmXRBE51zRGr+5k/U
	 tgVcIEEd31hOvgS1KIfZiRBb8lfWmCBcYfgi7ecOOg090r8EFjGLQGGQlYpdGWuEud
	 TEYR5l0yasZFeGTgCmis96h8X4UC2LS4KSrF7AfP0Y0aMUshlX4UjQ4nedyxrMU2OW
	 HPz0vmV+KLCBNnNbgAx2/BhtboPBOQRlYB2XGzZrBrjbwLVyM8sFtihtRcUuUwpnDN
	 EpYWApucNoiG5IiinvFEMG2i434/0dtoRRNOYHJIeLJlCJgIkzJS4PrUWIG7UPkmxD
	 GrpxNWBX2r0Pw==
From: William Breathitt Gray <wbg@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	David Lechner <david@lechnology.com>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Cc: William Breathitt Gray <wbg@kernel.org>
Subject: Re: [PATCH 0/3] counter: Remove redundant error messages on IRQ request failure
Date: Sun,  2 Aug 2026 21:48:44 +0900
Message-ID: <178567489466.1424502.9168659014739104167.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715135030.326290-1-panchuang@vivo.com>
References: <20260715135030.326290-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=wbg@kernel.org; h=from:subject:message-id; bh=Yp/nRD6Q9VnV2O9qfEnnLIcigA0aiAm8lDjh/eYL5MA=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFn5Nsuq3cRcvSdprNu8Xjz+5fb5UzmyuC0X37QVVGXJk 2RVzS3qKGVhEONikBVTZOk1P3v3wSVVjR8v5m+DmcPKBDKEgYtTACZSEcbI8KeEN2L5C66Tlw8r L5yoMVlEeqLa8/tT5fc073dZpWVW68jIcPvO2zO2iqtMLCU/zmk9rHZEjPVP1dlP7NZ3+LJnmCp 5MAEA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Wed, 15 Jul 2026 21:50:27 +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> [...]

Applied, thanks!

[1/3] counter: stm32-timer-cnt: Remove redundant dev_err()
      commit: 505d48c93896948c9a430fa96a303af114566db9
[2/3] counter: ti-ecap-capture: Remove redundant dev_err_probe()
      commit: ccd73fc6fbd775b4981855717f85b769f0cf4f59
[3/3] counter: ti-eqep: Remove redundant dev_err_probe()
      commit: 353b2e09f44a91e64c6b8117df46b6999c52e465

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
