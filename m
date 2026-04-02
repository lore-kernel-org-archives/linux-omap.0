Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D03876A0
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159196; cv=none; b=CbTuGZ8wSPUkWacTtS4F/a761EdFC17REhoBTX+gPpA8siQjPRMJpMm0XbRY9865c+lJgVV18GdQ0hlHCx1MKkI+YXE5yBVknuO307U4x4HxHbTLUq+o07uAD2NZvdfVHjuTBMOh3UA4/LnadsMG5ICHJo7IHTNXzVueKhFqZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159196; c=relaxed/simple;
	bh=a9mBHdHYjDCom9dl6l1w9FC+LnPt+WHcW/12owPHJL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3/6y/TOBbaElaI/Na8LFSDib3LVWu8dlWNL9iVr5RLIFUmetD5E5ouAO0c+6n+jo/KKScJOdBj9HUTJl5yllqjpe4tQhkgmd95jiXytApRuXdre6Wn2/2FzlaqAFL1S+IVI2u+wVrz8sYkDQ6Wmy+xuH56HCddClb6VsWf/qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNWJZBzU; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNWJZBzU"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12bfa7fe691so325196c88.0
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775159194; x=1775763994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofPgXZblW8ELQEADO7eYp8kSVBKt5eY0/Ab8e9t8nZY=;
        b=XNWJZBzUcvFlqSHkdNmUU260GOLZZyljLAE44u6iYkbdvzA4rvfSP4nBndQFMWezDC
         pwei9+uN9XO4RpYSGLCuk98oI5fdwd8WvisWQe1WXTmAsIoMDm6xarmGVYgT4zYmkan9
         rEd03LpxO1KP8cfDUDBrPXHj7X9bI8lvkd2TfYgKM4TsRceSTq/kPGZ56LYLIgv9pqR1
         iM2GPVT2KCjbcnSMQyxLts5JqFQtrI6yGLVVqLaCsFBsyMJicvdrtAssLw6rHCnCTBzR
         8SHg47pnb9q83GtpEBlNrMWst5xoYRx5q+n35ThaIi+1EiztPkE8Wxh7l72Fsr/XviUy
         /t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159194; x=1775763994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofPgXZblW8ELQEADO7eYp8kSVBKt5eY0/Ab8e9t8nZY=;
        b=dBlTLpUABWZwb64u/12aakUemCJumbvx8fYqX86lHQqwLRfj3HoxqS1bhvcDGjomdT
         m+yM9v6zKYq4u4wuHBy/Qc3kzZcWqhxZPQKiMdOib7Zun60TiTRZvCY9QrGwZQLG8Ded
         UKZjMJra3c2+/CBHmgSHvwNq8eSDP5aYS4NKecaO52AkIG8wdSiaxVmMAgDNYzWdmj+e
         GdZHmb2AnjhR+8A7vSZrYS91RQzWQ3xuCqsIGZKIobPMWjKHblHHF/VS8vm7pRbRF0Jb
         QCvDyVJbpwKrpavgLcbLfg3Njv973xwjlQaKUgIrAr2tku64SJYfSpPYf4JPF/QToGgI
         qUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfucRRhhXTp/7nTgyHm8Z3spPxL4pfrW28GBbBYahFU+UBv4rJnLAFvNu7IKZY8KUdHnwHC9pk0gW6@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBFgAI9O8kmE/9gmTmrcePVSjOgggHu1jo2eZNdjqPH8BKqB2
	jnWGXcUbbcEBk+A9KWjgIrk3NwYFu2Fl1FbGDC5PXWl2RS14D48YVwqu
X-Gm-Gg: AeBDiestHAW+1U078w2UdztdNNXDjU+WoKPFC7jIEPmoklQ5ea02HH0LqggAlBTBYNV
	pJFY9V8JncS1+O4871Q/br8AJYD1uIJX2hs10/mFclZafDfcD+45TxKXeQMf4Wc8EJTC1f+9V55
	ARln8XNP1jyS+jvKltooWBvyz45aURTbIaPr340BB1HB1khKds7HR7TaJ8MLgoFfs3a+DIQqTN9
	SjXJS6ZItT7/O0Qc2sDlALlh6zrcllLNJgzK1f4iO0sVkPoDMnmTo86fBHjcIuZzjby9piRhQ+/
	F8cxZbKlLBOIYAlCG9WFT82pAeZd71tUMz2XjygDOe3cpraQROQqHQPWm4moESvFHuKF+F3rW5b
	WuJz1tr0hKJC6w9y2rkDKN6NOPAFwNEMe/2jxXVNbl6EDZRB2dd7TUib6OxuLh6kXIzKpP4V3mw
	VTcOHUuZLH/z7luyIQpuINxS17N456cm0SUDfpj8xAYDuaaolLdpHRY+QxKYMa6v9f
X-Received: by 2002:a05:7300:691d:b0:2b9:80c1:bb5 with SMTP id 5a478bee46e88-2cbfcd4876cmr252532eec.33.1775159193940;
        Thu, 02 Apr 2026 12:46:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:902a:cd8d:1c0d:8926])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d331sm3349493eec.13.2026.04.02.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:46:33 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:46:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 2/4] software node: remove software_node_exit()
Message-ID: <ac7G9Vp68MgvV2rM@google.com>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-2-d730db3dd299@oss.qualcomm.com>
 <ac6XAyjxTct_WCEI@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6XAyjxTct_WCEI@ashevche-desk.local>

On Thu, Apr 02, 2026 at 07:19:15PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 02, 2026 at 04:15:03PM +0200, Bartosz Golaszewski wrote:
> > software_node_exit() is an __exitcall() in a built-in compilation unit
> > so effectively dead code. Remove it.
> 
> a dead code

"
In technical writing, "dead code" is typically treated as an uncountable
noun, meaning it does not need the article "a" when referring to it as a
category or state.
"

Thanks.

-- 
Dmitry
