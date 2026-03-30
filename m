Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEC3A6EEA
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907212; cv=none; b=AurBuDDpxqjJ5o3SadREuYD+1WrwMSallsFJhUJaMS480KEsDMt8HoB93cx8hML4dQXtfKxFjMLHDWCbKYJMcH2VZ/GkmDg4WenwzBVxxBXTF2auo5JD0zbJ4M3r+fUDudx+DlQbD5bGaxvCoQjF2Ty1hT5rGmgGUGifo6aZKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907212; c=relaxed/simple;
	bh=H6TjEPdSZGIipXDhaHlw3GjgyD8b6HCnTcEmbY8Pw/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUWy2o159m4dHCxc22C7f4uqOZnahvUQzQqjEKK5yDC5iNZfcSJnMQgIm0LBkJBE9i6B32UU61drndM5V2VKiHFw7CdDfwpqpCy1ljDRLCa8Q0fJBfN6wRneGWfUuUMLMFldEJE9O/xp1Y8JTtuACtli588rS/D+9zv1fa1ZmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIIPSnF5; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIIPSnF5"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c17446ba8dso3085815eec.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907210; x=1775512010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/4gRi5RHE4lEQNk8r3GZP5jsAjQXbbb0ZHPhMUySrM=;
        b=DIIPSnF5M6TJOXjmgABD26oMcLvEltvmnX/nc5atQExOQErENo8AJz4eSwwLhzbkjb
         ZrrUdvmWVOfwTEROGD8Nn+ktUwLj8OFElNWqxIDhwLpvC3Z1lCoMkexe/elFnX1R1kni
         t+Mt3Wv9O/sFFkH0HButc+y5m/DCxqtr3ZgYvtvXSD43gE5JIwDuzBBSkYjuHuwHLmXa
         8zJVaR8xnjD4pNC+BxJ6Dzerese1rdIQ8e+cRUS1/jvGU31GCeWBAXgyWDeT26Ik3tGJ
         VdPB990Z8hU0Whvu0u9MrPn+drJyFqpG6bQHH93YRiJBVnDS5P1uK1tXa9LcSJuzENjl
         7Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907210; x=1775512010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/4gRi5RHE4lEQNk8r3GZP5jsAjQXbbb0ZHPhMUySrM=;
        b=gP44VNYzvJY4XLM/AW6y21WtOnCu/kHRnExAVxxhvDDE9UsDd4CCwCavXI6n9wlUUx
         PSPdKrrlur+y9KMJ/WLaJJWAHNAqEFR9su6EOpA2uNtLUnj199JHYJ3xpMq+sI8i2I/A
         dqsmEqWaOKJYvbAxm0s7lZovLKzSp39i1ljUHFcRxm91lUZB3gOgr7UtzPiNYlGV9kUt
         LZQs7pKsN3uAfRKqOJ1EDgjvOwB0P0W/OpypfL2VdkIvkpWH57ZBI4IX2WauYnPCnhe8
         UzwW1vW6fRz+6/T3N9oo8+hdalX/5+TaXPHu//Mgf2RsyfNMpKsO/BR691c6bNwHTAh6
         wrfA==
X-Forwarded-Encrypted: i=1; AJvYcCVyJa0j6rLdvF97Lh6xhsnuE10OG/BVES7wR1hts3eNeaMbxD+ZbWuMWMtVLC4Cu/ZTK0arYpLsmPEv@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWIaLqdczvUdppUWqowBoehYoClerQcXKS/xChPCwycTKAaPA
	RR+nCDsQlTKkMKdIdMQKrQP4Nn82+HtAfCc77n6zE4Pqrv6QkL+oXhb4
X-Gm-Gg: ATEYQzw/nHAv9OOuDZJbK+Loi70I9NUtOe7Zg6UuSsUZJNyDWatPDNOfX4xZr/qAsM+
	gyzLVbWAYNEhrby6avvxosgOioGrVxWLEP5k9Ds8QQCXuyqvq8plRXc7hVYzwRQ2/uhMkFdAZp6
	pnmfRVyZd5sbsUx9bm/pBopRdo9BJUdQaBSgO3GxN6k5hR2Dhy/BgiHNaOfWQE6GAuUJ11q0yNd
	XlBx0qOi14tltKlm8lVMCNDQN0dkjjTZQKYVJ9NKRCa855tzV6pXjHm328CdGCpeSqGEaiT6Iv+
	H62mKBJLxEJDcXT6A565S9KMN6mnc3bK2T64mAA70CFGiXVGdnaSLVkv/A9qdLZmiJsR5MNNJIC
	HW+JCggtMrkjl4zJ4YnwPT89bLAqvcvC7TkIi0DivPVxNiv29ueW0sWtoQfZ276aD9aF/mq4NSt
	880ha1Iw+8//QLG72BvWJWt2kyirve/ybDcFQ9NfnZM+8O0rNCNeY1NXzqGeo07MA3
X-Received: by 2002:a05:7301:1f17:b0:2c5:d833:a507 with SMTP id 5a478bee46e88-2c7bc35b062mr700637eec.12.1774907210198;
        Mon, 30 Mar 2026 14:46:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7f4e:2749:b37a:e9d5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2721sm7751610eec.14.2026.03.30.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:46:49 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:46:45 -0700
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
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
Message-ID: <acruxMNdnUlyRHiy@google.com>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
 <acrcDTPpXZ_5A4D8@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrcDTPpXZ_5A4D8@ashevche-desk.local>

On Mon, Mar 30, 2026 at 11:24:45PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2026 at 02:40:47PM +0200, Bartosz Golaszewski wrote:
> > Software nodes are currently initialized in a function registered as
> > a postcore_initcall(). However, some devices may want to register
> > software nodes earlier than that (or also in a postcore_initcall() where
> > they're at the merci of the link order). Move the initialization to
> > driver_init() making swnode available much earlier as well as making
> > their initialization time deterministic.
> 
> ...
> 
> > -static void __exit software_node_exit(void)
> > -{
> > -	ida_destroy(&swnode_root_ids);
> > -	kset_unregister(swnode_kset);
> >  }
> > -__exitcall(software_node_exit);
> 
> 
> Why? What's wrong with the __exitcall?
> 

It's dead code. Always was, always will be.

Maybe split in a separate patch, but I sometimes feel the idea of "one
change" is taken to extreme and adds to both developer's and maintainers
burden by needing to keep track of extra patches.

Thanks.

-- 
Dmitry
