Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FF2E718B;
	Mon, 30 Mar 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881275; cv=none; b=G2QJT04pInBa9Po7+aKA0H6TVKUnTs8j4MBqF72qMC5ya4F8HTmvUYPaNEbLpjnel2q1YRkkyz5pMUafmJNHN1jNHyt0iCDJO80ipm0UmQkIyxrd1vKgyMNHEeGt42klnE146wo39/uUiOUScRUnDJe3mA7dwBQvsq0Sqe9zmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881275; c=relaxed/simple;
	bh=XFbW3OPLdCi1ZAlwx9FYjRr2sYDqqn6iZv2QrJ/mhJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=E6y1EIiEEC2lyF1emZ10y04QLlxDxgHOQO8saiqAD62ApVkO8LkLh1hzuQgyV9k2hYRZ0dYA0N73ttrhoXPn+/cwtLsO1u562rtXyPbCZFmcIkGAAV5TV9gDBHxG1g/yx9/hjey4FTDTkrF1AoEuf2w82HgVeDyk9PlGcEITXmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBGRGKw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBGRGKw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C5C2BCB2;
	Mon, 30 Mar 2026 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881275;
	bh=XFbW3OPLdCi1ZAlwx9FYjRr2sYDqqn6iZv2QrJ/mhJw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=vBGRGKw+SUiNNUtRjzg285uYUGcjD6TH7ycKy/0fbBkHrmLXhvi99srkkaTjbln2E
	 UI9bBZiHwqk6BUsaDrFaPobV8wSiq4vVMScPzSC8dfMKmrba6SUVlJEuRFCYEU7eKS
	 1N9u25lynesssKYTydDLvn5sRjWBNkygp18H+TeLlZpArDq/eV62Az4JCxtvR8wpzX
	 wWE+6247OIaoMa+iYaYrk1a9zZXN6QM6laQkqhmVocMKH4pQZBMU1L5ugO5XP3KMjt
	 LpwEDEDZG8lcnCEcOw9lwTpzbfcay+r/FmhN3Je7TFSqaWs6FKwOgdqnzbnN+Ba1lL
	 p02RxQqVMmUgw==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 16:34:29 +0200
Message-Id: <DHG6WEZC6VWG.1B2X6VGTIZZI0@kernel.org>
Subject: Re: [PATCH v4 1/3] kernel: ksysfs: initialize kernel_kobj earlier
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Arnd Bergmann" <arnd@arndb.de>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>
To: "Bartosz Golaszewski" <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com> <20260330-nokia770-gpio-swnodes-v4-1-b68592e977d0@oss.qualcomm.com> <DHG5WQI26R5U.WTZW61VKJHF5@kernel.org> <CAMRc=Mf3oWtrcdR+g69b8y4K-gwfMe+3LNMYQ6c6M-hw3Nh+Hw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf3oWtrcdR+g69b8y4K-gwfMe+3LNMYQ6c6M-hw3Nh+Hw@mail.gmail.com>

On Mon Mar 30, 2026 at 4:19 PM CEST, Bartosz Golaszewski wrote:
> On Mon, Mar 30, 2026 at 3:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Mon Mar 30, 2026 at 2:40 PM CEST, Bartosz Golaszewski wrote:
>> > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
>> > index c8219505a79f98bc370e52997efc8af51833cfda..71b9086621c35b7e4ef99b=
9d3b6707db23faf58c 100644
>> > --- a/include/linux/kobject.h
>> > +++ b/include/linux/kobject.h
>> > @@ -219,4 +219,6 @@ int kobject_synth_uevent(struct kobject *kobj, con=
st char *buf, size_t count);
>> >  __printf(2, 3)
>> >  int add_uevent_var(struct kobj_uevent_env *env, const char *format, .=
..);
>> >
>> > +void ksysfs_init(void);
>>
>> NIT: I'm aware there's also all the core kobjects in include/linux/kobje=
ct.h,
>> but maybe a separate header would be a better fit.
>
> Do you mean moving all the top-level kobject declarations
> (kernel_kobj, firmware_kobj, etc.) out of kobject.h into this new
> header (ksysfs.h?) along with their init functions?

I think the top-level kobjects are fine; it's just ksysfs_init() that someh=
ow
feels odd to me being placed in kobject.h.

The top-level kobject do make sense as they are the base for a lot of other
kobjects being created by other core code.

Whereas ksysfs_init() is a ksysfs specific thing that is only ever used by
init/main.c, i.e. other than the top-level kobjects, it has nothing to do w=
ith
the kobject API itself.
