Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF33A1C9
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778474690; cv=pass; b=aNPeYkepDJyYl9EcOQVu2iFjgJ0EmxvTPzoxWR2hOeLwf6P8dSqK05QUQhBLcg2VuVB05Ukado2lM5oDrCKlT/b6n2rzk4fW4/EPFJjYW/Z40zyOXrTayyQO8y5UYG7zLdAUqR61nmTp0JpWfRtG5JM5viGGVUBt0VyNynyOI7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778474690; c=relaxed/simple;
	bh=x6iEDyKbU5r3YCwSJz4uBEOlZegEWhKWqkzkNQCKH5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwwwvOY0OnRzte9tNulKOYMTxCRnEycAQP2//SIJyjUxQ7T2uY5ejVbEyBPnX27SKeqBKcw3d+ofQzX7UA5sXaK1/xullDpeoKfxqflmRUf2y/7nK+51a9rvKkFWzZSAW7/1gtdXOEe7HOLgspDFoss0XdKET/gukMFmdE+My9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQjItaTt; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQjItaTt"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3667cf0136fso2091703a91.2
        for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 21:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778474689; cv=none;
        d=google.com; s=arc-20240605;
        b=GIJikeAZCoTkOhF99QpMFxK+7m/L4JIwTGV0QFzgY0fQwcfRewoKpKawtVkjLDJ3/5
         Qu/C8r21EQm25S+EnGxgZPLka7gGMWPAXwqpNeakO0HsYa6ly8KZwYNU0hg2rNF1uNmX
         sLfMuly2Jf0rhF72pw0h+pfqnCF1BCJJFghWelmgUecN9j+7ej9mCUQMGK/ClQJQiceN
         0Me9JMDTiXg35dUi4PXJ7uum19PytYcQooK1+SpdJThEZfUFOE/7U7UODJmH2WMUjIhw
         26WDxIkXDyhk84yEBM/sv96FFMMGOycR5MjcpwaaGdDAJQTkP3+9ZcRwLzItMsw7VPTb
         8Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x6iEDyKbU5r3YCwSJz4uBEOlZegEWhKWqkzkNQCKH5I=;
        fh=MpVZuBId04pArJ6w3N2gIVI/onmCFDxRhxy6m9cQ9Ds=;
        b=EfV2sKU8x7q4cCayCKqIC2ILg5vCq4ObdEOD7eLCV8U/51kgTmKAPeIrn8dACqyyWE
         ib6Ed2imNALfBm4oJ3rdh8eyw+A67EndJgqzasgxZKyxn8gwfz3gOm+WwRVsO+AjDf1Y
         BXwEmp16otey5cC7F2YROlzjHh7qB/cmTSBtGFM3rQ+kccQhzzD+iNfw1z9wva1MrEN0
         S+p9qpf1Sh5CFTsxYgqwr3EQBeU0S2auvE6ldxCdgKOSR6X92N5yeTU3mqDId/RyO4wI
         veoxYPp/ncFvQKrG/Qy3k8y90HEhniak+J2ENzU5TMqq88QMiyI2hP32mRrXQovSv+Pq
         1KYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778474689; x=1779079489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x6iEDyKbU5r3YCwSJz4uBEOlZegEWhKWqkzkNQCKH5I=;
        b=NQjItaTtywzdOgJdhcqc1QTmMCkrQWH3Q8VVDUW9ulP8alAZ1S6f5ZZ/UuYTuvalfF
         Y8Z/kkvCttXHti0rtkSIziUMUyjCnNHIMaGfWTYlpMBjcQM+PAh2NwTxUV7ZQ0272pal
         GhfWCgncDxKntjaw8mj23XJOtpeLHmy1vf5ivCWQt7H7xCgNjwTknpUGlKnYJDNy5Xkl
         TgNfu2iy9mm1nGbbwcpHs5G5k/MX1bD+MdsqPgcnKjXLWfl5DGsi2+YnsoFyG2oSzgZt
         NsBNsVy7rLXRJ3992QD0QiGwEiPbWpODBElpsZClo1SFkYKK+LRRGdldUTMUZxukBbnV
         aZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778474689; x=1779079489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6iEDyKbU5r3YCwSJz4uBEOlZegEWhKWqkzkNQCKH5I=;
        b=T+iNp5YNB76vob77CB7Aw70mBrMPsRrU/L8r0j4zli83hNczh92MnLz4hKkYtSfZyS
         UWAktLoUv/82T2Rxkq/E/IwakzsYXAWu1BSJBCx9IyDQJgMpDr1d3mw7DH7TB1M3gFRY
         IbdCCo4d8vyfvpNuRBazPl2OGOZKjUCUrMsrapind5baFV6nDQAGUsH3flrlvOM0zAbh
         PnPZ43TmwDxShymoio1LG2cUrOv/VUiDLy4qmt5ZI9VZ1JadYRagAB0LvziYw1Rua0MZ
         R0nE438Sa158fmVJfPBzjMSvpEJSOnINB/kSqm4mzrwlNlGaQpbggekHsRs0iI9Mie8A
         lZZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Mb9O5/5vtDBjya8k1hOoiq61uvUPZJ0Cd6tLrftBpU8wonjZby0Ec4kfTUrvqQXxKhmkUjGO4kbot@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56igA5EOuzXDsl9YUdRBjFuNaqaXQeJLCJB5e6QPHXTV16F7c
	2/kPXA2tTQtV7IcAlbqYK95fiVjARN9QPJ+t43+xx9YN5c8VVfQIoW94pcqxvpNRh5aVj84TFYy
	fFl3kGXqGgfLY88jD24nxBF8cUiB+9Wo=
X-Gm-Gg: Acq92OGEXqtNAWr9fDTfZ7jLj7rdV4IUZYpZmpEusNFXmmY+XZJSv73h421lKayuAMj
	hEH0YRN9qzB3s+2brBRjPOqQY4lldA0tul0qdDAZid4vwd0VkY2fRWBgp5FSpC9aBzWFac4UQbJ
	X4SzI+fYv5XPPVeiXdmqxFhDI2zZlesfqOBT7bP+f6mxVVP/f63mUCuAMCOZDAiuigdUTBaqm0r
	aUDSvHoxjd501Jm0zcb/NFT6rO+yBBKoAi9q2v/pzdynlLGOtSmID0utUoCWaoJSksef0B+HMYK
	Z2MxjeZsSzgaYQRijQEuSuV8frZ3pDaxeI4hmA==
X-Received: by 2002:a17:90b:3803:b0:368:7a49:cad8 with SMTP id
 98e67ed59e1d1-3687a49cdf4mr866184a91.18.1778474688812; Sun, 10 May 2026
 21:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
 <20260508103837.138142-8-phucduc.bui@gmail.com> <af_g24kqkm4QhDuU@sirena.co.uk>
In-Reply-To: <af_g24kqkm4QhDuU@sirena.co.uk>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 11 May 2026 11:44:37 +0700
X-Gm-Features: AVHnY4KyWpKmL3bK2ohzxLh_6SgQsZ4v_ABThclEFDNG2VBuAo-Ds9hj8X1klJs
Message-ID: <CAABR9nH62K5qqujXzr_HwT6F0V1ezzENAVnjqqu3zrMvmCYWbA@mail.gmail.com>
Subject: Re: [PATCH 7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource handling
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz, 
	tiwai@suse.com, jarkko.nikula@bitmer.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark, Jarkko,

Thank you for testing and for the feedback.

> This function now mixes scoped and goto based cleanup which cleanup.h
> warns us not to do - are you sure this is a good idea?

I also feel that this function is easier to read and understand if it is
left unchanged, without using __free(kfree) and guard.

However, while cleaning up the code and converting the whole TI
folder to use guard, this function became the only remaining one
not using the new style, which felt a bit inconsistent.
That is why I tried converting it as well.

If you think leaving this single function unchanged is not a problem,
then I will prepare a v2 keeping this function as-is without modifying it.

Best regards,
Phuc
