Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735CF2DCF67;
	Mon, 30 Mar 2026 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878479; cv=none; b=DrbNnDpYc4+AZ+cFCqKZtIUhWPtaZho0Zm7YENvus3BqtH90Vqa9dlRzfQ/j1oOAsSz7YjAbPeVyWn23vr1vSG6mKxwYOmXFMyrlqMu3tmIM6srNPKTFUVwHkIBpnqH9p1oyDpXvI9tcbLKK5WwQ+FmNklxXALBwi0eOkkDcV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878479; c=relaxed/simple;
	bh=4HWngODzhwNimgKwWfcRLqmqV+gsxSnsNR2bNYJtCnY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=NqHbpUrbfIWCZrvXTeFSxG0eDKdMn6zHOOh2QRic69wiPq2JwCJMBEgmiENB7NrvSaXu2ZhAP5z2PcnCNTuSD0CFj0Gf4SbnOwiMVTrPcqBdys8qyC92ainVJjnhZ4knOxg1AAJMY+OZ4tHN+NwVOEGDzeQZTzrlEcVZEjb2bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1/zwihM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1/zwihM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1F2C4CEF7;
	Mon, 30 Mar 2026 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774878479;
	bh=4HWngODzhwNimgKwWfcRLqmqV+gsxSnsNR2bNYJtCnY=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=E1/zwihM+sttFZGmZX09B5wZ3pRgOhu57TF/VAcFy/o8XuVyMibyvYFbqUI5tnrt9
	 Up6mCERLdsi7+g7yAgd2X+OgkGkVXxPxlqAv3RkQkUSuToIOAN6pWAu5Uo9AtzVZWb
	 2qMyjNq/wBE9CgHU5jdLQOTxiXGiE1UVfOgxHEgrIzdEluVabyLwJd8hffpplTn0MN
	 HZaTDH9kwcN06nHoqVx+Rvj1atZPk/w3VhFX3YBXfdlEE87ev8sJGrZ5dDWQRL1tSh
	 1bl9kTCAOJtIloVrxMzWLUxn8cUTNYSNaBgpWr8fFUlFdiy+vryDSxaythfTOX1lt4
	 1m+BJpItHjojQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 15:47:53 +0200
Message-Id: <DHG5WQI26R5U.WTZW61VKJHF5@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/3] kernel: ksysfs: initialize kernel_kobj earlier
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Arnd Bergmann" <arnd@arndb.de>, <brgl@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com> <20260330-nokia770-gpio-swnodes-v4-1-b68592e977d0@oss.qualcomm.com>
In-Reply-To: <20260330-nokia770-gpio-swnodes-v4-1-b68592e977d0@oss.qualcomm.com>

On Mon Mar 30, 2026 at 2:40 PM CEST, Bartosz Golaszewski wrote:
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index c8219505a79f98bc370e52997efc8af51833cfda..71b9086621c35b7e4ef99b9d3=
b6707db23faf58c 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -219,4 +219,6 @@ int kobject_synth_uevent(struct kobject *kobj, const =
char *buf, size_t count);
>  __printf(2, 3)
>  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)=
;
> =20
> +void ksysfs_init(void);

NIT: I'm aware there's also all the core kobjects in include/linux/kobject.=
h,
but maybe a separate header would be a better fit.
