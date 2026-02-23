Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151F27FD51
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856228; cv=none; b=OM5cxY2LZd+Xth9eHylxhUnKYNcvXkiwhigVLlmTo8sJEtdCBajecmINCGiPbMioliwQ0KuF0BgLrvV+xYNwinGgzNyh7XHSEyQR/Jag/RjTChFKAwSqqzjMYCpubqZNw/XNFJtNCkF4wfbpLu9x1Nw78eJqiLPcV8RSW1c8R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856228; c=relaxed/simple;
	bh=BPlCyTz8G/El4l0BA0OckJ22InPEejXQZx1TWREEqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9woX/lsJlH0/4+voTbcYY+/xhalysHPBidOSXVXArjCGE7ctgTgdGQswM3qfM4+8WVeld+uYvUeun6g6v11mnftc7Qyk4To/HROmoCulzc41cOQKO9xixEnV/AhsS5atyX0wFOkRR5Q6ZE2OubvVybROmuDBvCLCS/z5fk7vmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-662f5c5507cso3047959eaf.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 06:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856226; x=1772461026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLzVdK8lDfgaTPyV9xNjlD/1kxno0u/2SblofGNbVRQ=;
        b=qY23/Xv6TXwWYbKQTh97sI/t5fdlA10HlrFVZ7Q5KSO+jWGxC7/rC3SdfFUM7nmS3O
         WfXsXbKtaGsGw2mks18hQapiSrS/nUGW5sfzMdvlEFc039K6XRIW+HSyi8+fYu+BJBY6
         3Ptv6bVZKaCO2kNltsNa4oYyJLsgd0iWUXsDrU//BAKRGOrG7HYYxyWHfS80Kayl9bwV
         fJaWXAFu5R+QVLwp2y7PvQnRi//vLdHshhEps7WAzWy4+4vhdH3uT0dvHbZyEeOJvvDr
         tX6t7lIHSBF/3F0HpJzzQaMXEByakzI8PbIpeDYxXsfowLm+OAzPqbiibHZX11cCnGKD
         QXvA==
X-Forwarded-Encrypted: i=1; AJvYcCUGAwEliCqOQOd4IHYmBfHWfWHjx6LnwfXNPMnOL+9UAmu/gwmVndm0yr+7Wvs0C5JWu/aWB1gsq1/n@vger.kernel.org
X-Gm-Message-State: AOJu0YyXh9DjTzvLn65c/il4lGdGym20z88ITJTHwlNrel2RpCLmNowk
	ALPeQ8VXygl2Vs4nL5lMCJL9ZQEAf/g9LsV6zYStSn7is102Wg5UKBNPoqCHmTV3
X-Gm-Gg: AZuq6aKbgXZfK6agyJiGvob+2yY/5p4n+dAWR2bZSWKvIrKhpUN88rJbo/MBzhQpKI0
	2O3lOOGsM6Y73C0SXr9KWp55nhtD1dQt3Ii4zwmSX35WD6tI63T7HaDq8kuoxv/CYYaYyLf3yJS
	h663+cxFzbsuGQP0n4gCkt/vu68TjLdiLY5viEwnPQNCo4jNn4vcOwg5RPqkhvZU7x42b0jS24p
	6s0wc8mNFC2vFUhxZFMAzgdzkNxvb91LLJ9p8jCMQwcdLUYWjRNataAXrw82omzJ4W3oESOL+Lh
	I6rSRYXVa2JV9IIqyim4doD5MmpzMZza7qD1Dth5NII3uUdop01mTV+MAi/pQF4fOK+4s7kHd/T
	9cF/rhd4pirWvJfCz//kbe4TOP/etFuIMDrA1aE1+WB+tqoJdfN/FzNUeBPnxscb27DXc1VYHtR
	r7hHqnD5qxb9+q6U1xCYkdlZH0PtYtzORd2yhkVLtz59UWF6kfkoBGyGIKvQD6
X-Received: by 2002:a05:6820:151c:b0:66e:7439:76ee with SMTP id 006d021491bc7-679c4621578mr4464498eaf.75.1771856226307;
        Mon, 23 Feb 2026 06:17:06 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c564489fsm6364628eaf.4.2026.02.23.06.17.05
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 06:17:05 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d18f80b5c2so3732686a34.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 06:17:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWESbbkAktMP+rGXKmOTFhHUky+uWE0N6cbiKdHrdOeW3ZEZ2P0bkIM+kRIer81cE0/nnUqLiLL3Bmb@vger.kernel.org
X-Received: by 2002:a05:6102:38ce:b0:5ef:a346:a020 with SMTP id
 ada2fe7eead31-5feb2f081dbmr2742454137.17.1771855750377; Mon, 23 Feb 2026
 06:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Feb 2026 15:08:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJCc-UeaJLM4dpDN=toDvteXFvOFpTm5AbvNoKf3rTqA@mail.gmail.com>
X-Gm-Features: AaiRm50V2ONm2B9njU7ZJRcOuR4Nb8zI5Hsqj9aPxNU6M55eyuOZ1HhwjvL4ass
Message-ID: <CAMuHMdWJCc-UeaJLM4dpDN=toDvteXFvOFpTm5AbvNoKf3rTqA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] i2c: configure parent device and OF node through
 the adapter struct
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Mon, 23 Feb 2026 at 10:06, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> Changes in v2:
> - fix a NULL-pointer dereference in gpio-rcar (Geert)
                                      ^^^^
I guess that is bound to happen when a GPIO maintainer touches
the I2C subsystem? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
