Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914901FF1AE
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846050; cv=none; b=tGnYgys8ZpzIp130sK8rQrkifKobZWtLJ977xt7QvOj2JP7UNvUsczdq496XY9J950Pcj1JTHZzjtkr6unqf+rMvXl/GoWHrlJ2xSe24bEAy9fHjYoTyxnAw8jA46/JPIKpxnOpqgUb98IzsR5Yzdva7xdC1zvgZCyWq+S1CE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846050; c=relaxed/simple;
	bh=hBZVDdPpMQpDklWtADNfHstdMtLJzifdgs60Z61bZzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUCs3GKMsYGw37o6OOrfBGlik0mB9g6s5eQSGsJd81vZXFb7CeTA0vNEhleiVEoIvLOUvnf7YnFQOFl/wdf6fEgIdc2pMSKJacXnLxcHG4UNic7uYDQ64VmJfFhy/YPjF2aBajtik4VLn86EVKB2rNAUicQuVBKLwcfz7mrZtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBmA7AF7; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBmA7AF7"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1270be4d125so6409409c88.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770846049; x=1771450849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCAnNXBnTPnzrp0yT2aXgF5x6Gf0n0VlTsKCX3JOXEw=;
        b=KBmA7AF7aq5Ae2X4Ill6LZqB3kNoE4ckXvAtfODtYqhMUaeIt2HpLwRrY886bDdYJK
         97GSadxGPC4l9o2mZrJxfIeqs6WRh1zZFh1nXuplDEepQdPR2uLLjr1rii+LkapGIf9a
         qzyiFWPTiPssNXTsl23WelosuZP+HPAF2+2z8tJSA+7iAyXLUZpxoFYTaqAuXJQA/1Xg
         lSggToDrM9+CUd+z5II6BmCu2J50hBkVLp7AtLAH44zb+UqyJeY60+qYs0sxAMkFwFbk
         KXKKM3o12IFP1jvjKos4mJE9PomxpK94XHdYNJrSh5CKgKBmKc3Cq2kqrEF+KPKly1rd
         CQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846049; x=1771450849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCAnNXBnTPnzrp0yT2aXgF5x6Gf0n0VlTsKCX3JOXEw=;
        b=OCCxQfX1epx2SdL2sq77Mx1NGY1mXrIbamfsHMlak3wl9qBTLzXBXaAzhN6Mlfa8ah
         CFvgFKokl0kvaqWbIecjd3oZbUuVMX5q2Ad2IbnNcPXUNTTHAMqnk94EmYrK62ZwcEyA
         VBQ3MW0w/iD6vtqFnL/9THstiSv3mAyIqM28N7AJvNQyEewXOwHJp48+I8s+kr9+i7VA
         GhmQy8wVG7uuLJhEdPa0t6dE3uwzS3miwiKXbqXWO0lN9Q+jPooemR4CdsXTRAbIpTVl
         MK+ghtLqOwGK8HWKlbKkh4HGLD/EGqxmE9tvdd8gEIVI6cWOmPDeZgpRTUvflOymIlLh
         GyRg==
X-Forwarded-Encrypted: i=1; AJvYcCXbxoyHdE7THeGpP0ud+MT2yJvbKtWBlKNLvuz7Dw5en6kwa1sWfk6un2cxc3+vnX41WzA84dvraW3a@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV5WuoU3oKgjbLHtVuMEXboTUEWG1uCe0ddFGvMNcyFyLE3X7
	clmlJcv2VpSToHduv8HD3H/L04ukU/Xrjq27KNf0ldFMi4sMxNf8ACQM
X-Gm-Gg: AZuq6aI29dUYwE+0Gtwf0/+y0137CI5DtqSFPS4QZ6HJevK3PV82tfF3Y80aWniWwql
	GcVRfgldkzVqQ7kSZxEfZLA+zecyCC/3piQAOQgpVVA0N62Gq7oot6KUdwYjQoD1KK+KtvbpItr
	L6OSCPwuB7SDYRS0SCMWBzVfve+p1rMDXox3g2Cfdo1Z7wJUMjIKqdUQpJVViBsG7grgsXEiHoh
	FLFay8jXL3w1nq7w0iZgTCsAf91td4jWNhnHmANQUCBBrPa/yAw5NwLwyceNSA4SeOj1ka3jsXJ
	af0ppF3d0T/DcVpZCQA1vpe6NNYNWwnYeQyBM5ATURefImXpvMlq6KDVeLq7E2S51PPiPRCT8YK
	BpZO90IinF3A8awwhcuMbXxtnekAZvvK66NxN2m1sUOfgZCyeDW+NH55wXeT/OI+jH0+VwCzEtg
	maeCQ6qYEMfhEosmJoyYibNoeRz+xEWg0ayH79iH+svCR23Igp134c+PrPxqPC2fw=
X-Received: by 2002:a05:7022:6b85:b0:124:9acd:32d1 with SMTP id a92af1059eb24-1272f73bb5dmr311282c88.9.1770846048437;
        Wed, 11 Feb 2026 13:40:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f5e:c935:ddee:63d0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a636095sm3392820c88.0.2026.02.11.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 13:40:48 -0800 (PST)
Date: Wed, 11 Feb 2026 13:40:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [RFT PATCH v2] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <aYz2_pE53G67vv0v@google.com>
References: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
 <213b82de-fee8-4ebf-a8ee-d8ca783ce403@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213b82de-fee8-4ebf-a8ee-d8ca783ce403@app.fastmail.com>

On Wed, Feb 11, 2026 at 05:31:52PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 11, 2026, at 14:13, Bartosz Golaszewski wrote:
> > Currently the board file for Nokia 770 creates dummy software nodes not
> > attached in any way to the actual GPIO controller devices and uses the
> > fact that GPIOLIB matching swnode's name to the GPIO chip's label during
> > software node lookup. This behavior is wrong and we want to remove it.
> > To that end, we need to first convert all existing users to creating
> > actual fwnode links.
> >
> > Create real software nodes for GPIO controllers on OMAP16xx and
> > reference them from the software nodes in the nokia board file.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> 
> I don't see mistakes here, and I don't want to throw a wrench in
> this patch, but I wonder if there is a way to take this one step further:
> 
> > @@ -244,6 +263,14 @@ static int __init omap16xx_gpio_init(void)
> >  		iounmap(base);
> > 
> >  		platform_device_register(omap16xx_gpio_dev[i]);
> > +
> > +		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
> > +					       omap16xx_gpio_swnodes[i]);
> > +
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Failed to add software node.\n");
> > +			return ret;
> > +		}
> 
> I was planning to go through the remaining 'static struct platform_device'
> definitions in arch/arm/ after the planned board file removal and
> try to convert these to 'platform_device_info' or similar, using
> platform_device_register_full(). Since that function already contains
> code to dynamically allocate the software_node, I had hoped that
> a lot of this would just go away.
> 
> However, I see that your patch creates pointers to those software_node
> instances, so  think that would become a bit harder, but I have not
> actually tried it.
> 
> Do you know if there is a good way to do this without using static
> platform devices?

I wonder if something like below will help reducing boilerplate...

Thanks.

-- 
Dmitry


driver core: platform: allow attaching software nodes when creating devices

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Extend platform_device_info structure with ian optional pointer to a
software node to be used as a secondary firmware node for the device
being created. If software node has not been registered yet it will be
automatically registered.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/platform.c         |   15 ++++++++++-----
 include/linux/platform_device.h |   23 ++++++++++++-----------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 09450349cf32..2abacdf714d6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -809,6 +809,9 @@ struct platform_device *platform_device_register_full(
 	int ret;
 	struct platform_device *pdev;
 
+	if (pdevinfo->swnode && pdevinfo->properties)
+		return ERR_PTR(-EINVAL);
+
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
 	if (!pdev)
 		return ERR_PTR(-ENOMEM);
@@ -824,17 +827,19 @@ struct platform_device *platform_device_register_full(
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}
 
-	ret = platform_device_add_resources(pdev,
-			pdevinfo->res, pdevinfo->num_res);
+	ret = platform_device_add_resources(pdev, pdevinfo->res, pdevinfo->num_res);
 	if (ret)
 		goto err;
 
-	ret = platform_device_add_data(pdev,
-			pdevinfo->data, pdevinfo->size_data);
+	ret = platform_device_add_data(pdev, pdevinfo->data, pdevinfo->size_data);
 	if (ret)
 		goto err;
 
-	if (pdevinfo->properties) {
+	if (pdevinfo->swnode) {
+		ret = device_add_software_node(&pdev->dev, pdevinfo->swnode);
+		if (ret)
+			goto err;
+	} else if (pdevinfo->properties) {
 		ret = device_create_managed_software_node(&pdev->dev,
 							  pdevinfo->properties, NULL);
 		if (ret)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..ef5b882d08e0 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -117,21 +117,22 @@ extern int platform_get_irq_byname_optional(struct platform_device *dev,
 extern int platform_add_devices(struct platform_device **, int);
 
 struct platform_device_info {
-		struct device *parent;
-		struct fwnode_handle *fwnode;
-		bool of_node_reused;
+	struct device *parent;
+	struct fwnode_handle *fwnode;
+	bool of_node_reused;
 
-		const char *name;
-		int id;
+	const char *name;
+	int id;
 
-		const struct resource *res;
-		unsigned int num_res;
+	const struct resource *res;
+	unsigned int num_res;
 
-		const void *data;
-		size_t size_data;
-		u64 dma_mask;
+	const void *data;
+	size_t size_data;
+	u64 dma_mask;
 
-		const struct property_entry *properties;
+	const struct software_node *swnode;
+	const struct property_entry *properties;
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
