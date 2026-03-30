Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7D3A4518
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880363; cv=none; b=V8O18bsZFejDkGG/Z4vK9PvePgZhadY4WfhWOq5l7HA6MenslVxUMELQ/74TWGJmqoEm4h8LEMjOF44L9zXxcBucfwvufE/2G9Yryps+KJee7mkVj9W/FAltmc4BXEa7/C1wfJ3dYfldi71gsEsLaR2Rv3Jdwy8x1FdCCW5M6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880363; c=relaxed/simple;
	bh=jKPl7vLvqPt4L8fZQsfb39R9t7tBQznk82n5HFjIulw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtmj80EBrQupsRguU22JkscdF13KIvWKqrhwkqVuhLD8VCuq5dwuHi0reO9/Kmx0f2ghl2z6cY1veEPwg8OOfMScIF+PWTceuotPRdT0qVXeYT+rp5kVrHQMfFqYCUrGjSdc2k+dhRLHw/GZMOtDoOiGiWco8LRVDwkFvjZCmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL25BcqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL25BcqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3CAC2BCB6
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880362;
	bh=jKPl7vLvqPt4L8fZQsfb39R9t7tBQznk82n5HFjIulw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BL25BcqCDMG25fw/wVsiojhvGXgPIqTZWewqcjhAAxT3uAzbAkj7BZBpbIdLjl4sR
	 rCPNnZDrLQqnjaLrfZVVQlBLzW/VimcouO8ihTGQrD3NIfEX83Nw/Cya1TO7XgnxIz
	 Q6FQ00ZD9Fu/sK2YoNhgTInSQgBsXuFdYC5OWTAOsCw1nkTq0nX65W2gDY/fiPgPTR
	 ogUNAlH86GJd0zm7kTkvf20W0yHCCPlwDUj/0ZmdhZCM3WjZSC2NZu9ZiSwH7V9D0A
	 8i84wUpKG7pbL0IcouaHmXJwa33t2NX208fzkdmaspWP48Lj7jI9uc3FS08O05QM5w
	 9hk2SJWlpiisA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38ad12fb595so46401311fa.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 07:19:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlKskbgz7p7yHHHlj5Do4yLiGeyH0u6wxny7BUocYPHwXo4g5CkwuuUut21LBI437K5zgvllzMz1zO@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTQzcmfciPr6/rprlwPvTZSx5SGvOaoHt638hIjbmaH35DXqm
	WNtA37NDJ3fr+Y/8lKaf8rv4Q5poRzgJBYWU7x/mf/Lt53g98T2wlbzA3npQYYkgaxyTa07+Qhd
	lz227G/y1j/qsXFuiRhlVjeyKlShyE/Zvpaf9JQw2qg==
X-Received: by 2002:a05:651c:1b12:b0:38b:f0f0:e39b with SMTP id
 38308e7fff4ca-38c75c5ef7emr42861941fa.10.1774880361407; Mon, 30 Mar 2026
 07:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-1-b68592e977d0@oss.qualcomm.com> <DHG5WQI26R5U.WTZW61VKJHF5@kernel.org>
In-Reply-To: <DHG5WQI26R5U.WTZW61VKJHF5@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 30 Mar 2026 16:19:08 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf3oWtrcdR+g69b8y4K-gwfMe+3LNMYQ6c6M-hw3Nh+Hw@mail.gmail.com>
X-Gm-Features: AQROBzCFGjEJDyJGQ7QpuD7sAKfwUgETi1l52lFJ9qTeAWzKycqIShS33NqMS2A
Message-ID: <CAMRc=Mf3oWtrcdR+g69b8y4K-gwfMe+3LNMYQ6c6M-hw3Nh+Hw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kernel: ksysfs: initialize kernel_kobj earlier
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Mar 30, 2026 at 2:40 PM CEST, Bartosz Golaszewski wrote:
> > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> > index c8219505a79f98bc370e52997efc8af51833cfda..71b9086621c35b7e4ef99b9=
d3b6707db23faf58c 100644
> > --- a/include/linux/kobject.h
> > +++ b/include/linux/kobject.h
> > @@ -219,4 +219,6 @@ int kobject_synth_uevent(struct kobject *kobj, cons=
t char *buf, size_t count);
> >  __printf(2, 3)
> >  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ..=
.);
> >
> > +void ksysfs_init(void);
>
> NIT: I'm aware there's also all the core kobjects in include/linux/kobjec=
t.h,
> but maybe a separate header would be a better fit.

Do you mean moving all the top-level kobject declarations
(kernel_kobj, firmware_kobj, etc.) out of kobject.h into this new
header (ksysfs.h?) along with their init functions?

Bart
