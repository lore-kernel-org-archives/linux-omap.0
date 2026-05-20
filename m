Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1224EA90
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2026 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238016; cv=none; b=lUctIDZ3qzwYjfqljFYoNMSVRgKznvcpolDzzu2UOhCRE882KSV4Cu0gHnpAj1mUdLHf3ZphItHdTBhT5/NfT0HyXiO+36yW+so6CTXzqSq6q4klpSql8ZTq9U08rMj1VL0kPvjcaa/jXVGBU7geNh4ucOThQCPi5XCPhTAW0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238016; c=relaxed/simple;
	bh=y7Fn9YFogsp8mpT4ZBz1BT2lYDSCTlD71c6vafu4GrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D478fqksCfHzHghzIztLFJ7xJjjElLJkzSijnY3K+bGy0UamkO4CcIIM9izqeowg93G2h67RWVBpkFiIzQsItTbtL9k0GVk5hqsydIz7/2GUk48YP4CqoLCRNCAhVcPScucvo/P7fbHVKmIApLyqqAvqP9DOzC1Ztmz+Mgt/NbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi1gK6X1; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi1gK6X1"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c19d23b19so5854138c88.0
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779238014; x=1779842814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0ubYMzKkPwIELjCKI6Oon/usrmm5Tf+jdhwqr1a+Dg=;
        b=Oi1gK6X1wdaa1laIRBm5oaQHz3rdc+QnZbBsoPKdvwfxGp2l8ejVp1ZHpXea7gwW3V
         I3Y1u9ZY8gY2cnslCLHJ9TiYdgcTfRg4b/PHNzHKLokzIvZKj83WGrEbwEKx14dHDpPr
         /tm9sRYECBzfepI0NS37n0nluvJm58OBptAiqp+2EBtaG7dVjH9oRNc8VGXvTP8RBZWP
         ZmPTSD/3QGURGt7d8HArEtLhx0WsWJnXNSZnGriaSxas7II/3JSfZ1O4sdWujXtFUIn/
         DpyYf9Avp4sTN2LXkdE7DpevYGGjWKQlM3AKzSfNoXY/AVhyKVbp8xv4J1dbqCXmQApm
         PXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238014; x=1779842814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0ubYMzKkPwIELjCKI6Oon/usrmm5Tf+jdhwqr1a+Dg=;
        b=n9sRJCeP3PFvTWKuVDjDvOaCzNg/jkZX2kPrp5GZ1s/xEmJvcAOBoOUueo2ffWpbPQ
         yNQCtXZNv+k9h0H+qpT4epSFJimdicy3HEI9Vdq5QxzmFj9+e7ez772KXpE+9pKF7WR8
         IjcvUq+OAiBNdsPKQrTbpgvc/wLyryDETVvE+y6HHw9a1DkUXKSS5LYJH7Ysym+lXVjA
         H0GkZeMbjs+MegmasLwpZP+yFvxAB1qPb7sWfSfTu16IL3l+pVmnFOfk/QE7iGJHzMBu
         VEnCkJIIqzzjG77fkyNlxi77dKpkE0gOdUoqHR3TQM3EgIqlxLhlBMVWZljFBblcklg5
         WCBw==
X-Forwarded-Encrypted: i=1; AFNElJ+y8zD2B9+XXhLwLT8APuoiCMF/xeo2666fDmk+sYmLKbi4GpNP5HcaGhNL1+JnRN/YWflWX7E0o7fP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9kwyeIYMsWwIHgJErQPQe+2g30P4Hq0Hpg3NzTKMXB5CmjOOn
	hDdmUyZi6V9VIH5wvkU8oAk2WmmQ3kGR63T2cRgswZDlu44LY7Ii1tiY
X-Gm-Gg: Acq92OEZW2w+88o60t6Q4nv92bvXTCuorhB2zW0RfE/rFMk2gOz7tuAj6tonh4+0PGH
	Kvchi0ZdzqnzSTCmuXp5kmljgNnHxK5GK7BnB9t+0WS7T9MSOEz0NigszT3XvYNo3coJAeiEjw8
	wkgNwIVp9v3U0nadSu4+uihqdJQqxSx9QIXAgN0tenggGLos3oZZjDUy5O+z0Tnwd8C+2r9JoQK
	rbmzb76ZUefad+zJ33EJ+YaVttj5eCyadadTZHGYCz4kwQup4/wHMIdwjrY6mEUglaiWBmOEm5Z
	+Dtt18BxnOsWmUiqTRowGcsS3lTL8OILLHZKjGuVrXX9UbR+3b4OMjkax19flpdi/ZKIWC8Enb2
	9ZwWlc3+5X8tcO8bntcaYXLAW3RrQp0GWOrm6yLLr0/aFO1T7JegYAW8yryMkUnZIiDeDBM1R2f
	Kf35llet92AKcSK7jKsB+2xFi99OOkgIfI0tvrx2Mca8t8UcJvIdbqNVBXtxsBg8v8
X-Received: by 2002:a05:701b:271b:b0:135:da70:c2d4 with SMTP id a92af1059eb24-135da70c454mr1271166c88.25.1779238014087;
        Tue, 19 May 2026 17:46:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7677:c3e6:c92a:e780])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm25928705c88.7.2026.05.19.17.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:46:53 -0700 (PDT)
Date: Tue, 19 May 2026 17:46:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpio: remove machine hogs
Message-ID: <ag0Dn66ZVnbTc7J2@google.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
 <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>

On Mon, Mar 09, 2026 at 01:42:41PM +0100, Bartosz Golaszewski wrote:
> With no more users, remove legacy machine hog API from the kernel.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Argh! What is the replacement for this? I have patches for rsk7203 to
use them to get rid of legacy gpio use, like this:

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index f8760a91e2f1..5bbd3b31cffb 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -12,7 +12,7 @@
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <asm/machvec.h>
@@ -165,6 +165,19 @@ static const struct platform_device_info rsk7203_devices[] __initconst = {
 	},
 };
 
+/* The base of the function GPIOs in the flat enum */
+#define SH7203_FN_BASE GPIO_FN_PINT7_PB
+
+static struct gpiod_hog rsk7203_gpio_hogs[] = {
+	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_TXD0 - SH7203_FN_BASE,
+		 "TXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
+	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_RXD0 - SH7203_FN_BASE,
+		 "RXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
+	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_IRQ0_PB - SH7203_FN_BASE,
+		 "IRQ0_PB", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
+	{ }
+};
+
 static int __init rsk7203_devices_setup(void)
 {
 	struct platform_device *pd;
@@ -172,12 +185,10 @@ static int __init rsk7203_devices_setup(void)
 	int i;
 
 	/* Select pins for SCIF0 */
-	gpio_request(GPIO_FN_TXD0, NULL);
-	gpio_request(GPIO_FN_RXD0, NULL);
+	gpiod_add_hogs(rsk7203_gpio_hogs);
 
 	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
 	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
-	gpio_request(GPIO_FN_IRQ0_PB, NULL);
 
 	error = software_node_register_node_group(rsk7203_swnodes);
 	if (error) {


If there is no replacement maybe we can resurrect this? Or shoudl we
have add swnode support for hogs?

Thanks.

-- 
Dmitry
