Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BD3F7AB8;
	Thu,  2 Apr 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147953; cv=none; b=oHleBS1CepFHghAp1kmNtbWwfDAlop/fYzccX8tTrcRwfaPKEZq/NIN5Y5GBLnOHHkOI9XFczOpaW22bnhvIXshmOeFVoqoGVClbXLtdD5AoIdYn2ZPHxGibdZOueU0840jd1CMS6FMbSCtT9hJZfTx8CSMye398DBMzcpiJHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147953; c=relaxed/simple;
	bh=/9sVJqbqd5N55bgK+hKxVPxccAtMDky0mqOzEJC8sog=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NuuZvVGGcRnXUt5BPWR7IAtK5c+6k4z+Y3Ce3DAXfijm41Qra89dQpu6GDiM7cJ2rTW8QPJRVLJfqjsW2d2fH95hJAJ2NPBIs+2MThQwpKBPFWwDL8Z3zvh62YF8SMvcotchfVJpkQSwWJ4ZLlgKLWc/angWqDAvfTjR32YSsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy1jCrCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy1jCrCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0489C2BCB0;
	Thu,  2 Apr 2026 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147951;
	bh=/9sVJqbqd5N55bgK+hKxVPxccAtMDky0mqOzEJC8sog=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uy1jCrCUIxHvmyUZs169uxUYSq14obZ67K0G2WOxvXw6Gz7QyijB80FM7Bd8f2gJD
	 zePwAEFKrTHcYOaw5pntNHglRgq0JDYaHZy3u63cTcc0nuc8leJMYsXBlOS7s7ncOA
	 +jyfkVfEO2hWjhrW/C2yRotvHvngghtEEI4GDkrOkiFFkka9eXiR1AX2sm/vv29CWH
	 AUhmmsGrTjj7PEa3WSL5LmuJNsWvUyog7NrU5tJYcdSdCCtGLi7XpjQzwaTqFZAr1g
	 mL8vgdNtb35jk98a87dYW96BHXuvOgKmBJy+sXjU4ZiwbjQyEJLYDA2WSID+qm56Nt
	 b1jZ/1rv++4fQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 18:39:06 +0200
Message-Id: <DHITFGL3J4IE.2WZU3K2CSYL7I@kernel.org>
Subject: Re: [PATCH v5 1/4] kernel: ksysfs: initialize kernel_kobj earlier
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com> <20260402-nokia770-gpio-swnodes-v5-1-d730db3dd299@oss.qualcomm.com>
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-1-d730db3dd299@oss.qualcomm.com>

On Thu Apr 2, 2026 at 4:15 PM CEST, Bartosz Golaszewski wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f258aeeacba184d2025b932d90280cf2aabf4b0..8bc934162e712cf8ddf033e53=
bf3481054cfb7fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7843,6 +7843,7 @@ F:	include/linux/debugfs.h
>  F:	include/linux/device.h
>  F:	include/linux/fwnode.h
>  F:	include/linux/kobj*
> +F:	include/linux/ksysfs.h

Currently, kernel/ksysfs.c is not listed in the driver core entry (it is no=
t in
any entry), but I guess that would make sense.

So, we should probably also add kernel/ksysfs.c. :) But this can be a separ=
ate
patch independent of this series.
