Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF7225788
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151145; cv=none; b=LY4AjKbi/4gSVHwPDOAckVxTkYMqjuQxxudD4I/utaWeRpTl3pHpGr6VPFlAhe5UufNXYBjvLDk0em1ly5RNpm/9u1K952vnOTzDJZJQWEY0yhxqTc06wPdq6gqrh4l5odVrQDBLvyaNQVLkAfSkvjz/sJ+bIgJceee/OTb2PYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151145; c=relaxed/simple;
	bh=zdBBr15vHbzzK+y/RTD6lEdsU2YY966kOlrvNECGXvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcM7gGtwQJze7bPo21w5DddmD7jya9bQRQuxtyb3RTlavTM+ve0s+ISjH8Vn4qEd57C+JGDf+hegfcqVROmXKD8ONBzlrG6FkbstzsqrajYHhaTMc687Bv17FBmhqBqDv6wqsIuKHQk630c4SEZA7Zb5k8uTvpxqvXQZaNHm2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7XJXmio; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7XJXmio"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1393164eec.1
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775151143; x=1775755943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz8YcwWkdWOvxMK3RVth/0rCZCw77MdxTEXEAAB58s4=;
        b=M7XJXmioN8DtSRvQFuJzekcXon7Z5sPBAnc5ZyVWObahwDggIllT80d/KrE+zeHKQD
         Ro74QkgBm80nH0dWvU+hGMjEy/uouG0GvBjjNeC8MoLhYUqPTPby4BQ0R01oDh6SqK/p
         gOgFX1Ot4+k+Lfeh8Oqvj+mwL6m8YTFI2eS+Q/2RMeh2bh9dWOkte20/23AKV65Dlpw7
         VtlTZLMsowxMpzzE+iOXnsiriQb1AC3WnmLAEQmaTKMrmgTvgZwVN5Yx54C4Bv/sx9q3
         stgI/FibEHpuBMoaWTq9xByz5QiotpdT0BFwEdla/oN7tViWzqQDbUGT6D7UEUSsPQde
         0wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151143; x=1775755943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz8YcwWkdWOvxMK3RVth/0rCZCw77MdxTEXEAAB58s4=;
        b=kX7US8eQHLyIqXK1ShoABSICbKISmocg0+JCN05bcAfgeIxAx4cQRx7TYp+GL/9DUi
         L7AQeZSsc3g/bT3dmNIGgvQMT/r06oeCTvrjN7oNM3dliurpmQFa1bVJ87xixkd2OhBt
         uJeBJlDmxfba3PMi/kBN5j8cH9PAprtPMXMlk0HGwSF56j8gz2nqp47bPV/emc09gFKw
         kVhs4mC+ZqLYyCg1ilWJv0y8OTHyAsq8aszzpI8vqBS120QgzLrTUjz60jlpgtPKr68b
         zpfzEJUVroiPK0qOelZBh8brSYHocGpsZgsIG0+H5FX/BXw+iCcE0Y6hGFWjOsxIPOB4
         uDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUKnFld2Ed+YYnikLmeKo/hSBVTVOVuPsh8K0kq7rs+6MBszJnVaqngES9dBbgi7VW3h730lskSjonK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2EKK7FiJxfQMw3Fy4zEnefrL3Ssqe1HdzBuv42U5GE4Ste+J
	4VSvqVIFbEm28cqmo4QiuEdqjfvfj398fCwQnnl47I43/5x27jRdup/l
X-Gm-Gg: AeBDies3Q60uu6h5Af1HQZmDci2+O5XY44o/HuUyIeOwLoQYCxZQXpzMzn+016pzuF3
	55Dh0weA8XVd1UD4ZWJGI42xVFq3QzxVFyhqQtem1OqTVoMK/TEVTIAreHbx7mIVoLhFwDtMyZQ
	BspVk/sXiPpQn5fCiuGeTsgSZPtSgPuibytmefp4vVXcae3DuKmwOdUujMK6w5ACmKLhx8Hzrdu
	+JztH1OM9Bxu2Ft7D/Z9pHqQvA2IbrHZN/vuvU7yHT3+DwCt7FNmVHo3aAv6U7gk3jrjqSVEe0M
	d20bqYAvAUG/sldbq37HnYFQcbakumTbwbRwDpel56Nq8CW/yYuZHQGeQT3QXYY6ftg/FR/lj8s
	XyQKuJ3z+BLU3iSWXBFuXOeBiNADCDdpRulltqPfqKuX8/j0Sfl3mVy+IM1OpKiPINdDk/JarHA
	xYwSZxEW5swXR1gfynMKwTmuxKFPahypyOeBCGwd7dRMSrF6IQukzmv+3SBLe7zGzb
X-Received: by 2002:a05:7300:6da8:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2cbfc073927mr1038eec.26.1775151142569;
        Thu, 02 Apr 2026 10:32:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:902a:cd8d:1c0d:8926])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm3001257eec.0.2026.04.02.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:32:21 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:32:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <ac6n1p3eLVFzumbt@google.com>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>

On Thu, Apr 02, 2026 at 04:15:05PM +0200, Bartosz Golaszewski wrote:
> @@ -244,6 +263,13 @@ static int __init omap16xx_gpio_init(void)
>  		iounmap(base);
>  
>  		platform_device_register(omap16xx_gpio_dev[i]);
> +
> +		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
> +					       omap16xx_gpio_swnodes[i]);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to add software node.\n");
> +			return ret;
> +		}

I think the best and safest way is to convert to using
platform_driver_register_full() and set swnode in the relevant "info"
instance.

Thanks.

-- 
Dmitry
