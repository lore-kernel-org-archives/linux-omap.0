Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED741E6AA
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204097; cv=pass; b=AUyGmmiv0LgvPzc1wDywHf/OkK0PfgLedFMsOzXOj2Rb7KhIe24lGl21h6umVdy1y9bVqIpuVLXN5yDGqcY0t4FraOJAEYKkNCRnW9UnEFLckOxd4IKDf9+a4u1u4LF2PfwYRY+dGAK2PqHe+VLxo6sZoIJtctbF+T4qrtr+qH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204097; c=relaxed/simple;
	bh=lcSEEoLh9v8Xf7iYjsafpgfNRcSeRiODoC8LvbpDzQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBIyf3bgaw4CBhl9DRvxW8pTe1MQw1IJYU9Vo0X3OkboQ0jlIqk2Adss4kFq83bFFcwDGqE3dn+qpUIv1RtjaG0qwaVJoWhT1fbdL7l9JksLHzWnk7Uve72qg3z5G40j8RjyGbA9JH5VQaoK4rSbnehxeHwucQbB3wUkJkq+qgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMiUaowT; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMiUaowT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cee9b74ee1so30790625ad.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 05:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204071; cv=none;
        d=google.com; s=arc-20260327;
        b=iAurVUvponirhqZfHwIatRjMMwZjfESwlUkdAYEWXe2omky4hcVKGyiq29wbcm7y9X
         eeqUai41Nn5yeTQZrDFVOWfLKowWV4H/onkk9cbDa4gNGmP/3TlCeD7nLXR8p76t6a0D
         C8GJQLU9LH9Y25ajFXFNEd6IKJKvAMbpTqFpYTWEA3Y4M4KkX8C+7/pwVwT4q95koG45
         tSB3I9AHutmvfV3yOA90fnTdYxtMMCr4YrCQ0wc0h7pSb3ZiRPB5DjTs5M2mi/BCC4WH
         qQb6pyeQ485dmJIYe7F2DTXugSDjjmmi42j0oT48PFZO8Fz8XaR6OVPjKV9lB/pn8PwD
         fU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ug4bYKwXfbQT2hm2q3vkYB4jylkefy17G46vSIaZJuQ=;
        fh=r8CAtFEwvsc3f1XdypYQ6KKtRtfjqAtCV1qs+Yg1DkQ=;
        b=Qwi+xNl78DUDB0SKfpEPbbjp1ZMVWy+UKase3WcCZBVBwPWTm0u4odfnnYhzDm2e89
         zZNE2pgL9myMhK6tJiL/3UC7HGxejd9PZleHu8shLWRURc5in7g+Q+xTGOYgWAp2otdp
         IfhEOaO0pTi0ojxKE55okFVN0klFLiNYeKFeNOb/9y93P72EatKJybxuDAvYcPacX3kZ
         w5e9p3yw2x7FCuWdRaKjGSoorLyMDRl6HAKJnh9KgnlirVf+2kHsMslORbOUdOhryg3n
         6Kt8fxRnaJGNZNw/gSlNK/P88XykmJS7EIxMGc9l5MnDXxrMW+7Gz483OMSsrmJ/3Y+g
         bJ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784204071; x=1784808871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ug4bYKwXfbQT2hm2q3vkYB4jylkefy17G46vSIaZJuQ=;
        b=nMiUaowTSepykKrgGQO6bsKRQUzY5Blsz/xJoszlXkdNX0bC3g1O4lXMRqu2wvEGKd
         vayJWqSCBblADgJZTHb6mNENpoHnBVBsADZxPxl6oxFQFNuJMO6TgVJndlDlI1Fi9qsW
         jGfkeeOb6jdnxB+sUU8exuUe8F59MQamX40euD/8EK/PTWUWfyyfct4qbUixy8jiBFr+
         d+fxXdhvTMHbk4j0XrBMkGGKFL+zQ5N7aj7TP0+qvnLHe3POZUDaa0ZkUq/BKN+kaE+9
         zuGkpY5tZx63bWwfn66hZgiwAX0ulYxXnTH6A1yeCCJcR7EE1KT/RQqylyOVnPDQUlPy
         YlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204071; x=1784808871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ug4bYKwXfbQT2hm2q3vkYB4jylkefy17G46vSIaZJuQ=;
        b=NbfsJrJFedjhHcC/KSVu1o8gch3b+2QI4iAwZFtvi1Z4BZMOY9QFQX8pLjf23fxKMx
         4Ge0a29w8B8S+b9LQ1jJTdtPHfqw/q5ZHctDIlBBAfI9onMo6t7Etfi7aCzKMe133MWn
         PPF9BCSmX52yIsa48j6l7F7iLFGhZJzjZ20IYEeR7zn9oq58m64CLiE9LAvm2JM49w1H
         45XnNZRKWDRcizOk3sgs0z/7R7FmlRlu/bTKD8rI/2pycowYYVEZXLAcJFLRXwKnhV6x
         yxOG12hZzjoxJjmGsc/0p5VxnFq64GwUes2KjUYdpYs3Wuwq74d+qw56zBOPO4SFYbZ2
         dVwA==
X-Forwarded-Encrypted: i=1; AHgh+Roq6mTu8lUUzIP91tWlbqES6XRNRp27GeJwiX7pmkPvy3lNyCKmGTMDNJMLJCzSM9l31+nrRBTAL92W@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQ0GelRceblGoXRezE8/ssGCVPjVKW4zR2m3ivGZw1h72nwux
	E6WwLaTc1P/4gkGug/0Xce4ZWX7IxE5LV/pOuFzu6Xbg+KGqA6JGRGjkX+Z9p0khlzIjZn5ZhHS
	NhO463dLteQNzNpfNOmtB3+Hpb8cXcEo=
X-Gm-Gg: AfdE7cnKvR/PX0rQaLyt6fgo25GzSS6+PcePAtyQ0k2KvTxQgAcBFiy+lyOjNNHDNYx
	+rKSpvK2FtN5TgKQz3ITHcfuGfucx/ouG+u5hVu70okyMRGG4wjYnHMVsZx5Vu6UIfG1r9q62YD
	DlgX4MZFQPPWRjGttoiOyhRAxVUdejSD573IiMm0Yqycs4T/IDWjFLQf+RmPq7Vqm+LhkoLEEZ/
	g1Dn8bWm2q5FLFGMbjED+tF3lfLZmh8XXqb27ON9tPqK8/EdnkX8LNaHRXvX0Grb7/C44x0MHek
	X51+L6v+8wE3u5paL04GgumylNA4CD1e1GsM1ZUSfm184hGMagY=
X-Received: by 2002:a17:903:3b87:b0:2c9:feea:4e4c with SMTP id
 d9443c01a7336-2cf03ccd601mr69322415ad.15.1784204071288; Thu, 16 Jul 2026
 05:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716090829.72082-1-phucduc.bui@gmail.com> <20260716090829.72082-11-phucduc.bui@gmail.com>
 <3940b68d-da97-4e27-8816-e912162b6f62@intel.com> <CAABR9nGtoFmHjUcbhKxwY_-YJ_Kb++OVN8YkZKvkCMgBEHFjjQ@mail.gmail.com>
 <1d4ebb0d-816e-4176-89d1-065a7bae00d7@intel.com>
In-Reply-To: <1d4ebb0d-816e-4176-89d1-065a7bae00d7@intel.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 16 Jul 2026 19:14:20 +0700
X-Gm-Features: AUfX_myse5tgm1YTwzCHXWkFCHHBgR5UcKx6TYrnuC0pMv5Nn2uGIgWyUW240_I
Message-ID: <CAABR9nFHLzxVvtT+mjDyvqV0hNc5RdJiPKMab0Oqiwqokf3zcg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ASoC: ti: rx51: Use dev_err_probe() for error handling
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cezary,

Thanks for the advice.

> >
> > I've fixed the remaining instances and sent the v3 series.
> Another round of helpful tips: wait a bit before sending another
> revision.  What if someone finds another "small" thing?  It is rare to
> have a good reason for generating high traffic on the list.  A day or
> two of break is OK for simple sets, week or two for features and such.

That makes sense. I'll wait a few days before sending the next revision
to give people time for any additional comments.

>
> Also, please do include reviewers when sending updates - you've sent v3
> without including them (e.g.: me).
>

Sorry about that! I put your name in the v3 changelog but accidentally reus=
ed
my old =E2=81=A0git send-email=E2=81=A0 command without updating the CC lis=
t.
Thanks for the reminder, I'll make sure to double-check the CCs for
future revisions

Best regards,
Phuc
