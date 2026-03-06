Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D729992A
	for <linux-omap@vger.kernel.org>; Fri,  6 Mar 2026 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757093; cv=none; b=ThhYt3HBPHGfsc+lSZEc9syjM6lpauO3a20aWHVP2e/MEvIXRe9aiS0ikFFseklw1wP9rgAb2rp4nyefPn/YAIyklZLurbIqyKgznuL1WpGqJHQi5isYmp+pqSlzow60dIC/oAlBL09giYqL5wihesXRmtZffVLDIaOBmD371HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757093; c=relaxed/simple;
	bh=xnN0vutjsPKGswOUFl0+fS+UaXwilttvAUBkhW/dWfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3h5AAzWAYm0MI5CHVWYppBiNPY4jHnOAQ0LVmEQFHp9twY7iVXnWmQUePna2lTZ6u9lb6MHliAz4qLyyaUnEh2M2ArHkGregs3zIRXVimjbcVwUZ3HqnVO2QAcM2YMAxldZzhoNIudb16C0WgA/PRSCN4Vr451hR78X4tlSxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829928e512aso508968b3a.2
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 16:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757091; x=1773361891;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xnN0vutjsPKGswOUFl0+fS+UaXwilttvAUBkhW/dWfo=;
        b=aXqWQjRi9ofrB+6/8V5rxXWz9kYjJR0Lc+Yoo3SU/TNyahVWGySBdmKHcfwW+Iw1zH
         ViOHKuZGbD1JpCK5hzYOOgiYQwpjXuuu4c7R1hvP9HnlQtcnD6mNprJr7RsThUjMBALj
         4uQKDYP026JtZLzcnkYWL0cTKALrJBFa9DdFgHFrdGkZYT/s/hF14gQeCpmN8cUDBH5L
         xxyd0+kKPofG8FC6RGzCyEU3LaUgv2jI1S+nabziTpJxc0hptHrL/IZkCAo0mb+E/3qa
         8ZdKz9lMHHxIHRQKM5NwPlEIA4XgkahHCOEAgd79M4eCROtye5b7Bcd0lEdZB4zV2sHJ
         DkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ148CLQQUN//4tZxTi9tLAyf0TJms3AOi65fj4QWrAW69nhdGWxAxzIzrQCUuu5dX1MYVMYerfSAb@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRSiAaF2lIcLrRGwvXB9NUwd16pXOTcHyYN+6hEqL1mNy++CI
	zOMmLzxmH/9l1qmTyElnyzXndtMjjg8ymmpKt4ou5lAGN3Vn8Fw/R9XLCmfGNjaGziY=
X-Gm-Gg: ATEYQzw1ETSeDyzlvr+G1XXLKFD6iVz4wf51o6Ov9l50eQElp8ld+hHGiTyfeUCxhmW
	nYdA7f1UXfxkgvUDwvhSuJ4duDpjf9jtK5vriUwVqrslukCL+/7Nxguw0CqAaGU5N676uZ0bQac
	Q56kJ7eAsIttPbyNoQldGu5vHAQGfkyDMaOhDZnhnTv3q2A1EoFrKLRGu0rifbTVVyEZvpd47o0
	r1M42XaqBF2S9OciSWeNbJskdMgzAxU7s6S9CEAwtSo6BTSz2hJdK/OoLI6z0RZh8E13SbRINuZ
	A4fqf7lOTmgR3/4WgZmqyVkk5Epxw3kfYyQjisn6y4sP+Ob8kOejtdstcD+4KM/emzGV/aOuYnp
	Lad3p1QO8HOT0U3MaDHLTM907WuGg/MAe3PJL6I9TvmdshMDGY+qmpqwY8MWiGt6vXaIgRGnFWO
	NxL26C4THgLjAkaeeTgvwS
X-Received: by 2002:a05:6a21:648a:b0:394:a026:4c45 with SMTP id adf61e73a8af0-398590af801mr378595637.48.1772757091559;
        Thu, 05 Mar 2026 16:31:31 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738e39bb12sm3130654a12.32.2026.03.05.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:31:31 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Aaro
 Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede
 <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
In-Reply-To: <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
 <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
Date: Thu, 05 Mar 2026 16:31:30 -0800
Message-ID: <7h1phxpzml.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bartosz Golaszewski <brgl@kernel.org> writes:

> On Thu, Feb 12, 2026 at 12:46=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:
>>
>> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
>> > Currently the board file for Nokia 770 creates dummy software nodes not
>> > attached in any way to the actual GPIO controller devices and uses the
>> > fact that GPIOLIB matching swnode's name to the GPIO chip's label duri=
ng
>> > software node lookup. This behavior is wrong and we want to remove it.
>> > To that end, we need to first convert all existing users to creating
>> > actual fwnode links.
>> >
>> > Create real software nodes for GPIO controllers on OMAP16xx and
>> > reference them from the software nodes in the nokia board file.
>> >
>> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.c=
om>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Aaro, Janusz: Can you please pick it up for v7.1?

I can take this via the OMAP tree once I have confirmation from
Aaro/Janusz that they've tested.

Kevin
